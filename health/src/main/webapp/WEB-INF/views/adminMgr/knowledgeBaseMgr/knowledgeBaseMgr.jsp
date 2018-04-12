<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>知识库管理</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'条件过滤',collapsed:false" style="height:80px;">
			<form id="searchKnoledgeDataForm" style="margin-top: 10px;">
				<table>
					<tr>
						<td>关键词</td><td><input class="easyui-datebox" id="keyword" name="KEYWORD"></input></td>
						<td>
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchKnow()">过滤</a> 
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="resetSearch()">重置</a> 
						</td>
					</tr>
				</table>
			</form>
			
		</div>  
    	<div data-options="region:'center'">  
        	<table id="knoledgeDataGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var knoledgeDataGrid;
$(document).ready(function(){
	loadKnowledge();
});

function loadKnowledge(){
	var form= $("#searchKnoledgeDataForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		knoledgeDataGrid = $('#knoledgeDataGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	    	//pageList:[10,20,30,40,50],
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        //data :{"data":JSON.stringify(data)},
	        //dataType : 'json',
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/knowledgeBaseMgr/getKnowledgeData.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'TITTLE', title : '标题', width : 150},
	                {field : 'CONTENT', title : '内容', width : 870},
	                {field : 'KNOWLEDGETYPE_NAME', title : '分类', width : 150},
	                {field : 'CREATETIME', title : '创建日期', width : 160}
	               
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-tip',
	            text : '查看数据',
	            handler : function(){
					var select = knoledgeDataGrid.datagrid('getSelections');
	            	
	                if(select && 1 == select.length){
	                	showLookDataDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-add',
	            text : '新增数据',
	            handler : function(){
	                showAddDataDialog();
	            }
	        },{
	            iconCls : 'icon-edit',
	            text : '编辑数据',
	            handler : function(){
	            	var select = knoledgeDataGrid.datagrid('getSelections');
	            	
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
	            	var select = knoledgeDataGrid.datagrid('getSelections');//选择的角色
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
	            iconCls : 'icon-print',
	            text : '导入模板下载',
	            handler : function(){
	            	showExport();
	            }
	        }]
	
	    },ns.datagridOptions));
	}
}

//根据时间搜索
function searchKnow(){
	loadKnowledge();
}

function resetSearch(){
	$("#keyword").val("");
}

function showAddDataDialog(){
    var addDataDialog =  parent.ns.modalDialog({
        title : '新增数据',
        width : 550,
        height : 380,
        url : basePath+'/knowledgeBaseMgr/toAddDataPage.do',
        buttons : [{
            text : '保存',
            iconCls : 'icon-save',
            handler : function(){
            	addDataDialog.find('iframe').get(0).contentWindow.submitData(addDataDialog,knoledgeDataGrid,parent.$);
            }
        }]
    });
}

function showModifyDataDialog(select){
	 var modifyDataDialog =  parent.ns.modalDialog({
         title : '编辑数据',
         width : 550,
         height : 380,
         url : basePath+'/knowledgeBaseMgr/toModifyData.do?UUID='+select.UUID,
         buttons : [{
             text : '确定',
             iconCls : 'icon-save',
             handler : function(){
            	 modifyDataDialog.find('iframe').get(0).contentWindow.submitData(modifyDataDialog,knoledgeDataGrid,parent.$,select.UUID);
             }
         }]
     });
}

function showUploadExcel(){
	var uploadExcelDialog =  parent.ns.modalDialog({
        title : '批量上传',
        width : 350,
        height : 300,
        url : basePath+'/knowledgeBaseMgr/toUploadExcelPage.do',
        buttons : [{
            text : '确定',
            iconCls : 'icon-excel',
            handler : function(){
            	uploadExcelDialog.find('iframe').get(0).contentWindow.submitData(uploadExcelDialog,knoledgeDataGrid,parent.$);
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
	                url : '${ct}/knowledgeBaseMgr/deleteData.do',
	                data :{"data":JSON.stringify(data)},
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	knoledgeDataGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	knoledgeDataGrid.datagrid('reload');
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