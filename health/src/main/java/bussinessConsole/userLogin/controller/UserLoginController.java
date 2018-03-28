package bussinessConsole.userLogin.controller;

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
import bussinessConsole.userLogin.service.IUserLoginService;

@Controller
@RequestMapping("/userLoginController")
public class UserLoginController extends BaseController{

	@Autowired
	private IUserLoginService userLoginService;
	
	@RequestMapping("/toLoginPage")
	public String toLoginPage() {
		return "user/login";
	}
	
	@RequestMapping("/toRegisterPage")
	public String toRegisterPage() {
		return "user/register";
	}
	
	@RequestMapping("/register")
	public void register(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			userLoginService.register(param);
			result.put("result", "success");
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/userLogin")
	public void userLogin(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			String loginResult = userLoginService.userLogin(param);
			result.put("result", loginResult);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
		
	}
	
	@RequestMapping("/toUserHomepage")
	public String toUserHomepage() {
		return null;
	}
}
