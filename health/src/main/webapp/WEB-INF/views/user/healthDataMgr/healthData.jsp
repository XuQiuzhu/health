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
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser()">过滤</a> 
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
		healthDataGrid = $('#healthDataGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/HealthDataMgrController/getHealthData.do',
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
	        ],
	        toolbar : [{
	            iconCls : 'icon-add',
	            text : '新增数据',
	            handler : function(){
	                showAddDataDialog();
	            }
	        },{
	            iconCls : 'icon-edit',
	            text : '编辑数据',
	            handler : function(){
	            	var select = healthDataGrid.datagrid('getSelections');
	            	
	                if(select && 1 == select.length){
	                	showModifyDataDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-remove',
	            text : '删除数据',
	            handler : function(){
	            	var select = healthDataGrid.datagrid('getSelections');//选择的角色
	            	if(select && 1 == select.length){
	            		deleteData(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-excel',
	            text : '批量导入',
	            handler : function(){
	            		showUploadExcel();
	            }
	        },{
	            iconCls : 'icon-excel',
	            text : '导入模板下载',
	            handler : function(){
	            	showExport();
	            }
	        }]
	
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

function showAddDataDialog(){
    var addDataDialog =  parent.ns.modalDialog({
        title : '新增数据',
        width : 550,
        height : 380,
        url : basePath+'/HealthDataMgrController/toAddData.do',
        buttons : [{
            text : '保存',
            iconCls : 'icon-save',
            handler : function(){
            	addDataDialog.find('iframe').get(0).contentWindow.submitData(addDataDialog,healthDataGrid,parent.$);
            }
        }]
    });
}

function showModifyDataDialog(select){
	 var modifyDataDialog =  parent.ns.modalDialog({
         title : '编辑数据',
         width : 550,
         height : 380,
         url : basePath+'/HealthDataMgrController/toModifyData.do?UUID='+select.UUID,
         buttons : [{
             text : '确定',
             iconCls : 'icon-save',
             handler : function(){
            	 modifyDataDialog.find('iframe').get(0).contentWindow.submitData(modifyDataDialog,healthDataGrid,parent.$,select.UUID);
             }
         }]
     });
}

function showUploadExcel(){
	var uploadExcelDialog =  parent.ns.modalDialog({
        title : '批量上传',
        width : 350,
        height : 300,
        url : basePath+'/HealthDataMgrController/toUploadExcelPage.do',
        buttons : [{
            text : '确定',
            iconCls : 'icon-excel',
            handler : function(){
            	uploadExcelDialog.find('iframe').get(0).contentWindow.submitData(uploadExcelDialog,healthDataGrid,parent.$);
            }
        }]
    });
}

function deleteData(select){
	$.messager.confirm('确认','确认删除数据?',function(r){  
	    if (r){ 
	     	var data = {};
	     	data.UUID = select.UUID;
	     	//console.info(select.UUID);
			$.ajax({
	                type : 'post',
	                url : '${ct}/HealthDataMgrController/deleteData.do',
	                data :{"data":JSON.stringify(data)},
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	healthDataGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	healthDataGrid.datagrid('reload');
	                    }else{
	                       parent.$.messager.alert('错误','删除数据失败','error');
	                    }
	                }
			});
	    }  
	}); 
}


/**
 * 导出Excel模板
 */
function showExport(){
	$.ajax({
		  type : 'post',
		  url:'${ct}/ImpExcel/ExportModelExcel.do',
		  success : function(data) {
			   data = eval('(' + data + ')');
			   //console.info(data);
			   if (data.success) {
				     window.location.href = basePath+'/ImpExcel/downloadTask.do?filepath='+ data.msg;
			   } else {
				   parent.$.messager.alert('错误',data.msg,'error');
			   }
		   }
	 }); 
}
</script>
</html>