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
		<form id="judgeForm" style="margin: 20px 40px;">
			<table>
				<tr >
					<td><input type="hidden" name="SUBSCRIBEID" value="${diaInfo.UUID}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td><input type="hidden" name="DOCID" value="${diaInfo.DOCUUID}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>满意度</td><td><input id="satisfaction" name="SATISFACTION" class="easyui-combobox" width="50px"  data-options="required:true"></td>
				</tr>
				<tr>
					<td>评价</td><td><input  type="text" name="COMMENT" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>

$(document).ready(function(){
	getAllDepartment();
});

	function submitData($doJudgeDialog,$waitJudgeGrid,$pjq,UUID){
        var form= $("#judgeForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.UUID = UUID;
            $.ajax({
                type : 'post',
                url : basePath+'/UserChooseDocController/judge.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $doJudgeDialog.dialog('destroy');
                        $waitJudgeGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','评价失败','error');
                    }
                }
            });
        }
	}
	
	function loadLevel() {
		 data = [ {
		  "Name" : "0",
		  "Value" : 0
		 }, {
		  "Name" : "1",
		  "Value" : 1
		 } , {
		  "Name" : "2",
		  "Value" : 2
		 }, {
		  "Name" : "3",
		  "Value" : 3
		 }, {
		  "Name" : "4",
		  "Value" : 4
		 }, {
		  "Name" : "5",
		  "Value" : 5
		 }];
		 $('#satisfaction').combobox({
			  valueField : 'Value',
			  textField : 'Name',
			  panelHeight : 'auto',
			  //required : true,
			  //editable : false,// 不可编辑，只能选择
			  data : data
			 });
	</script>
</html>