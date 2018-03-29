<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ct" value="${pageContext.request.contextPath}"></c:set>

<script src="${ct}/plugin/jquery-easyui-1.5.4.2/jquery.min.js"></script>
<script src="${ct}/plugin/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
<script src="${ct}/plugin/jquery-easyui-1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
<script src="${ct}/plugin/Highcharts-6.0.7/code/highcharts.js"></script>
<link rel="stylesheet" href="${ct}/plugin/jquery-easyui-1.5.4.2/themes/gray/easyui.css" id="swicth-style">
<%-- <link rel="stylesheet" href="${ct}/businessConsole/css/style.css"> --%>


<link rel="stylesheet" href="${ct}/plugin/jquery-easyui-1.5.4.2/themes/icon.css">
<script src="${ct}/plugin/javascript/extEasyui.js"></script>
<script src="${ct}/plugin/javascript/extJquery.js"></script>
<script src="${ct}/plugin/javascript/jquery.cookie.js"></script>
<script src="${ct}/plugin/javascript/json2.js"></script>
<script src="${ct}/plugin/ajaxfileupload.js"></script>
<script src="${ct}/plugin/javascript/jquery.timelinr.js"></script>
<script src="${ct}/plugin/javascript/arithmetic.js"></script>        
<script>
	var basePath='${ct}';//当前路径
	var PAGE_SIZE="10";//分页数据条数
	$(document).ready(function(){
		resize();
	});
	//页面刷新时，重新获取页面高度
	function resize(){
		var target=$("#content");
        if(target.attr("value")=="true"){
			var width=$(window).width();//浏览器高度
	        var height=$(window).height();//浏览器宽度
        	$("#content").width(width-20);
        	$("#content").height(height-5);
        	$("#content .list").width(width-330);
		    $("#content .leftMenu").height(height);
		    $("#content .list").height(height);
		    $("#content .easyui-tree").height(height-100);
        }
	}
	
	 //文件上传 支持ie6
    //fileId上传空间id,filePath上传路径
	function uploadFiles(fileId,filePath,type)
	{
	    var fileName = $("#"+fileId).val();
	    if(null == fileName && "" == fileName)
	    {
	    	$.messager.alert("提示", '请选择要上传的文件', "info");
			return;
	    }
	    if(type)
	    {
	       //图片以外的格式 先不做限制
	       
	    }else{
	       //默认type没有，默认就是图片格式，支持jpg,png,bmp
	       	var fileNameindex = fileName.lastIndexOf(".");
			if (fileNameindex < 0) {
				$.messager.alert("提示", '请上传jpg、png、bmp格式的文件', "info");
				return;
			} else {
				var ext = fileName.substring(fileNameindex + 1, fileName.length);
				ext = ext.toUpperCase();
				if (ext != "JPG" && ext != "PNG" && ext != "BMP") {
					$.messager.alert("提示", '请上传jpg、png、bmp格式的文件', "info");
					return;
				}
			}
	       
	    }
		$.ajaxFileUpload({
				url : basePath+'/upload.tool?wjjDm='+filePath,
				secureuri : false,
				fileElementId : fileId,
				dataType : 'json', //返回值类型 一般设置为json
				success : function(result) {
				$.messager.alert("提示", '上传成功', "info",function(){
				   result = eval('(' + result + ')');
					uploadCallBack(result,fileId);
				});	
				  $(".panel-tool-close").css("display","none");
				},
				error : function(data, status, e) {
					$.messager.alert("提示", '系统异常', "error");	
					$(".panel-tool-close").css("display","none");
				}
		});
	 }
	 //中文加密
	 function URLencoding(sStr){
	 	return encodeURIComponent(sStr);
	 }
	 //解密
	 function  URLdcoding(sStr){
	 	return  decodeURIComponent(sStr);
	 }
</script>
