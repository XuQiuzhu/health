<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false">
		<form id="newDataForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>心率</td><td><input type="number" name="HEARTRATE" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']"/>&nbsp;次/分钟</td>
				</tr>
				<tr>
					<td>高压</td><td><input type="number" name="HIGHPRESSURE" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫米汞柱（mmHg）</td>
				</tr>
				<tr>
					<td>低压</td><td><input type="number" name="LOWPRESSURE" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫米汞柱（mmHg）</td>
				</tr>
				<tr>
					<td>血糖</td><td><input type="number" name="BLOODSUGAR" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫摩尔/升（mmol/L）</td>
				</tr>
				<tr>
					<td>血清甘油三酯</td><td><input type="number" name="BLOODLIPID" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫摩尔/升（mmol/L）</td>
				</tr>
				<tr>
					<td>高密度脂蛋白胆固醇</td><td><input type="number" name="HIGHCHOLESTEROL" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫摩尔/升（mmol/L）</td>
				</tr>
				<tr>
					<td>血清总胆固醇</td><td><input type="number" name="CHOLESTEROL" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;毫摩尔/升（mmol/L）</td>
				</tr>
				<tr>
					<td>尿酸</td><td><input type="number" name="TRIOXYPURINE" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;微摩尔/升（umol/L）</td>
				</tr>
				<tr>
					<td>体温</td><td><input type="number" name="TEMPERATURE" class="easyui-validatebox" data-options="required:true,validType:['length[0,10]']"/>&nbsp;摄氏度（℃）</td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>
	function submitData($addDataDialog,$healthDataGrid,$pjq){
        var form= $("#newDataForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
            $.ajax({
                type : 'post',
                url : basePath+'/HealthDataMgrController/addData.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $addDataDialog.dialog('destroy');
                        $healthDataGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','新增数据失败','error');
                    }
                }
            });
        }
	}
	</script>
</html>