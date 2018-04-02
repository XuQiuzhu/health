<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>添加预约单</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false" style="text-align: center;">
		<form id="buildReservationForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>医生姓名</td><td><input type="text" name="DOCNAME" value="${docInfo.DOCNAME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>类型</td><td><input id="type" name="TYPE" class="easyui-combobox" width="50px" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>问题描述</td><td><input  type="text" name="DESCRIPTION" value="" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']" style="height:100px"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>

$(document).ready(function(){
	getAllDepartment();
});

	function submitData($buildReservationDialog,$docInfoGrid,$pjq,UUID){
        var form= $("#buildReservationForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.docUUID = UUID;
            $.ajax({
                type : 'post',
                url : basePath+'/UserChooseDocController/buildReservation.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $buildReservationDialog.dialog('destroy');
                        $docInfoGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','修改数据失败','error');
                    }
                }
            });
        }
	}
	
	function getAllDepartment(){  
	    $.ajax({
	        url:basePath+'/UserChooseDocController/getDepartment.do',  
	        dataType:"json", 
	        type:"GET",
	        required : true,
	        success:function(data){                                 
	                    //绑定第一个下拉框
	                    $('#type').combobox({
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
	</script>
</html>