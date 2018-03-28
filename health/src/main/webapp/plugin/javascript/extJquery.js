var ns = ns || {};

$(document).bind('contextmenu',function(){
	//return false;
});

$(document).bind('selectstart',function(){
	//return false;
});

ns.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (this['value'] != undefined && this['value'].length > 0) {
			if (o[this['name']]) {
				o[this['name']] = o[this['name']] + "," + this['value'];
			} else {
				o[this['name']] = this['value'];
			}
		}
	});

	return o;
};

ns.arrdiff = function(arrO,arrT){
	var o = {};
	for(var i=0,len = arrT.length;i < len;i++){
		o[arrT[i]] = true;
	}
	
	var result = [];
	for(i = 0,len = arrO.length;i < len;i++){
		var v = arrO[i];
		if(o[arrO[i]]) continue;
		result.push(v);
	}
	return result;
};

$(document).keydown(function(e){ 
	  var doPrevent; 
	  if(e.keyCode==8){ 
	    var d=e.srcElement||e.target; 
	    if(d.tagName.toUpperCase()=='INPUT'||d.tagName.toUpperCase()=='TEXTAREA') { 
	      doPrevent=d.readOnly||d.disabled; 
	    } 
	    else {
	       doPrevent=true; 
	    }    
	  } 
	  else {
	    doPrevent=false; 
	  }
	  if(doPrevent) {
	    e.preventDefault(); 
	  }
});






























