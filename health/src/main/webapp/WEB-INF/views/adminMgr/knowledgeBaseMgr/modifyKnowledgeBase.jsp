<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>数据修改</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false">
		<form id="modifyDataForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>标题</td><td><input type="text" name="TITTLE" value="${knowledgeData.TITTLE}" class="easyui-validatebox" data-options="required:true,validType:['length[1,20]']"/></td>
				</tr>
				<tr>
					<td>类型</td><td><input id="classification" name="CLASSIFICATION" value="${knowledgeData.CLASSIFICATION}" class="easyui-combobox" width="50px" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>内容</td><td><input  type="text" name="CONTENT" value="${knowledgeData.CONTENT}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,1000]']" style="height:200px"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
$(document).ready(function(){
	getAllClassification();
});
	function submitData($modifyDataDialog,$knoledgeDataGrid,$pjq,UUID){
        var form= $("#modifyDataForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.UUID = UUID;
            $.ajax({
                type : 'post',
                url : basePath+'/knowledgeBaseMgr/modifyKnowledgeData.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $modifyDataDialog.dialog('destroy');
                        $knoledgeDataGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','修改数据失败','error');
                    }
                }
            });
        }
	}
	function getAllClassification(){  
	    $.ajax({
	        url:basePath+'/knowledgeBaseMgr/getClassification.do',  
	        dataType:"json", 
	        type:"GET",
	        required : true,
	        success:function(data){                                 
	                    //绑定第一个下拉框
	                    $('#classification').combobox({
	                            data: data,                        
	                            valueField: 'KNOWLEDGETYPE_CODE',
	                            textField: 'KNOWLEDGETYPE_NAME'}
	                            );                       
	       },
	       error:function(error){
	           alert("初始化下拉控件失败");
	       }
	    })
	}
	</script>
</html>