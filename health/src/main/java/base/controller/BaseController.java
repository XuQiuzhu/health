package base.controller;

import javax.servlet.http.HttpServletResponse;

import util.commonUtil.HttpUtil;

public class BaseController {

	public void printHttpServletResponse(Object obj,HttpServletResponse response)
	  {
	    HttpUtil.printHttpServletResponse(obj,response);
	  }
	
}
