<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>修改预约单</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false" style="text-align: center;">
		<form id="modifySubForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td><input type="hidden" name="UUID" value="${subInfo.UUID}" class="easyui-validatebox" data-options="required:true,validType:['length[1,100]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>医生姓名</td><td><input type="text" name="DOCNAME" value="${subInfo.DOCNAME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,30]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>类型</td><td><input id="type" name="TYPE"  value="${subInfo.DEP_NAME}" class="easyui-combobox" width="50px" data-options="required:true" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>问题描述</td><td><input  type="text" name="DESCRIPTION" value="${subInfo.DESCRIPTION}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>

$(document).ready(function(){
});

	function submitData($submitedDialog,$submitedGrid,$pjq,UUID){
        var form= $("#modifySubForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.UUID = UUID;
            $.ajax({
                type : 'post',
                url : basePath+'/UserChooseDocController/modifySub.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $submitedDialog.dialog('destroy');
                        $submitedGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','修改数据失败','error');
                    }
                }
            });
        }
	}
	</script>
</html>