<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="../common/common.jsp"%>
</head>
<body>
	<div class="easyui-layout" id="main_layout">
		<div id="tittle" region="north" title="个人健康助手" style="padding:2px;">
		</div>
		<div region="west" split="true" title="菜单" style="width:12%;">
			<div title="菜单">
				<ul id="meunTree" class="easyui-tree">
					<!-- <li>
						<span>菜单</span>
						<ul>
							<li>
								<span>Sub Folder 1</span>
								<ul>
									<li><span>File 11</span></li>
									<li><span>File 12</span></li>
									<li><span>File 13</span></li>
								</ul>
							</li>
							<li><span>File 2</span></li>
							<li><span>File 3</span></li>
						</ul>
					</li> -->
					<li>
						<span>信息管理</span>
						<ul>
							<li><a onclick="addTab('信息管理','<%=basePath%>UserInfoMgrController/toUserInfoCheckPage.do')">信息管理</a></li>
							<li><a onclick="addTab('头像管理','<%=basePath%>UserInfoMgrController/toUserPortraitMgrPage.do')">头像管理</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div id="content" region="center" title="">
			<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
				<div title="Home">
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	setLayoutHeight();
});
function setLayoutHeight() {
    var height = $(window).height() - 20;
    $("#main_layout").attr("style", "width:100%;height:" + height + "px");
    $("#main_layout").layout("resize", {
        width: "100%",
        height: height + "px"
    });
}
function addTab(title, url){
	if ($('#tt').tabs('exists', title)){
		$('#tt').tabs('select', title);
	} else {
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('#tt').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
}
</script>
</html>