/**
 * 扩展easyui
 */

/**
 * 名称空间
 */
var ns = ns || {};

/**
 * 模态窗口
 */
ns.modalDialog = function(options) {
	var opts = $.extend({
		title : '&nbsp;',
		width : 640,
		height : 480,
		modal : true,
		onClose : function() {
			$(this).dialog('destroy');
		}
	}, options);

	opts.modal = true;

	if (options.url) {
		opts.content = '<iframe id="" src="'
				+ options.url
				+ '" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name=""></iframe>';

	}

	return $('<div/>').dialog(opts);
};

//计算字符长度，中文两个字符，英文一个字符
function stringLength(str){
    var len = 0;
    for (var i=0; i<str.length; i++) { 
     var c = str.charCodeAt(i); 
    //单字节加1 
     if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
       len++; 
     } 
     else { 
      len+=2; 
     } 
    } 
    return len;
}


$.extend($.fn.validatebox.defaults.rules, {
	eqTo : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '不相同'
	},
	 validataChar:{
	    validator:function(value){
		        var reg = /^[A-Za-z0-9_]+$/;
		        return reg.test(value);
	        },
	        message:"只能输入数字、字母和下划线."
	},
	 validataCharandNum:{
		    validator:function(value){
			        var reg = /^[A-Za-z0-9]+$/;
			        return reg.test(value);
		        },
		        message:"只能输入字母和数字."
		},
	 validataTel:{
		    validator:function(value){
			        var reg = /^([a-z_A-Z-+0-9]+)$/;
			        return reg.test(value);
		        },
		        message:"只能输入数字、字母、下划线、短横线和加号."
	},
	strlen : {  
        validator : function(value, param) {  
            this.message = '长度{0}~{1}之间';  
            var len = stringLength($.trim(value));  
           
            if (param) {  
                for (var i = 0; i < param.length; i++) {  
                    this.message = this.message.replace(new RegExp(  
                                    "\\{" + i + "\\}", "g"), param[i]);  
                }  
            }  
            return len >= param[0] && len <= param[1];  
        },  
        message : '长度 {0}~{1}之间'  
    }
});

ns.datagridOptions = {
		fit:true,
    	//fitColumns:true,
    	border:false,
    	pagination:true,
    	pageSize:10,
    	pageList:[10,20,30,40,50],
    	sortName:'name',
    	sortOrder:'asc',
    	checkOnSelect:true,
    	selectOnCheck:true,
    	nowrap:false
};

ns.getSelectOrCheck = function(datagrid){
	 var  select = datagrid.datagrid('getSelected');//选择
	 var Check = datagrid.datagrid('getChecked');
	 
	 var result = null;

        if(select){
        	result = select;
        }else{
           if(Check && Check.length > 0){
        	   result = Check;
           }
        }
        
        return result;
};

function fixWidth(percent){
	//去掉左侧菜单宽度
	return (document.body.clientWidth - 160) * percent;
}

//判断开始时间和截止时间的大小
//时间框判断
function isDate(beginTime,endTime,message){
	
	var trimBeginTime = $.trim(beginTime);
	var trimEndTime = $.trim(endTime);
	var beginTimeParse;
	var endTimeParse;
	
	if('' == trimEndTime){
	   		trimEndTime = myformatter(new Date());
	 }
	if('' == trimBeginTime ){
	   		trimBeginTime = '1980-01-01';
	 }
	var regexp = /^(\d{4})-(\d{2})-(\d{2})$/;
	if((regexp.test(trimBeginTime)) && (regexp.test(trimEndTime))){
	   
		beginTimeParse =Date.parse(trimBeginTime.replace(/-/g, '/'));
		endTimeParse = Date.parse(trimEndTime.replace(/-/g, '/'));
		if(beginTimeParse > endTimeParse){
	  		$.messager.alert('提示',message,'info');
	  		return false;
		}
	}else{
		$.messager.alert('提示','请输入正确的类型（如2016-08-08）！','info');
		return false;
	}
	return true;
}

//时间格式化
function myformatter(date){  
	var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
}  
          
function myparser(s){  
    if (!s) return new Date();  
    var ss = (s.split('-'));  
    var y = parseInt(ss[0],10);  
    var m = parseInt(ss[1],10);  
    var d = parseInt(ss[2],10);  
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
        return new Date(y,m-1,d);  
    } else {  
        return new Date();  
    }  
}  


/*
 * 合并列属性下值相同的行，（前提是该数据的UUID是相同的）
 * gridName  grid的id 字符串形式
 * UUID  任何可以标识出几行所共有的id，一般是数据库查询出来的主键id列名
 * fieldcolums 为需要合并的列名  为数组形式
 * 赵一峰
 */

function rowspan(gridName,UUID,fieldcolums){
	//计数开始合并的行和rowspan的行数的数组
	var rowspanArr = [];
	var startRow = 0;
	var spanRow = 1;
	//抓取所有行
	var rows = $('#'+gridName).datagrid('getRows');
	var rowsLength = rows.length;
	//循环判断所有行中UUID是否相同，如果相同，则计数；如果不同，重置计数
	while(startRow+spanRow <= rowsLength ){
		if(startRow+spanRow < rowsLength && rows[startRow][UUID] == rows[startRow+spanRow][UUID]  ){
			spanRow++;
		}else {
			if(spanRow >1){
				var rowspanObj = {};//存放合并坐标
				rowspanObj.startRow = startRow;
				rowspanObj.spanRow = spanRow;
				rowspanArr.push(rowspanObj);//将坐标存入数组
			}
			startRow = spanRow + startRow;
			spanRow = 1;
		}
	}
	//执行合并操作
	for(var i = 0; i < rowspanArr.length; i++){
		for(var k = 0; k < fieldcolums.length; k++){
			$('#' + gridName).datagrid('mergeCells',{
				index:rowspanArr[i].startRow,
				field:fieldcolums[k],
				rowspan:rowspanArr[i].spanRow
			});
		}
		
	}
}


