<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../common/common.jsp"%>
<style type="text/css">
	input{
                border: 1px solid #ccc;
                padding: 7px 0px;
                border-radius: 3px;
                padding-left:5px;
                margin-bottom:18px;
                width: 25%;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
            }
    input:focus{
                    border-color: #66afe9;
                    outline: 0;
                    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
                    box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
            }
    .login{
    				text-align:center;
    				margin-top:10%;
		    }   
    .subBtn{
    				background-color: white;
				    color: black;
				    border: 2px solid #008CBA; /* Green */
				    padding: 15px 32px;
				    text-align: center;
				    text-decoration: none;
				    width: 28%;
				    display: inline-block;
				    font-size: 16px;
				    -webkit-transition-duration: 0.4s; /* Safari */
				    transition-duration: 0.4s;
    }   
    .subBtn:hover {
				    background-color: #008CBA; /* Green */
				    color: white;
				}
	.register{
					color: black;
	} 
	.register:hover {
				    color: red;
	}
</style>
</head>
<body>
	<div class="login">
		<form action="Login/YongHuLogin.do" method="post">  
		            账号: <input type="text" name="username" /><br />  
		            密码: <input type="text" name="password" /> <br />  
		    <input type="submit" class="subBtn" value="提交">                                    
		</form>
		<a onclick="" class="register" href="<%=basePath%>userLoginController/toRegisterPage.do">没有账号？点击注册</a>
	</div>
</body>
</html>