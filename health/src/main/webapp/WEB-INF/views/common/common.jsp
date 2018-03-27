<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ct" value="${pageContext.request.contextPath}"></c:set>
<script src="${ct}/plugin/jquery-easyui-1.5.4.2/jquery.min.js"></script>
<script src="${ct}/plugin/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript">
	var basePath='${ct}';//当前路径
	var PAGE_SIZE="10";//分页数据条数
</script>
