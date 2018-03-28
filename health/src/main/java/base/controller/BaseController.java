package base.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import util.commonUtil.HttpUtil;

@Controller
@RequestMapping("/BaseController")
public class BaseController {

	public void printHttpServletResponse(Object obj,HttpServletResponse response)
	  {
	    HttpUtil.printHttpServletResponse(obj,response);
	  }
	
	@RequestMapping("/index")
	public String SessionOutToIndex() {
		return "index";
	}
}
