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
    				margin-left:5%;
    				margin-top:5%;
		    }  
	.touxiang{
					margin-left:50%;
    				margin-top:5%;
    				float:right;
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
	#touxiangPic{
		height:100px;
	}
</style>
</head>
<body>
<div class="login">
		<form id="docInfo">  
		            真实姓名: <input id="docname" type="text" name="DOCNAME" readOnly="readonly"/><br />  
		            昵称: <input id="nickname" type="text" name="NICKNAME"/><br />
		            手机号: <input id="phone" type="text" name="PHONE" readonly="readonly"/><br />
		            性别: <select id="gender" class="GENDER" style="width:20%;height:30px;padding-left:5px;margin-bottom:18px;">
					  <option value ="0">男</option>
					  <option value ="1">女</option>
					</select><br/> 
		            年龄: <input id="selfage" type="text" name="SELFAGE"/><br />
		            邮箱: <input id="email" type="text" name="EMAIL"/><br />
		            医院: <input id="hospital" type="text" name="HOSPITAL"/><br />
		            科室: <input id="department" type="text" name="DEPARTMENT"/><br />
		            简介: <input id="tip" type="text" name="TIP"/><br />
		            
		    <input type="button" class="subBtn" onclick="updateInfo()" value="确认修改" style="margin-left:5%;margin-top:18px">                                    
		</form>
</div>
<div>
	<button class="subBtn" onclick="cancellation()">注销账号</button>
</div>
<div class="touxiang">
	<div id="pics">
    	<img id="touxiangPic" src="#">
    </div>
    <label>头 像</label><input id="fileField" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/>
    <button type="button" class=""  onclick="uploadDocPro()" >上传</button>
</div>
</body>


<script type="text/javascript">
$(function(){
	loadDocInfo();
	getDocPro();
	getAllDepartment();
});
function loadDocInfo(){
		$.ajax({
			type : 'post',
			url : basePath+'/DocInfoMgrController/getDocInfo.do',
			dataType : 'json',
			success : function(result) {
				$("#docname").val(result.DOCNAME);
				$("#nickname").val(result.NICKNAME);
				$("#phone").val(result.PHONE);
				$("#gender").val(result.GENDER);
				$("#selfage").val(result.SELFAGE);
				$("#email").val(result.EMAIL);
				$("#hospital").val(result.HOSPITAL);
				$("#department").val(result.DEPARTMENT);
				$("#tip").val(result.TIP);
				//myformatter(result.BORN_DATE);
			},error:function(){
				$.messager.alert('提示','系统异常','error');
			}
		});
}
function updateInfo(){
	var form= $("#docInfo");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = ns.serializeObject(form);//获取表单所有的name值
		$.ajax({
			type : 'post',
			url : basePath+'/DocInfoMgrController/updateDocInfo.do',
			data :{"data":JSON.stringify(data)},
			dataType : 'json',
			success : function(result) {
				if(result.result == "success"){
					$.messager.alert('提示','修改成功！','info',function () {
						window.location.href = basePath+'/DocInfoMgrController/toDocInfoCheckPage.do';
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
function getDocPro(){
	$.ajax({
		type : 'post',
		url : basePath+'/DocInfoMgrController/getDocPro.do',
		dataType : 'json',
		success : function(result) {
			if(result.PORTRAIT != null){
				$("#touxiangPic").attr('src',basePath+result.PORTRAIT);
			}
		},error:function(){
			$.messager.alert('提示','头像加载失败','error');
		}
	});
}

function uploadDocPro(){     
	  var uploadEventFile = $("#fileField").val();  
      if(uploadEventFile == '' || null == uploadEventFile){  
          alert("请选择图片,再上传");  
      }else if(uploadEventFile.lastIndexOf(".jpg")<0 && uploadEventFile.lastIndexOf(".JPG")<0){
          alert("只能上传图片");  
      }else{
          var url = basePath+'/DocInfoMgrController/uploadDocPro.do';  
          //console.info(uploadEventFile);
          $.ajaxFileUpload({
				type :'post',
				url :url,
				secureuri : false,
				fileElementId : 'fileField',
				dataType : 'json', //返回值类型 一般设置为json
				success : function(result,status) {
					var data = eval('(' + result + ')');
					$("#touxiangPic").attr('src',basePath+data.path);
				},
				error : function(result, status, e) {
					alert( "头像上传失败");  
				}
			});
      }  

    }  
    
function getAllDepartment(){  
    $.ajax({
        url:basePath+'/UserChooseDocController/getDepartment.do',  
        dataType:"json", 
        type:"GET",
        required : true,
        success:function(data){                                 
                    //绑定第一个下拉框
                    $('#department').combobox({
                            data: data,                        
                            valueField: 'DEP_CODE',
                            textField: 'DEP_NAME'}
                            );                       
       },
       error:function(error){
           alert("初始化下拉控件失败");
       }
    })
}
function cancellation(){
	$.messager.confirm('确认','注销后将不能登录，确认注销账户吗?',function(r){  
	    if (r){ 
	    	window.location.href="<%=basePath%>docLoginController/cancellation.do";
	    }  
	}); 
}
</script>
</html>