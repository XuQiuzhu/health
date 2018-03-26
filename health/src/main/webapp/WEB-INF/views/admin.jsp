<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <base href="<%=basePath%>">
    
    <title>My JSP 'admin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<c:set var="ct" value="${pageContext.request.contextPath}"></c:set>
	<script src="${ct}/plugin/jquery-easyui-1.5.2/jquery.min.js"></script>
	<script src="${ct}/plugin/jquery-easyui-1.5.2/jquery.easyui.min.js"></script>
	<link rel="stylesheet" href="${ct}/plugin/jquery-easyui-1.5.2/themes/default/easyui.css">
	<link rel="stylesheet" href="${ct}/plugin/jquery-easyui-1.5.2/themes/icon.css">
	
  </head>
  
  <body class="easyui-layout">   
	    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>   
	    <div data-options="region:'west',title:'West',split:true" style="width:150px;">
	    	<div id="left_content" class="easyui-accordion"  data-options="fit:true">
	            <div title="基础数据">
	                <ul class="easyui-tree" data-options="">
	                    <li><a onclick="openTab('title','https://www.baidu.com','icon-reload')" style="text-decoration:none;color:#000000;">组织分解结构</a></li>
	                    <li>岗位分解结构</li>
	                    <li>用户管理</li>
	                </ul>
	            </div>
	            <div title="权限管理">
	                <ul class="easyui-tree" data-options="">
	                    <li>角色管理</li>
	                    <li>用户权限分配</li>
<!-- 	                    <li>
	                        <span>数据权限管理</span>
	                        <ul>
	                            <li>数据权限关联配置</li>
	                            <li>数据权限批量处理</li>
	                        </ul>
	                    </li>
 -->	                </ul>
	            </div>
	            <div title="流程管理">
	                <ul class="easyui-tree" data-options="">
	                    <li>流程预定义</li>
	                    <li>流程监控</li>
	                </ul>
	            </div>
	            <div title="系统集成管理" data-options="">
	                <ul class="easyui-tree">
	                    <li>手动同步数据</li>
	                    <li>数据同步日志</li>
	                </ul>
	            </div>
	   		</div>
	    </div>   
	    <div data-options="region:'center'" style="padding:5px;background:#eee;"><!-- <iframe name="mainiframe" style="width:100%;height:100%"></iframe> -->
		    <div id="mainTab" class="easyui-tabs"  data-options="'border':false,'fit':true">
	            <div title="首页" data-options="closable:false" class="firstPage">
	            	<img src="${ct }/images/hy_03_1.png" id="wclcome" style="width:100%;height:99%;"></img>
	            </div>     
	        </div>
	    </div>   
  </body> 
  <script type="text/javascript">
  	function openTab(title,url,icon){
		if($('#mainTab').tabs('exists',title)){
			$('#mainTab').tabs('select',title);
		}else{
			$('#mainTab').tabs('add',{
		    	title:title,
		    	content:createTabContent(url),
		    	closable:true,
		    	icon:icon
		    });
		}
	}
  </script>
</html>
