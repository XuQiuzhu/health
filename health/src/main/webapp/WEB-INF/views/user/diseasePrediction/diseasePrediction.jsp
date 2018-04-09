<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>自助预测</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div  class="easyui-panel" data-options="fit:true,border:false">

	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',title:'症状录入',collapsed:false" style="height:100px;">
			<form id="inputSymptomForm" style="margin-top: 10px;margin-left:10px">
				<table>
					<tr>
						<td>请输入您的症状，症状间以一个空格分隔，最多可输入五个症状：</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="SYMPTOM" id="symptom" value="" class="easyui-validatebox" data-options="validType:['length[1,100]']"/>
						</td>
						<td>
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="finishInput();return false;">过滤</a> 
							<a  href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="resetInput();return false;">重置</a> 
						</td>
					</tr>
				</table>
			</form>
		</div>  
    	<div data-options="region:'center'">  
        	<div id="container" style="max-width:90%;height:90%;margin-top:25px;margin-left:20px;">
        		请输入您的症状......
        	</div>
    	</div> 
	</div>
	
	
</div>
</body>
<script type="text/javascript">

$(document).ready(function(){
	
});

function doPrediction(symptom){
	var data={
		SYMPTOM : symptom
	};
	$.ajax({
        type : 'post',
        url : '${ct}/DiseasePredictionController/doPrediction.do',
        data :{"data":JSON.stringify(data)},
        dataType : 'json',
        success : function(result) {
            if(result.success){
            	$("#container").html("");//清空info内容
            	var resultList = result.forecastResult;
            	console.info(resultList);
            	if(resultList != null){
            		var resultLength = resultList.length;
            		var a = new Array(resultLength);
            		var b = new Array(resultLength);
            		for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
            			a[p] = resultList[p].huanbinggailv;
            			b[p] = resultList[p].DISEASETYPE_NAME;
            		}
            		draw(a,b);
            	}
            }else{
               parent.$.messager.alert('错误','暂时无法预测此症状','error');
            }
        },
        error:function(result){
        	parent.$.messager.alert('错误','请求失败','error');
        	//console.info(result);
        }
});
}

//症状校验
function finishInput(){
	var symptom = $("#symptom").val();
	if(symptom != null && symptom != ""){
		var symptoms = symptom.split(' ');
		//console.info(symptoms);
		if(symptoms.length > 5){
			parent.$.messager.alert('错误', '最多可输入五个症状', 'error');
			return;
		}
		if(symptom == ""){
			parent.$.messager.alert('错误', '请输入症状', 'error');
			return;
		}
			doPrediction(symptom);
	}
}

function resetInput(){
	$("#symptom").val("");
}

function draw(a,b){
	var chart = Highcharts.chart('container', {
	    chart: {
	        type: 'line'
	    },//图表类型
	    title: {
	        text: '可能性较大健康问题'
	    },//图表标题
	    subtitle: {
	        text: '数据来源: 个人健康助手'
	    },//副标题
	    xAxis: {
	        categories: b
	    },//x轴文字
	    yAxis: {
	        title: {
	            text: '概率'
	        }//y轴标题
	    },
	    plotOptions: {
	        line: {
	            dataLabels: {
	                enabled: true          // 开启数据标签
	            },
	            enableMouseTracking: true // 关闭鼠标跟踪，对应的提示框、点击事件会失效
	        }
	    },
	    series: [{
	        name: '',
	        data: a
	    }]//数据
	});
}

</script>
</html>