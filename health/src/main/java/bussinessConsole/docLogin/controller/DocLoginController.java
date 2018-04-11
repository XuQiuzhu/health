package bussinessConsole.docLogin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import base.controller.BaseController;
import base.exception.IServiceException;
import bussinessConsole.docLogin.service.IDocLoginService;

@Controller
@RequestMapping("/docLoginController")
public class DocLoginController  extends BaseController{

	@Autowired
	private IDocLoginService docLoginService;
	
	@RequestMapping("/toDocLoginPage")
	public String toLoginPage() {
		return "doc/login";
	}
	
	@RequestMapping("/toDocRegisterPage")
	public String toDocRegisterPage() {
		return "doc/register";
	}
	
	@RequestMapping("/docLogin")
	public void docLogin(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			String loginResult = docLoginService.docLogin(param);
			result.put("result", loginResult);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toDocHomepage")
	public String toDocHomepage() {
		return "doc/docHomepage";
	}
	
	@RequestMapping("/docRegister")
	public void docRegister(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			docLoginService.register(param);
			result.put("result", "success");
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/cancellation")
	public String cancellation() {
		docLoginService.cancellation();
		return "index";
	}
}
