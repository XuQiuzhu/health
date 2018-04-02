<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>预约历史</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'条件过滤',collapsed:false" style="height:80px;">
			<form id="searchForm" style="margin-top: 10px;">
				<table>
					<tr>
						<td>医生姓名:</td>
						<td><input id="docname" name="DOCNAME" class="easyui-textbox" width="50px"></td>
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
        	<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
		    <div title="已提交" data-options="closable:false">
				<table id="submitedGrid"></table>
		    </div>
		    <div title="待诊断" data-options="closable:false">
				<table id="waitDiagnoseGrid"></table>
		    </div>
		    <div title="待评价" data-options="closable:false">
				<table id="waitJudgeGrid"></table>
		    </div>
		    <div title="已评价" data-options="closable:false">
				<table id="judgedGrid"></table>
		    </div>
		    <div title="被拒绝" data-options="closable:false">
				<table id="refusedGrid"></table>
		    </div>
</div>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var submitedGrid;
var waitDiagnoseGrid;
var waitJudgeGrid;
var judgedGrid;
var refusedGrid;
$(document).ready(function(){
	loadSubmitedData();
	$('#tt').tabs({
	    border:false,
	    onSelect:function(title){
			if(title == "已提交"){
				loadSubmitedData();
			}
			if(title == "待诊断"){
				waitDiagnoseData();
			}
			if(title == "待评价"){
				waitJudgeData();
			}
			if(title == "已评价"){
				judgedData();
			}
			if(title == "被拒绝"){
				refusedData();
			}
	    }
	});
});

//已提交
function loadSubmitedData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "submited";
		submitedGrid = $('#submitedGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getSubscribeHis.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 80},
	                {field : 'DEP_NAME', title : '科室', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-edit',
	            text : '修改',
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
	            text : '撤销',
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

//待诊断
function waitDiagnoseData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "waitDiagnose";
		waitDiagnoseGrid = $('#waitDiagnoseGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getSubscribeHis.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 80},
	                {field : 'DEP_NAME', title : '科室', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        //toolbar : []
	
	    },ns.datagridOptions));
	}
}

//待评价
function waitJudgeData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "waitJudge";
		waitJudgeGrid = $('#waitJudgeGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getSubscribeHis.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 80},
	                {field : 'DEP_NAME', title : '科室', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-tip',
	            text : '诊断详情',
	            handler : function(){
	            	var select = waitJudgeGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	diagnoseDetailDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-edit',
	            text : '评价',
	            handler : function(){
					var select = waitJudgeGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	doJudgeDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        }]
	
	    },ns.datagridOptions));
	}
}
//已评价
function judgedData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "judged";
		judgedGrid = $('#judgedGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getSubscribeHis.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 80},
	                {field : 'DEP_NAME', title : '科室', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-tip',
	            text : '诊断详情',
	            handler : function(){
	            	var select = judgedGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	diagnoseDetailDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        }/* ,{
	            iconCls : 'icon-tip',
	            text : '评价详情',
	            handler : function(){
					var select = docInfoGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	judgeDetailDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        } */]
	
	    },ns.datagridOptions));
	}
}//被拒绝
function refusedData(){
	var form= $("#searchForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		data.TYPE = "refused";
		refusedGrid = $('#refusedGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getSubscribeHis.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 80},
	                {field : 'DEP_NAME', title : '科室', width : 80},
	                {field : 'DESCRIPTION', title : '描述', width : 1100},
	                {field : 'CREATETIME', title : '创建时间', width : 150}
	            ]
	        ],
	        //toolbar : []
	
	    },ns.datagridOptions));
	}
}

//根据时间搜索
function searchUser(){
	var pp = $('#tt').tabs('getSelected');
	var title = pp.panel('options').title;
	if(title == "已提交"){
		loadSubmitedData();
	}
	if(title == "待诊断"){
		waitDiagnoseData();
	}
	if(title == "待评价"){
		waitJudgeData();
	}
	if(title == "已评价"){
		judgedData();
	}
	if(title == "被拒绝"){
		refusedData();
	}
}

function resetSearch(){
	$("#docname").val("");
	$("#level_begin").val("");
	$("#level_end").val("");
}

function modifySubDialog(select){
	var submitedDialog =  parent.ns.modalDialog({
        title : '修改预约单',
        width : 350,
        height : 300,
        url : basePath+'/UserChooseDocController/toModifySub.do?UUID='+select.UUID,
        buttons : [{
            text : '确定',
            iconCls : 'icon-save',
            handler : function(){
            	submitedDialog.find('iframe').get(0).contentWindow.submitData(submitedDialog,submitedGrid,parent.$,select.UUID);
            }
        }]
    });
}

function deleteSubDialog(select){
	$.messager.confirm('确认','确认删除预约单?',function(r){  
	    if (r){ 
	     	var data = {};
	     	data.UUID = select.UUID;
	     	//console.info(select.UUID);
			$.ajax({
	                type : 'post',
	                url : '${ct}/UserChooseDocController/deleteSub.do',
	                data :{"data":JSON.stringify(data)},
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	submitedGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	submitedGrid.datagrid('reload');
	                    }else{
	                       parent.$.messager.alert('错误','删除预约单失败','error');
	                    }
	                }
			});
	    }  
	});
}
//诊断详情
function diagnoseDetailDialog(select){
	var judgedDialog =  parent.ns.modalDialog({
        title : '诊断详情',
        width : 350,
        height : 300,
        url : basePath+'/UserChooseDocController/toDiagnoseDetail.do?UUID='+select.UUID/* ,
        buttons : [{
            text : '确定',
            iconCls : 'icon-save',
            handler : function(){
            	judgedDialog.find('iframe').get(0).contentWindow.submitData(judgedDialog,judgedGrid,parent.$,select.UUID);
            }
        }] */
    });
}

//评价
function doJudgeDialog(select){
	var doJudgeDialog =  parent.ns.modalDialog({
        title : '修改预约单',
        width : 350,
        height : 300,
        url : basePath+'/UserChooseDocController/toJudge.do?UUID='+select.UUID,
        buttons : [{
            text : '确定',
            iconCls : 'icon-save',
            handler : function(){
            	doJudgeDialog.find('iframe').get(0).contentWindow.submitData(doJudgeDialog,waitJudgeGrid,parent.$,select.UUID);
            }
        }]
    });
}

</script>
</html>