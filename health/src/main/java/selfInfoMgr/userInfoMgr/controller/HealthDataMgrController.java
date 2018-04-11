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
import base.model.Grid;
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
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
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
	
	@RequestMapping("/toModifyData")
	public String toModifyData(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String, String> result = new HashMap<String,String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		try{
			result = healthDataService.getOneHealthData(param);
		}
		catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		request.setAttribute("healthData", result);
		return "user/healthDataMgr/modifyData";
	}
	
	@RequestMapping("/modifyData")
	public void modifyData(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			healthDataService.modifyHealthData(param);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/deleteData")
	public void deleteData(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			healthDataService.deleteHealthData(param);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 跳转到图表显示数据页面
	 * @return
	 */
	@RequestMapping("/toUserDataChartsPage")
	public String toUserDataChartsPage() {
		return "user/healthDataMgr/dataCharts";
	}
	
	@RequestMapping("/getChartsData")
	public void getChartsData(HttpServletRequest request,HttpServletResponse response) {
		Map<String, String> param = new HashMap<String,String>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> result = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			resultList = healthDataService.getChartsData(param);
			result.put("resultList", resultList);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 跳转到批量导入页面
	 * @return
	 */
	@RequestMapping("/toUploadExcelPage")
	public String toUploadExcelPage() {
		return "user/healthDataMgr/uploadExcel";
	}
}
