<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>预约</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'条件过滤',collapsed:false" style="height:80px;">
			<form id="searchForm" style="margin-top: 10px;">
				<table>
					<tr>
						<td>患者姓名:</td>
						<td><input id="username" name="USERNAME" class="easyui-textbox" width="50px"></td>
						<td>预约时间:</td>
						<td>
							<input class="easyui-datebox" id="begin_createtime" name="BEGIN_CREATETIME"></input>&nbsp;至&nbsp;
							<input class="easyui-datebox" id="end_createtime" name="END_CREATETIME"></input>
						</td>
						<td>
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser();return false;">过滤</a> 
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="resetSearch()">重置</a> 
						</td>
					</tr>
				</table>
		</form>
			
		</div>  
    	<div data-options="region:'center'">  
				<table id="submitedGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var submitedGrid;
$(document).ready(function(){
	loadSubmitedData();
	
});
//已提交
function loadSubmitedData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		//data.TYPE = "submited";
		submitedGrid = $('#submitedGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/docTreatUserController/getSubscribeReq.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'USERNAME', title : '患者姓名', width : 80},
	                {field : 'DEP_NAME', title : '类型', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-edit',
	            text : '接受预约',
	            handler : function(){
	            	var select = submitedGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	modifySubDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-remove',
	            text : '拒绝预约',
	            handler : function(){
					var select = submitedGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	deleteSubDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        }]
	
	    },ns.datagridOptions));
	}
}
//根据时间搜索
function searchUser(){
		loadSubmitedData();
}

function resetSearch(){
	$("#username").val("");
	$("#level_begin").val("");
	$("#level_end").val("");
}

function modifySubDialog(select){
	$.messager.confirm('确认','确认接受预约?',function(r){  
	    if (r){ 
	     	var data = {};
	     	data.UUID = select.UUID;
	     	data.type = "receive";
	     	//console.info(select.UUID);
			$.ajax({
	                type : 'post',
	                url : '${ct}/docTreatUserController/manageSubscribe.do',
	                data :{"data":JSON.stringify(data)},
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	submitedGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	submitedGrid.datagrid('reload');
	                    }else{
	                       parent.$.messager.alert('错误','预约单处理失败','error');
	                    }
	                }
			});
	    }  
	});
}

function deleteSubDialog(select){
	$.messager.confirm('确认','确认拒绝预约?',function(r){  
	    if (r){ 
	     	var data = {};
	     	data.UUID = select.UUID;
	     	//console.info(select.UUID);
	     	data.type = "refuse";
			$.ajax({
	                type : 'post',
	                url : '${ct}/docTreatUserController/manageSubscribe.do',
	                data :{"data":JSON.stringify(data)},
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	submitedGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	submitedGrid.datagrid('reload');
	                    }else{
	                       parent.$.messager.alert('错误','预约单处理失败','error');
	                    }
	                }
			});
	    }  
	});
}
</script>
</html>