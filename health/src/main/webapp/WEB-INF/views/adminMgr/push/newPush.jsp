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
						<td>推送时间:</td>
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
				<table id="pushGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var pushGrid;
$(document).ready(function(){
	loadPushData();
	
});
//已提交
function loadPushData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		treatGrid = $('#pushGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/PushMgrController/getPush.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'CONTENET', title : '内容', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        toolbar : [/* {
	            iconCls : 'icon-print',
	            text : '推送查看',
	            handler : function(){
	            	var select = treatGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	healthDataDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        }, */{
	            iconCls : 'icon-edit',
	            text : '新建推送',
	            handler : function(){
	                	newPush();
	               }
	        }]
	
	    },ns.datagridOptions));
	}
}
//根据时间搜索
function searchUser(){
	loadPushData();
}

function resetSearch(){
	$("#level_begin").val("");
	$("#level_end").val("");
}

/* function pushDataDialog(select){
	var healthDataDialog =  parent.ns.modalDialog({
        title : '推送查看',
        width : 1350,
        height : 600,
        url : basePath+'/docTreatUserController/tohealthDataLook.do?USERID='+select.USERID,
    });
} */

function newPush(){
    var newPushDialog =  parent.ns.modalDialog({
        title : '推送',
        width : 450,
        height : 420,
        url : basePath+'/PushMgrController/toAddANewPushPage.do',
        buttons : [{
            text : '确认推送',
            iconCls : 'icon-save',
            handler : function(){
            	newPushDialog.find('iframe').get(0).contentWindow.submitData(newPushDialog,pushGrid,parent.$);
            }
        }]
    });
}
</script>
</html>