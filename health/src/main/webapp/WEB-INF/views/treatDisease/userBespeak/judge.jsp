<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>诊断详情</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false" style="text-align: center;">
		<form id="feedbackForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>类型</td><td><input id="type" name="TYPE"  value="${diaInfo.DISEASETYPE_NAME}" class="easyui-combobox" width="50px" data-options="required:true" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>症状描述</td><td><input  type="text" name="DESCRIPTION" value="${diaInfo.DESCRIPTION}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>诊断内容</td><td><input type="text" name="CONTENT" value="${diaInfo.CONTENT}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>医生姓名</td><td><input type="text" name="DOCNAME" value="${diaInfo.DOCNAME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>诊断时间</td><td><input class="easyui-datebox" id="CREATETIME" name="CREATETIME" value="${diaInfo.CREATETIME}" readonly="readonly"></input></td>
				</tr>
				<tr>
					<td>评分（满分5）</td><td><input id="satisfaction" name="SATISFACTION" class="easyui-combobox" width="50px" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>评价</td><td><input type="text" id="comment" name="COMMENT" class="easyui-textbox" data-options="multiline:true,validType:['length[0,200]']" style="height:100px"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	loadSatisfaction();
});

function submitData($doJudgeDialog,$waitJudgeGrid,$pjq){
    var form= $("#feedbackForm");
    var isValid = $(form).form('validate');
    if(isValid){
    	var data = ns.serializeObject(form);//获取表单所有的name值
    	data.USERID = "${diaInfo.USERID}";
    	data.DOCID = "${diaInfo.DOCID}";
    	data.SUBSCRIBEID = "${diaInfo.SUBSCRIBEID}";
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

function loadSatisfaction() {
	 data = [ {
	  "Name" : "0",
	  "Value" : 0
	 }, {
	  "Name" : "0.5",
	  "Value" : 0.5
	 } , {
	  "Name" : "1",
	  "Value" : 1
	 }, {
	  "Name" : "1.5",
	  "Value" : 1.5
	 }, {
	  "Name" : "2",
	  "Value" : 2
	 }, {
	  "Name" : "2.5",
	  "Value" : 2.5
	 }, {
	  "Name" : "3",
	  "Value" : 3
	 }, {
	  "Name" : "3.5",
	  "Value" : 3.5
	 }, {
	  "Name" : "4",
	  "Value" : 4
	 }, {
	  "Name" : "4.5",
	  "Value" : 4.5
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
}
</script>
</html>