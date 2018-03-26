<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    
    <title>My JSP 'impExcel.jsp' starting page</title>
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
  <p class="daorut">导入文件：(支持2003、2007版excel)</p>
<div class="easyui-panel" data-options="fit:true,border:false">
	<div class = "mydiv">
	<form action="<%=basePath%>ImpExcel/ImpExcelTest.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>上传附件：<input type="file" id="fileField" name="uploadExcel" style="width: 230px;" class="easyui-filebox,file" data-options="required:true"/></td>
			</tr>
		</table>
		<p style="padding:0px;padding-left:30px;margin:0px;color:red;font-size:12px;">文件大小不超过20M!</p>
		<!-- <input type="button" id="ctlBtn" class="btn1" onclick="importSrlr()" value="导入"> -->
		<!-- <button type="submit">提交</button> -->
  	</form>
  	<button type="button" class=""  onclick="uploadExcel()" >上传</button>
  	<button type="button" class=""  onclick="ShowExport()" >下载模板</button>
	</div>
</div>
  </body>
  <script type="text/javascript">
  function uploadExcel(){     
	  var location = (window.location+'').split('/'); 
	  var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
         var uploadEventFile = $("#fileField").val();  
        if(uploadEventFile == ''){  
            alert("请选择excel,再上传");  
        }else if(uploadEventFile.lastIndexOf(".xls")<0){//可判断以.xls和.xlsx结尾的excel  
            alert("只能上传Excel文件");  
        }else{
            var url = basePath+'/ImpExcel/ImpExcelTest.do';  
            console.info(uploadEventFile);
            $.ajaxFileUpload({
				type :'post',
				url :url,
				//data : {'flag':flag} ,
				secureuri : false,
				fileElementId : 'fileField',
				dataType : 'json', //返回值类型 一般设置为json
				success : function(result,status) {
					var data = eval('(' + result + ')');
					console.info(data);
					alert(data.result);  
				},
				error : function(result, status, e) {
					alert( "excel上传失败");  
				}
			});
        }  
  
      }  
      
      /**
	   * 导出Excel模板
	   */
function ShowExport(){
	//pageNum=0;
	//var aduitStauts = $("#FLAG").combobox("getValue");
	var location = (window.location+'').split('/'); 
	  var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
	 //var pageName="信息导入模板.zip";
	 //var datas = {"dep":dep,"PROPOSAL_NO":PROPOSAL_NO,"PROPOSAL_CATE":PROPOSAL_CATE,"filepath":filepath,"PROCESS_NO":PROCESS_NO,"TASK_NO":TASK_NO};
	 $.ajax({
        type : 'post',
        url:basePath+'/ImpExcel/ExportModelExcel.do',
        //data :{'data':JSON.stringify(datas)},
        //dataType : 'json',
        success : function(data) {
         data = eval('(' + data + ')');
          if (data.success) {
		     window.location.href = basePath+'/ImpExcel/downloadTask.do?filepath='+ data.msg;
          } else {
         	 alert(data.msg);
          }
         }
    }); 
}
  </script>
</html>
