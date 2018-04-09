<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>健康数据</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'条件过滤',collapsed:false" style="height:80px;">
			<form id="searchHealthDataForm" style="margin-top: 10px;">
				<table>
					<tr>
						<td>时间</td><td><input class="easyui-datebox" id="begin_createtime" name="BEGIN_CREATETIME"></input>&nbsp;至&nbsp;
						<input class="easyui-datebox" id="end_createtime" name="END_CREATETIME"></input></td>
						<td>
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser();return false;">过滤</a> 
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="resetSearch()">重置</a> 
						</td>
					</tr>
				</table>
		</form>
			
		</div>  
    	<div data-options="region:'center'">  
        	<table id="healthDataGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var healthDataGrid;
$(document).ready(function(){
	loadHealthData();
});

function loadHealthData(){
	var form= $("#searchHealthDataForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.UUID = "${USERUUID}";
		healthDataGrid = $('#healthDataGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	    	//pageList:[10,20,30,40,50],
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        //data :{"data":JSON.stringify(data)},
	        //dataType : 'json',
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/docTreatUserController/healthDataLook.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'HEARTRATE', title : '心率', width : 130},
	                {field : 'HIGHPRESSURE', title : '高压', width : 130},
	                {field : 'LOWPRESSURE', title : '低压', width : 130},
	                {field : 'BLOODSUGAR', title : '血糖', width : 130},
	                {field : 'BLOODLIPID', title : '血清甘油三酯', width : 130},
	                {field : 'HIGHCHOLESTEROL', title : '高密度脂蛋白胆固醇', width : 130},
	                {field : 'CHOLESTEROL', title : '血清总胆固醇', width : 130},
	                {field : 'TRIOXYPURINE', title : '尿酸', width : 130},
	                {field : 'TEMPERATURE', title : '体温', width : 128},
	                {field : 'CREATETIME', title : '创建日期', width : 160}
	               
	            ]
	        ]
	    },ns.datagridOptions));
	}
}

//根据时间搜索
function searchUser(){
	loadHealthData();
}

function resetSearch(){
	$("#begin_createtime").val("");
	$("#end_createtime").val("");
}

</script>
</html>