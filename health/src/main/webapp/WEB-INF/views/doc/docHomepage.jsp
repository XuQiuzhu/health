<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
<%@include file="../common/common.jsp"%>
<style type="text/css">
.loginout{
					background-color: white;
				    color: black;
				    border: 2px solid #008CBA; /* Green */
				    padding: 1px 2px;
				    text-align: center;
				    text-decoration: none;
				    width: 5%;
				    display: inline-block;
				    float:right;
				    margin-right:5px;
				    font-size: 16px;
				    -webkit-transition-duration: 0.4s; /* Safari */
				    transition-duration: 0.4s;
}
.loginout:hover {
				    background-color: #008CBA; /* Green */
				    color: white;
				}
</style>
</head>
<body>
	<div class="easyui-layout" id="main_layout">
		<div id="tittle" region="north" title="" style="padding:0.1px;height:10%">
			<p>个人健康助手
			<button class="loginout" onclick="loginout()">退出</button>
		</div>
		<div region="west" split="true" title="菜单" style="width:12%;">
			<div title="菜单">
				<ul id="meunTree" class="easyui-tree">
					 <li>
						<span>信息管理</span>
						<ul>
							<li><a onclick="addTab('信息管理','<%=basePath%>DocInfoMgrController/toDocInfoCheckPage.do')">信息管理</a></li>
							<%-- <li><a onclick="addTab('头像管理','<%=basePath%>UserInfoMgrController/toUserPortraitMgrPage.do')">头像管理</a></li> --%>
						</ul>
					</li>
					<li>
						<span>操作诊断</span>
						<ul>
							<li><a onclick="addTab('预约请求','<%=basePath%>docTreatUserController/toSubscribeReqPage.do')">预约请求</a></li>
							<li><a onclick="addTab('诊断','<%=basePath%>docTreatUserController/doTreat.do')">诊断</a></li>
							<%-- <li><a onclick="addTab('诊断历史','<%=basePath%>docTreatUserController/toUserDataChartsPage.do')">诊断历史</a></li> --%>
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
function loginout(){
	window.location.href="<%=basePath%>userLoginController/loginout.do";
}
</script>
</html>