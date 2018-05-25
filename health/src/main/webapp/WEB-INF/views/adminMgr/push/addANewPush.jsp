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
		<form id="addPushForm" style="margin: 20px 40px;">
			<table>
				<tr>
					<td>推送内容</td><td><input type="text" name="CONTENT" value="" class="easyui-textbox" data-options="multiline:true,required:true,validType:['length[0,30]']" style="height:100px"/></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
<script>
$(document).ready(function(){
});
	function submitData($newPushDialog,$pushGrid,$pjq){
        var form= $("#addPushForm");
        var isValid = $(form).form('validate');
        if(isValid){
        	var data = ns.serializeObject(form);//获取表单所有的name值
            $.ajax({
                type : 'post',
                url : basePath+'/PushMgrController/addATreat.do',
                data :{"data":JSON.stringify(data)},
                dataType : 'json',
                success : function(result) {
                    if(result.statusCode == 0){
                        $newPushDialog.dialog('destroy');
                        $pushGrid.datagrid('reload');
                    }else{
                        $pjq.messager.alert('错误','添加推送信息失败','error');
                    }
                }
            });
        }
	}
	</script>
</html>