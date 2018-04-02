<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>医生列表</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'条件过滤',collapsed:false" style="height:80px;">
			<form id="searchDocForm" style="margin-top: 10px;">
				<table>
					<tr>
						<td>科室:</td>
						<td><input id="department" name="DEPARTMENT" class="easyui-combobox" width="50px"></td>
						<td>评分:</td>
						<td><input id="level_begin" name="LEVEL_BEGIN" class="easyui-combobox" width="50px">&nbsp;至&nbsp;
							<input id="level_end" name="LEVEL_END" class="easyui-combobox" width="50px">
						</td>
						<td>
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser();return false;">过滤</a> 
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="resetSearch();return false;">重置</a> 
						</td>
					</tr>
				</table>
		</form>
			
		</div>  
    	<div data-options="region:'center'">  
        	<table id="docInfoGrid"></table>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">
var docInfoGrid;
$(document).ready(function(){
	loadDocData();
	getAllDepartment();
	loadLevel();
});

function loadDocData(){
	var form= $("#searchDocForm");
	var isValid = $(form).form('validate');	
	if(isValid){
		var data = {};
		data = ns.serializeObject(form);
		docInfoGrid = $('#docInfoGrid').datagrid($.extend({
			pagination:true,
			pageSize:10,
	    	//pageList:[10,20,30,40,50],
	        singleSelect : true,
	        striped:true,
	        loadMsg:"正在加载中......",
	        //data :{"data":JSON.stringify(data)},
	        //dataType : 'json',
	        queryParams: { 'data': JSON.stringify(data) },
	        url : basePath+'/UserChooseDocController/getAllDocs.do',
	        frozenColumns : [
	            [
	                {field : 'UUID', title : 'UUID', hidden : true},
	            ]
	        ],
	        columns : [
	            [
	                {field : 'DOCNAME', title : '医生姓名', width : 130},
	                {field : 'NICKNAME', title : '昵称', width : 130},
	                //{field : 'PHONE', title : '手机号', width : 130},
	                {field : 'GENDER', title : '性别', width : 130},
	                {field : 'SELFAGE', title : '年龄', width : 130},
	                //{field : 'EMAIL', title : '电子邮箱', width : 130},
	                //{field : 'PORTRAIT', title : '头像', width : 130},
	                {field : 'TIP', title : '简介', width : 130},
	                {field : 'DEPARTMENT', title : '科室', width : 128},
	                {field : 'HOSPITAL', title : '医院', width : 160},
	                {field : 'LEVEL', title : '综合评分', width : 160}
	            ]
	        ],
	        toolbar : [{
	            iconCls : 'icon-tip',
	            text : '查看',
	            handler : function(){
	            	var select = docInfoGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	DocInfoDetailDialog(select[0]);
	                }else{
	                    parent.$.messager.alert('错误', '请选择一条数据', 'error');
	                }
	            }
	        },{
	            iconCls : 'icon-add',
	            text : '预约',
	            handler : function(){
					var select = docInfoGrid.datagrid('getSelections');
	                if(select && 1 == select.length){
	                	buildReservationDialog(select[0]);
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
	loadDocData();
}

function resetSearch(){
	$("#department").val("");
	$("#level_begin").val("");
	$("#level_end").val("");
}

function buildReservationDialog(select){
    var buildReservationDialog =  parent.ns.modalDialog({
        title : '新增预约单',
        width : 350,
        height : 300,
        url : basePath+'/UserChooseDocController/tobuildReservation.do?UUID='+select.UUID,
        buttons : [{
            text : '确定预约',
            iconCls : 'icon-save',
            handler : function(){
            	buildReservationDialog.find('iframe').get(0).contentWindow.submitData(buildReservationDialog,docInfoGrid,parent.$,select.UUID);
            }
        }]
    });
}

function DocInfoDetailDialog(select){
	
}

function getAllDepartment(){  
    $.ajax({
        url:basePath+'/UserChooseDocController/getDepartment.do',  
        dataType:"json", 
        type:"GET",
        /* data:{
            "type":"audit_state"        
        }, */
        success:function(data){                                 
                    //绑定第一个下拉框
                    $('#department').combobox({
                            data: data,                        
                            valueField: 'DEP_CODE',
                            textField: 'DEP_NAME'}
                            );                       
       },
       error:function(error){
           alert("初始化下拉控件失败");
       }
    })
}
    
function loadLevel() {
 data = [ {
  "Name" : "0",
  "Value" : 0
 }, {
  "Name" : "1",
  "Value" : 1
 } , {
  "Name" : "2",
  "Value" : 2
 }, {
  "Name" : "3",
  "Value" : 3
 }, {
  "Name" : "4",
  "Value" : 4
 }, {
  "Name" : "5",
  "Value" : 5
 }];
 $('#level_begin').combobox({
	  valueField : 'Value',
	  textField : 'Name',
	  panelHeight : 'auto',
	  //required : true,
	  //editable : false,// 不可编辑，只能选择
	  data : data
	 });
 $('#level_end').combobox({
	  valueField : 'Value',
	  textField : 'Name',
	  panelHeight : 'auto',
	  //required : true,
	  //editable : false,// 不可编辑，只能选择
	  data : data
	 });
 //$('#' + comboid).combobox('select', "1");
}

</script>
</html>