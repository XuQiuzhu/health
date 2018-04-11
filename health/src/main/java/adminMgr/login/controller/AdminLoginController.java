package adminMgr.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import adminMgr.login.service.IAdminLoginService;
import base.controller.BaseController;
import base.exception.IServiceException;

@Controller
@RequestMapping("/adminLoginController")
public class AdminLoginController extends BaseController {

	@Autowired
	private IAdminLoginService adminLoginService;
	
	@RequestMapping("/toAdminLoginPage")
	public String toAdminLoginPage() {
		return "adminMgr/login/login";
	}
	
	@RequestMapping("/adminLogin")
	public void adminLogin(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			String loginResult = adminLoginService.adminLogin(param);
			result.put("result", loginResult);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
		
	}
	
	@RequestMapping("/toAdminHomepage")
	public String toUserHomepage() {
		return "adminMgr/adminHomepage";
	}
	
}
