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
		<div data-options="region:'north',title:'条件过滤',collapsed:true" style="height:80px;overflow: hidden;">
			<form id="searchHealthDataForm" style="margin-top: 10px;">
			<table>
				<tr>
					<td>时间</td><td><input class="easyui-datebox" id="begin_createtime" name="BEGIN_CREATETIME"></input>至
					<input class="easyui-datebox" id="end_createtime" name="END_CREATETIME"></input></td>
					<td>
						<a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser()">过滤</a> 
						<a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser()">重置</a> 
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
	healthDataGrid = $('#healthDataGrid').datagrid($.extend({
        singleSelect : true,
        striped:true,
        loadMsg:"正在加载中......",
        //idField:'jsDm',
        url : basePath+'/HealthDataMgrController/getHealthData.do',
        frozenColumns : [
            [
                {field : 'UUID', title : 'UUID', hidden : true},
            ]
        ],
        columns : [
            [
                {field : 'HEARTRATE', title : '心率', width : 120},
                {field : 'HIGHPRESSURE', title : '高压', width : 120},
                {field : 'LOWPRESSURE', title : '低压', width : 120},
                {field : 'BLOODSUGAR', title : '血糖', width : 120},
                {field : 'BLOODLIPID', title : '血清甘油三酯', width : 120},
                {field : 'highcholesterol', title : '高密度脂蛋白胆固醇', width : 120},
                {field : 'CHOLESTEROL', title : '血清总胆固醇', width : 120},
                {field : 'TRIOXYPURINE', title : '尿酸', width : 120},
                {field : 'TEMPERATURE', title : '体温', width : 120},
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
            	var select = roleGrid.datagrid('getSelections');//选择的角色
            	
                if(select && 1 == select.length){
                	showModifyRoleDialog(select[0]);
                }else{
                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
                }
            }
        },{
            iconCls : 'icon-remove',
            text : '删除数据',
            handler : function(){
            	var select = roleGrid.datagrid('getSelections');//选择的角色
            	
                if(select){
                	deleteRoles(select);
                }else{
                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
                }
            }
        }]

    },ns.datagridOptions));
}

//根据时间搜索
function searchUser(){
	var form= $("#searchHealthDataForm");
	var data = ns.serializeObject(form); 
	userGrid.datagrid('load',data);
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

function showModifyRoleDialog(select){
	 var roleDialog =  parent.ns.modalDialog({
         title : '编辑角色',
         width : 340,
         height : 300,
         url : '${ct}/businessConsole/role/modifyRole.do?jsDm='+select.jsDm,
         buttons : [{
             text : '保存',
             iconCls : 'icon-save',
             handler : function(){
                 roleDialog.find('iframe').get(0).contentWindow.submitRole(roleDialog,roleGrid,parent.$,select.jsDm);
             }
         }]
     });
}


function showMenuGrantToRoleDialog(selectRole){
    var menuToRoleDialog =  parent.ns.modalDialog({
        title : '菜单授权--' + selectRole.jsMc,
        width : 340,
        height : 300,
        url : '${ct}/businessConsole/role/menuGrantToRole.do?roleId='+selectRole.jsDm,
        buttons : [{
            text : '授权',
            iconCls : 'icon-save',
            handler : function(){
                menuToRoleDialog.find('iframe').get(0).contentWindow.submitMenuToRole(menuToRoleDialog,parent.$);
            }
        }]

    });
}

function showUserGrantToRoleDialog(selectRole){
    var userToRoleDialog =  parent.ns.modalDialog({
        title : '用户授权--' + selectRole.jsMc,
        width : 860,
        height : 390,
        url : '${ct}/businessConsole/role/userGrantToRole.do?roleId='+selectRole.jsDm,
        buttons : [{
            text : '授权',
            iconCls : 'icon-save',
            handler : function(){
                userToRoleDialog.find('iframe').get(0).contentWindow.submitUserToRole(userToRoleDialog,parent.$);
            }
        }]

    });
}

function deleteRoles(checkRoles){
	$.messager.confirm('确认','确认删除角色?',function(r){  
	    if (r){  
	     	var roleDms = [];
	     	for(var i =0 ;i <checkRoles.length;i++ ){
	    		
	     		roleDms.push(checkRoles[i].jsDm);
	     	}
	     	
	     	var data = {};
	     	data.roleDms = roleDms.join(',');
	     	
			$.ajax({
	                type : 'post',
	                url : '${ct}/businessConsole/role/deleteRoles.do',
	                data :data,
	                dataType : 'json',
	                success : function(result) {
	                    if(result.success){
	                    	roleGrid.datagrid('clearSelections').datagrid('clearChecked');
	                    	roleGrid.datagrid('reload');
	                    }else{
	                       parent.$.messager.alert('错误','删除用户失败','error');
	                    }
	                }
			});
	    }  
	}); 
}
</script>
</html>