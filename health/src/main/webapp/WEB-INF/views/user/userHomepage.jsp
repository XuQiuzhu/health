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
							<%-- <li><a onclick="addTab('头像管理','<%=basePath%>UserInfoMgrController/toUserPortraitMgrPage.do')">头像管理</a></li> --%>
						</ul>
					</li>
					<li>
						<span>健康数据</span>
						<ul>
							<li><a onclick="addTab('健康数据','<%=basePath%>HealthDataMgrController/toHealdataPage.do')">健康数据</a></li>
							<li><a onclick="addTab('图表查看','<%=basePath%>HealthDataMgrController/toUserDataChartsPage.do')">图表查看</a></li>
						</ul>
					</li>
					<li>
						<span>线上诊断</span>
						<ul>
							<li><a onclick="addTab('医生列表','<%=basePath%>UserChooseDocController/toDocListPage.do')">医生列表</a></li>
							<li><a onclick="addTab('预约历史','<%=basePath%>UserChooseDocController/toSubscribeHis.do')">预约历史</a></li>
							<%-- <li><a onclick="addTab('诊断历史','<%=basePath%>HealthDataMgrController/toUserDataChartsPage.do')">诊断历史</a></li> --%>
						</ul>
					</li>
					<li>
						<span>疾病预测</span>
						<ul>
							<li><a onclick="addTab('自助预测','<%=basePath%>DiseasePredictionController/toDiseasePredictionPage.do')">自助预测</a></li>
							<%-- <li><a onclick="addTab('预约历史','<%=basePath%>UserChooseDocController/toSubscribeHis.do')">预约历史</a></li> --%>
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