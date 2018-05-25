package android.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import android.service.IAndroidService;
import base.controller.BaseController;
import base.exception.IServiceException;

@Controller
@RequestMapping("/AndroidController")
public class AndroidController extends BaseController{

	@Autowired
	private IAndroidService androidService;
	
	@RequestMapping(value = "/androidUserLogin",method = RequestMethod.POST)
	@ResponseBody
	public void androidUserLogin(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("params");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.androidUserLogin(param);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 用户注册
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/androidUserRegister",method = RequestMethod.POST)
	@ResponseBody
	public void androidUserRegister(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.androidDocRegister(param);
			result.put("success", "true");
			result.put("doc", param);
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 修改用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/androidUserInfoChange",method = RequestMethod.POST)
	@ResponseBody
	public void androidUserInfoChange(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.androidUserInfoChange(param);
			result.put("success", "true");
			result.put("doc", param);
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 获取关注的医生列表
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getDocList",method = RequestMethod.POST)
	@ResponseBody
	public void getDocList(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.getDocList(param);;
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 患者体征数据上传
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/setUserData",method = RequestMethod.POST)
	@ResponseBody
	public void setUserData(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.setUserData(param);
			result.put("success", "true");
			result.put("userData", param);
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 患者预约医生
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/setDocReserve",method = RequestMethod.POST)
	@ResponseBody
	public void setDocReserve(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.setDocReserve(param);
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping(value = "/androidDocLogin",method = RequestMethod.POST)
	@ResponseBody
	public void androidDocLogin(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String data = request.getParameter("params");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.androidDocLogin(param);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 医生注册
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/androidDocRegister",method = RequestMethod.POST)
	@ResponseBody
	public void androidDocRegister(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.androidDocRegister(param);
			result.put("success", "true");
			result.put("doc", param);
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 获取所有科室
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/androidGetAllDepartment",method = RequestMethod.POST)
	@ResponseBody
	public void androidGetAllDepartment(HttpServletRequest request,HttpServletResponse response) {
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		try{
			result = androidService.androidGetAllDepartment();
			} catch (Exception e) {
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 修改医生信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/androidDocInfoChange",method = RequestMethod.POST)
	@ResponseBody
	public void androidDocInfoChange(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.androidDocInfoChange(param);;
			result.put("success", "true");
			result.put("doc", param);
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}

	/**
	 * 获取被关注的用户列表
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getUserList",method = RequestMethod.POST)
	@ResponseBody
	public void getUserList(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.getUserList(param);;
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 患者评价获取
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getRemarkList",method = RequestMethod.POST)
	@ResponseBody
	public void getRemarkList(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.getRemarkList(param);
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 获得患者健康数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getUserData",method = RequestMethod.POST)
	@ResponseBody
	public void getUserData(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.getUserData(param);;
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 获取预约列表
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getDocReserve",method = RequestMethod.POST)
	@ResponseBody
	public void getDocReserve(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			result = androidService.getDocReserve(param);
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 处理预约
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/handleDocReserve",method = RequestMethod.POST)
	@ResponseBody
	public void handleDocReserve(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("param");//param包括预约单UUID、医生手机号PHONE、DIAGNOSE_STATUS，状态1：拒绝，2：接受,状态很重要！！！
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> result = new HashMap<String, Object>();
		try{
			androidService.handleDocReserve(param);
			result = androidService.getDocReserve(param);
			result.put("success", "true");
		} catch (Exception e) {
			result.put("success", "false");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
}
