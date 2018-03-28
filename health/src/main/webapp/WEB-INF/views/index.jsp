<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'success.jsp' starting page</title>
    <%@include file="common/common.jsp"%>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.button {
	background-color: white;
    color: black;
    border: 2px solid #008CBA; /* Green */
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
}

.button:hover {
    background-color: #008CBA; /* Green */
    color: white;
}
.choose{
	text-align:center;
    margin-top:10%;
}
</style>
  </head>
  
  <body>
  <div class="choose">
  	<div style="padding-bottom:10px;">
  		<span>请选择您的身份</span>
  	</div>
  	<div>
  		<a class="button" type="button" onclick="" href="<%=basePath%>userLoginController/toLoginPage.do">管理员</a>
	  	<a class="button" type="button" onclick="" href="<%=basePath%>userLoginController/toLoginPage.do">医生</a>
	  	<a class="button" type="button" onclick="" href="<%=basePath%>userLoginController/toLoginPage.do">普通用户</a>
  	</div>
  </div> 
  </body>
  <script type="text/javascript">
  function submitIdentity(identity){
	  var url = basePath;
	  if(identity == 3){
		  url = url+'/userLoginController/toLoginPage.do';
	  }
			$.ajax({
				type : 'post',
				url : url,
				//data :{'data':JSON.stringify(data)},
				//dataType : 'json',
				async:false,
				/* success : function(result) {
				}, */
				error:function(){
					$.messager.alert('提示',"系统错误",'error');
				}
			});
		}
  </script>
</html>
