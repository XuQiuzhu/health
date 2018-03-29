<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>信息修改</title>
<%@include file="../../common/common.jsp"%>
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
    .gender{
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
    .login{
    				/* text-align:center; */
    				margin-left:25%;
    				margin-top:5%;
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
		<form id="userInfo">  
		            真实姓名: <input id="username" type="text" name="USERNAME"/><br />  
		            昵称: <input id="nickname" type="text" name="NICKNAME"/><br />
		            手机号: <input id="phone" type="text" name="PHONE" readonly="readonly"/><br />
		            性别: <select id="gender" class="GENDER" style="width:20%;height:30px;padding-left:5px;margin-bottom:18px;">
					  <option value ="0">男</option>
					  <option value ="1">女</option>
					</select><br/> 
		            年龄: <input id="selfage" type="text" name="SELFAGE"/><br />
		            邮箱: <input id="email" type="text" name="EMAIL"/><br />
		            出生日期: <input class="easyui-datebox" id="born_date" name="BORN_DATE"></input><br />
		    <input type="button" class="subBtn" onclick="updateInfo()" value="确认修改" style="margin-left:5%;margin-top:18px">                                    
		</form>
	</div>
</body>
<script type="text/javascript">
$(function(){
	loadUserInfo();
});
function loadUserInfo(){
		$.ajax({
			type : 'post',
			url : basePath+'/UserInfoMgrController/getUserInfo.do',
			dataType : 'json',
			success : function(result) {
				$("#username").val(result.USERNAME);
				$("#nickname").val(result.NICKNAME);
				$("#phone").val(result.PHONE);
				$("#gender").val(result.GENDER);
				$("#selfage").val(result.SELFAGE);
				$("#email").val(result.EMAIL);
				$("#born_date").val(result.BORN_DATE);
				//myformatter(result.BORN_DATE);
			},error:function(){
				$.messager.alert('提示','系统异常','error');
			}
		});
}
/* function myformatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
} */
function updateInfo(){
	var form= $("#userInfo");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = ns.serializeObject(form);//获取表单所有的name值
		$.ajax({
			type : 'post',
			url : basePath+'/UserInfoMgrController/updateUserInfo.do',
			data :{"data":JSON.stringify(data)},
			dataType : 'json',
			success : function(result) {
				if(result.result == "success"){
					$.messager.alert('提示','修改成功！','info',function () {
						window.location.href = basePath+'/UserInfoMgrController/toUserInfoCheckPage.do';
			        });
				}else{
					$.messager.alert('提示','系统异常','error');
				}
			},error:function(){
				$.messager.alert('提示','系统异常','error');
			}
		});
	}
}
</script>
</html>