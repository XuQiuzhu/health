<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>注册</title>
<%@include file="../common/common.jsp"%>
<style type="text/css">
	input{
                border: 1px solid #ccc;
                padding: 7px 0px;
                border-radius: 3px;
                padding-left:5px;
                margin-bottom:18px;
                width: 200%;
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
    .gender{
	    			border: 1px solid #ccc;
	                padding: 7px 0px;
	                border-radius: 3px;
	                padding-left:5px;
	                margin-bottom:18px;
	                width: 200%;
	                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
	                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
	                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s		
    }
    .login{
    				text-align:center;
    				margin-top:3%;
		    }   
    .subBtn{
    				background-color: white;
				    color: black;
				    border: 2px solid #008CBA; /* Green */
				    padding: 15px 32px;
				    text-align: center;
				    text-decoration: none;
				    width: 90%;
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
	
	.infoTable tr{
					text-align:center;
	}
</style>
</head>
<body>
	<div class="login">
		<form id="registerInfo" style="margin: 0 35%;">
			<table class="infoTable">
					<tr>
						<td>手机号</td><td><input type="text" name="PHONE"/></td>
					</tr>
					<tr>
						<td>昵称</td><td><input type="text" name="NICKNAME"/></td>
					</tr>
					<tr>
						<td>性别</td><td><select class="gender" name="GENDER">
						  <option value ="0">男</option>
						  <option value ="1">女</option>
						  </select>
						</td>
					</tr>
					<tr>
						<td>邮箱</td><td><input type="text" name="EMAIL"/></td>
					</tr>
					<tr>
						<td>密码</td><td><input type="text" name="PASSWORD"/></td>
					</tr>
					<tr>
						<td>真实姓名</td><td><input type="text" name="DOCNAME"/></td>
					</tr>
					<tr>
						<td>年龄</td><td><input type="text" name="SELFAGE"/></td>
					</tr>
					<tr>
						<td>医院</td><td><input type="text" name="HOSPITAL"/></td>
					</tr>
					<tr>
						<td>科室</td><td><input type="text" name="DEPARTMENT"/></td>
					</tr>
				</table>  
		    <input type="button" class="subBtn" onclick="register()" value="注册">                                    
		</form>
		<a onclick="" class="register" href="<%=basePath%>/docLoginController/toDocLoginPage.do">已有账号？点击登录</a>
	</div>
</body>
<script type="text/javascript">
	function register(){
		var form= $("#registerInfo");
		var isValid = $(form).form('validate');	
		if(isValid){
			var data = ns.serializeObject(form);//获取表单所有的name值
			$.ajax({
				type : 'post',
				url : basePath+'/docLoginController/docRegister.do',
				data :{"data":JSON.stringify(data)},
				dataType : 'json',
				success : function(result) {
					$.messager.alert('提示','注册成功，返回登录！','info',function () {
						window.location.href = "<%=basePath%>/docLoginController/toDocLoginPage.do";
			        });
					
				},error:function(){
					$.messager.alert('提示','系统异常','error');
				}
			});
		}
	}
</script>
</html>