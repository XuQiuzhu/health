<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>诊断</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
	<div  class="easyui-panel" data-options="fit:true,border:false">
		<form id="docDoTreatForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>用户姓名</td><td><input type="text" name="USERNAME" value="${subInfo.USERNAME}" class="easyui-validatebox" data-options="required:true,validType:['length[1,10]']"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>症状描述</td><td><input type="text" name="DESCRIPTION" value="${subInfo.DESCRIPTION}" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,300]']"  readonly="readonly" style="height:100px"/></td>
				</tr>
				<tr>
					<td>日期</td><td><input class="easyui-datebox" id="CREATETIME" name="CREATETIME" value="${subInfo.CREATETIME}" readonly="readonly"></input><br /></td>
				</tr>
				<tr>
					<td>诊断内容</td><td><input type="text" name="CONTENT" value="" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,500]']" style="height:100px"/></td>
				</tr>
				<tr>
					<td>类型</td><td><input id="type" name="DISEASETYPE_CODE" class="easyui-combobox" width="50px" data-options="required:true"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>
$(document).ready(function(){
	getAllDiseasetype();
});
	/* function submitData($docDoTreatDialog,$treatGrid,$pjq,UUID){
        var form= $("#docDoTreatForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.USERID = ${subInfo.USERID};
        	data.DOCID = ${subInfo.DOCID};
        	data.SUBSCRIBEID = UUID;
        	data.DISEASETYPE_CODE = ${subInfo.DISEASETYPE_CODE};
            $.ajax({
                type : 'post',
                url : basePath+'/docTreatUserController/docDoTreat.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $docDoTreatDialog.dialog('destroy');
                        $treatGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','添加诊断信息失败','error');
                    }
                }
            });
        }
	} */
	function submitData($docDoTreatDialog,$treatGrid,$pjq,UUID){
        var form= $("#docDoTreatForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
        	data.USERID = "${subInfo.USERID}";
        	data.DOCID = "${subInfo.DOCID}";
        	data.SUBSCRIBEID = UUID;
        	//data.DISEASETYPE_CODE = "${subInfo.DISEASETYPE_CODE}";
            $.ajax({
                type : 'post',
                url : basePath+'/docTreatUserController/docDoTreat.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.success){
                        $docDoTreatDialog.dialog('destroy');
                        $treatGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','添加诊断信息失败','error');
                    }
                }
            });
        }
	}
	function getAllDiseasetype(){  
	    $.ajax({
	        url:basePath+'/docTreatUserController/getDiseasetype.do',  
	        dataType:"json", 
	        type:"GET",
	        required : true,
	        success:function(data){                                 
	                    //绑定第一个下拉框
	                    $('#type').combobox({
	                            data: data,                        
	                            valueField: 'DISEASETYPE_CODE',
	                            textField: 'DISEASETYPE_NAME'}
	                            );                       
	       },
	       error:function(error){
	           alert("初始化下拉控件失败");
	       }
	    })
	}
	</script>
</html>