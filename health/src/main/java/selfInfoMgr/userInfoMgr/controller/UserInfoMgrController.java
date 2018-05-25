package selfInfoMgr.userInfoMgr.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import base.controller.BaseController;
import base.exception.IServiceException;
import selfInfoMgr.userInfoMgr.service.IUserInfoMgrService;

@Controller
@RequestMapping("/UserInfoMgrController")
public class UserInfoMgrController extends BaseController{

	@Autowired
	private IUserInfoMgrService userInfoMgrService;
	
	/**
	 * 跳转到用户信息页面
	 * @return
	 */
	@RequestMapping("/toUserInfoCheckPage")
	public String toUserInfoCheckPage() {
		return "user/userInfoMgr/userInfoCheck";
	}
	/**
	 * 获取用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getUserInfo")
	public void getUserInfo(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
		result = userInfoMgrService.getUserInfo();
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/updateUserInfo")
	public void updateUserInfo(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			userInfoMgrService.updateUserInfo(param);
			result.put("result", "success");
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toUserPortraitMgrPage")
	public String toUserPortraitMgrPage() {
		return "user/userInfoMgr/userPortraitMgr";
	}
	
	@RequestMapping("/uploadUserPro")
	public void uploadUserPro(@RequestParam(value="file",required = false)MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) 
			throws IllegalStateException, IOException{
		Map<String,String> result = new HashMap<String, String>();
		try{
		String path = userInfoMgrService.uploadUserPro(file);
		result.put("path", path);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("getPro")
	public void getPro(HttpServletRequest request,HttpServletResponse response) {
		Map<String,String> result = new HashMap<String, String>();
		try{
			result = userInfoMgrService.getPro();
			} catch (Exception e) {
				result.put("result", "error");
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
}
