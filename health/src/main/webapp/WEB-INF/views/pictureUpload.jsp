<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ct" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'pictureUpload.jsp' starting page</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
	<script src="${ct}/plugin/jquery-easyui-1.5.2/jquery.min.js"></script>
	<script src="${ct}/plugin/jquery-easyui-1.5.2/jquery.easyui.min.js"></script>
	<script src="${ct}/plugin/ajaxfileupload.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  	<label>头 像</label><input id="fileField" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/>
    <!-- <label>头 像</label><input id="fileField1" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/> 
    <label>头 像</label><input id="fileField2" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/>
    <label>头 像</label><input id="fileField3" type="file" name="file"  style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/><br/> --> 
    <button type="button" class=""  onclick="uploadExcel()" >上传</button>
    <div id="pics">
    	<img id="touxiangPic" src="">
    </div>
  </body>
  <script type="text/javascript">
  	function uploadExcel(){     
	  var location = (window.location+'').split('/'); 
	  var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	  //console.info(basePath);
	  var uploadEventFile = $("#fileField1").val();  
        if(uploadEventFile == ''){  
            alert("请选择图片,再上传");  
        }else if(uploadEventFile.lastIndexOf(".jpg")<0){//可判断以.xls和.xlsx结尾的excel  
            alert("只能上传图片");  
        }
         /* var uploadEventFile1 = $("#fileField1").val();  
         var uploadEventFile2 = $("#fileField2").val();  
         var uploadEventFile3 = $("#fileField3").val();  
        if(uploadEventFile1 == '' || uploadEventFile2 == '' || uploadEventFile3 == ''){  
            alert("请选择图片,再上传");  
        }else if(uploadEventFile1.lastIndexOf(".jpg")<0 || uploadEventFile2.lastIndexOf(".jpg")<0 || uploadEventFile3.lastIndexOf(".jpg")<0){//可判断以.xls和.xlsx结尾的excel  
            alert("只能上传图片");  
        } */else{
            var url = basePath+'/ImpExcel/ImpPictureTest.do';  
            //console.info(uploadEventFile);
            $.ajaxFileUpload({
				type :'post',
				url :url,
				//data : {'flag':flag} ,
				secureuri : false,
				fileElementId : 'fileField',
				dataType : 'json', //返回值类型 一般设置为json
				success : function(result,status) {
					var data = eval('(' + result + ')');
					//console.info(data);
					//alert(data.imagesPath);  
					//$.messager.alert('info','上传成功');
					$("#touxiangPic").attr('src',basePath+data.imagesPath);
					/* $.each(data,function(n,value) { 
						var imgs = '';
						imgs += "<img src=\"" + value.imagesPath +"\">"; 
						$("#pics").append(imgs);  
					});  */
				},
				error : function(result, status, e) {
					alert( "excel上传失败");  
				}
			});
        }  
  
      }  
      
  </script>
</html>
