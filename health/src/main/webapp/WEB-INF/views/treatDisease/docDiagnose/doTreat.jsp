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
				<table id="treatGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var treatGrid;
$(document).ready(function(){
	loadTreatData();
	
});
//已提交
function loadTreatData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "treat";
		treatGrid = $('#treatGrid').datagrid($.extend({
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
	                {field : 'USERID', title : 'USERID', hidden : true},
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
	            iconCls : 'icon-print',
	            text : '患者健康数据',
	            handler : function(){
	            	var select = treatGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	healthDataDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-edit',
	            text : '诊断',
	            handler : function(){
					var select = treatGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	docDoTreatDialog(select[0]);
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
	loadTreatData();
}

function resetSearch(){
	$("#username").val("");
	$("#level_begin").val("");
	$("#level_end").val("");
}

function healthDataDialog(select){
	var healthDataDialog =  parent.ns.modalDialog({
        title : '健康数据查看',
        width : 1350,
        height : 600,
        url : basePath+'/docTreatUserController/tohealthDataLook.do?USERID='+select.USERID,
        /* buttons : [{
            text : '确定预约',
            iconCls : 'icon-save',
            handler : function(){
            	buildReservationDialog.find('iframe').get(0).contentWindow.submitData(buildReservationDialog,docInfoGrid,parent.$,select.UUID);
            }
        }] */
    });
}

/* function docDoTreatDialog(select){
	var docDoTreatDialog =  parent.ns.modalDialog({
        title : '诊断',
        width : 400,
        height : 350,
        url : basePath+'/docTreatUserController/toDocDoTreatPage.do?UUID='+select.UUID,
       	buttons : [{
           text : '诊断完成',
           iconCls : 'icon-save',
           handler : function(){
        	   docDoTreatDialog.find('iframe').get(0).contentWindow.submitData(docDoTreatDialog,treatGrid,parent.$,select.UUID);
           }
        }]
    });
} */
function docDoTreatDialog(select){
    var docDoTreatDialog =  parent.ns.modalDialog({
        title : '诊断',
        width : 450,
        height : 420,
        url : basePath+'/docTreatUserController/toDocDoTreatPage.do?UUID='+select.UUID,
        buttons : [{
            text : '诊断完成',
            iconCls : 'icon-save',
            handler : function(){
            	docDoTreatDialog.find('iframe').get(0).contentWindow.submitData(docDoTreatDialog,treatGrid,parent.$,select.UUID);
            }
        }]
    });
}
</script>
</html>