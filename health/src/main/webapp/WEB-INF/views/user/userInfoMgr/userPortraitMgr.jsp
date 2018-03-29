<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>头像管理</title>
<%@include file="../../common/common.jsp"%>
<style type="text/css">
	#touxiangPic{
		height:100px;
	}
</style>
</head>
<body>
<div>
	<div id="pics">
    	<img id="touxiangPic" src="#">
    </div>
    <label>头 像</label><input id="fileField" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/>
    <button type="button" class=""  onclick="uploadUserPro()" >上传</button>
</div>
</body>
<script type="text/javascript">
$(function(){
	getPro();
});

function getPro(){
	$.ajax({
		type : 'post',
		url : basePath+'/UserInfoMgrController/getPro.do',
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

function uploadUserPro(){     
	  var uploadEventFile = $("#fileField").val();  
      if(uploadEventFile == '' || null == uploadEventFile){  
          alert("请选择图片,再上传");  
      }else if(uploadEventFile.lastIndexOf(".jpg")<0 && uploadEventFile.lastIndexOf(".JPG")<0){
          alert("只能上传图片");  
      }else{
          var url = basePath+'/UserInfoMgrController/uploadUserPro.do';  
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
</script>
</html>