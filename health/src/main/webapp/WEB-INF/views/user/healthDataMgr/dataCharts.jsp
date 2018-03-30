<%@ page language="java" pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>健康数据图表</title>
<%@include file="../../common/common.jsp"%>
</head>
<body>
<div class="easyui-layout" id="charts_layout">
		<div region="west" split="true" title="数据项" style="width:12%;">
			<div title="数据项">
				<ul id="dataTree" class="easyui-tree">
					<li><a onclick="showCharts('heartrate')">心率</a></li>			
					<li>
						<span>血压</span>
						<ul>
							<li><a onclick="showCharts('highpressure')">高压</a></li>
							<li><a onclick="showCharts('lowpressure')">低压</a></li>
						</ul>
					</li>
					<li><a onclick="showCharts('bloodsugar')">血糖</a></li>	
					<li><a onclick="showCharts('bloodlipid')">血清甘油三酯</a></li>	
					<li><a onclick="showCharts('highcholesterol')">高密度脂蛋白胆固醇</a></li>	
					<li><a onclick="showCharts('cholesterol')">血清总胆固醇</a></li>	
					<li><a onclick="showCharts('trioxypurine')">尿酸</a></li>
					<li><a onclick="showCharts('temperature')">体温</a></li>	
				</ul>
			</div>
		</div>
		<div id="charts" region="center" title="图表">
			<div id="container" style="max-width:90%;height:90%;margin-top:25px;margin-left:20px;"></div>
		</div>
</div>

<script>
$(function(){
	setLayoutHeight();
});
function setLayoutHeight() {
    var height = $(window).height() - 20;
    $("#charts_layout").attr("style", "width:100%;height:" + height + "px");
    $("#charts_layout").layout("resize", {
        width: "100%",
        height: height + "px"
    });
}
function showCharts(type){
	var data = {};
	data.TYPE = type;
	$.ajax({
        type : 'post',
        url : basePath+'/HealthDataMgrController/getChartsData.do',
        data :{"data":JSON.stringify(data)},
        dataType : 'json',
        success : function(result) {
            if(result.success){
            	var resultList = result.resultList;
            	/* console.info(resultList);
            	console.info(resultList.length); */
            	var resultLength = resultList.length;
            	var yTittle = "";
            	var a = new Array(resultLength);
            	if(type == "heartrate"){
            		yTittle = "心率(次/分钟)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].HEARTRATE;
	            			console.info(resultList[p].HEARTRATE);
	            	}
            	}
            	if(type == "highpressure"){
            		yTittle = "高压(mmHg)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].HIGHPRESSURE;
	            	}
            	}
            	if(type == "lowpressure"){
            		yTittle = "低压(mmHg)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].LOWPRESSURE;
	            	}
            	}
            	if(type == "bloodsugar"){
            		yTittle = "血糖(mmol/L)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].BLOODSUGAR;
	            	}
            	}
            	if(type == "bloodlipid"){
            		yTittle = "血清甘油三酯(mmol/L)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].BLOODLIPID;
	            	}
            	}
            	if(type == "highcholesterol"){
            		yTittle = "高密度脂蛋白胆固醇(mmol/L)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].HIGHCHOLESTEROL;
	            	}
            	}
            	if(type == "cholesterol"){
            		yTittle = "血清总胆固醇(mmol/L)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].CHOLESTEROL;
	            	}
            	}
            	if(type == "trioxypurine"){
            		yTittle = "尿酸(umol/L)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].TRIOXYPURINE;
	            	}
            	}
            	if(type == "temperature"){
            		yTittle = "体温(℃)"
	            	for(var p in resultList){//遍历json数组时，这么写p为索引，0,1
	            			a[resultLength-p-1] = resultList[p].TEMPERATURE;
	            	}
            	}
            	draw(a,yTittle);

            }else{
            	parent.$.messager.alert('错误','数据获取失败','error');
            }
        }
    });
}
function draw(a,yTittle){
	var chart = Highcharts.chart('container', {
	    chart: {
	        type: 'line'
	    },
	    title: {
	        text: '近十五次数据变化情况'
	    },
	    subtitle: {
	        text: '数据来源: 个人健康助手'
	    },
	    xAxis: {
	        categories: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11','12','13', '14','今天']
	    },
	    yAxis: {
	        title: {
	            text: yTittle
	        }
	    },
	    plotOptions: {
	        line: {
	            dataLabels: {
	                enabled: true          // 开启数据标签
	            },
	            enableMouseTracking: false // 关闭鼠标跟踪，对应的提示框、点击事件会失效
	        }
	    },
	    series: [{
	        name: '',
	        data: a
	    }]
	});
}
</script>

</body>
</html>