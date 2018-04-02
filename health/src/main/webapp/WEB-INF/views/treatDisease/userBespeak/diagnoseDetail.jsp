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
		<form id="diagnoseDetailForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>类型</td><td><input id="type" name="TYPE"  value="${diaInfo.DEP_NAME}" class="easyui-combobox" width="50px" data-options="required:true" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>症状描述</td><td><input  type="text" name="DESCRIPTION" value="${diaInfo.DESCRIPTION}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>诊断内容</td><td><input type="text" name="DOCNAME" value="${diaInfo.CONTENT}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>医生姓名</td><td><input type="text" name="DOCNAME" value="${diaInfo.DOCNAME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>诊断时间</td><td><input type="text" name="CREATETIME" value="${diaInfo.CREATETIME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>

</html>