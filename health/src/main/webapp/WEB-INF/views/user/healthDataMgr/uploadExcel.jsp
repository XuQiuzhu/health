<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	
<div class="easyui-panel" data-options="fit:true,border:false">
	<p class="daorut">导入文件：(支持2003、2007版excel)</p>
	<div class = "mydiv">
	<form action="<%=basePath%>ImpExcel/ImpExcelTest.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>上传附件：<input type="file" id="fileField" name="uploadExcel" style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/></td>
			</tr>
		</table>
		<p style="padding:0px;padding-left:30px;margin:0px;color:red;font-size:12px;">文件大小不超过20M!</p>
  	</form>
  	<!-- <button type="button" class=""  onclick="uploadExcel()" >上传</button> -->
	</div>
</div>
</body>
<script>
	function submitData($uploadExcelDialog,$healthDataGrid,$pjq){
	        var uploadEventFile = $("#fileField").val();  
	        if(uploadEventFile == ''){  
	            alert("请选择excel,再上传");  
	        }else if(uploadEventFile.lastIndexOf(".xls")<0){//可判断以.xls和.xlsx结尾的excel  
	            alert("只能上传Excel文件");  
	        }else{
	            var url = basePath+'/ImpExcel/ImpExcelTest.do';  
	            //console.info(uploadEventFile);
	            $.ajaxFileUpload({
					type :'post',
					url :url,
					//data : {'flag':flag} ,
					secureuri : false,
					fileElementId : 'fileField',
					dataType : 'json', //返回值类型 一般设置为json
					success : function(data,status) {
						var result = eval('(' + data + ')');
						if(result.success){
							$pjq.messager.alert('成功','excel上传成功','info',function(){
								$uploadExcelDialog.dialog('destroy');
		                        $healthDataGrid.datagrid('reload');
							});
	                    }else{
	                        $pjq.messager.alert('错误',result.msg,'error');
	                    } 
					},
					error : function(result, status, e) {
						$pjq.messager.alert('错误',result.msg,'error'); 
					}
				});
	        }
	}
	</script>
</html>