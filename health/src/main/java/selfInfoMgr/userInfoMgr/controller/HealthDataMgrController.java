package selfInfoMgr.userInfoMgr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import selfInfoMgr.userInfoMgr.service.IHealthdataService;

@Controller
@RequestMapping("/HealthDataMgrController")
public class HealthDataMgrController  extends BaseController{

	@Autowired
	private IHealthdataService healthDataService;
	
	/**
	 * 跳转至数据显示页面
	 * @return
	 */
	@RequestMapping("/toHealdataPage")
	public String toHealdataPage() {
		return "user/healthDataMgr/healthData";
	}
	
	/**
	 * 获取个人全部健康数据
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getHealthData")
	public void getHealthData(HttpServletRequest request,HttpServletResponse response) {
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
		result = healthDataService.getHealthData(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toAddData")
	public String toAddData() {
		return "user/healthDataMgr/addData";
	}
	
	@RequestMapping("/addData")
	public void addData(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
				healthDataService.addHealthData(param);
				result.put("success", true);
			} catch (Exception e) {
				result.put("success", false);
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
}
