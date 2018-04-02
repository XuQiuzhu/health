package treatDisease.userBespeak.controller;

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
import treatDisease.userBespeak.service.IUserChooseDocService;

@Controller
@RequestMapping("/UserChooseDocController")
public class UserChooseDocController extends BaseController {

	@Autowired
	private IUserChooseDocService userChooseDocService;
	
	@RequestMapping("/getDepartment")
	public void getDepartment(HttpServletRequest request,HttpServletResponse response) {
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		try{
			result = userChooseDocService.getAllDepartment();
			} catch (Exception e) {
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/getAllDocs")
	public void getAllDocs(HttpServletRequest request,HttpServletResponse response) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
		try{
		result = userChooseDocService.getAllDocs(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/tobuildReservation")
	public String tobuildReservation(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String, String> result = new HashMap<String,String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		try{
			result = userChooseDocService.getOneDocInfo(param);
		}
		catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		request.setAttribute("docInfo", result);
		return "treatDisease/userBespeak/buildReservation";
	}
	
	@RequestMapping("/toDocListPage")
	public String toDocListPage() {
		return "treatDisease/userBespeak/docListChoose";
	}
	
	@RequestMapping("/buildReservation")
	public void buildReservation(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
		userChooseDocService.buildReservation(param);
		result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toSubscribeHis")
	public String toSubscribeHis() {
		return "treatDisease/userBespeak/subscribeHis";
	}
	
	@RequestMapping("/getSubscribeHis")
	public void getSubscribeHis(HttpServletRequest request,HttpServletResponse response) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
		try{
		result = userChooseDocService.getSubscribeHis(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toModifySub")
	public String toModifySub(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String, String> result = new HashMap<String,String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		try{
			result = userChooseDocService.getOneSubscribe(param);
		}
		catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		request.setAttribute("subInfo", result);
		return "treatDisease/userBespeak/modifySub";
	}
	
	@RequestMapping("/modifySub")
	public void modifySub(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
		userChooseDocService.modifySub(param);
		result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/deleteSub")
	public void deleteSub(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
		userChooseDocService.deleteSub(param);
		result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 跳转到诊断详情
	 * @return
	 */
	@RequestMapping("/toDiagnoseDetail")
	public String toDiagnoseDetail(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String, String> result = new HashMap<String,String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		try{
			result = userChooseDocService.getDiagnoseDetail(param);
		}
		catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		request.setAttribute("diaInfo", result);
		return "treatDisease/userBespeak/diagnoseDetail";
	}
	
	/**
	 * 跳转到评价页面
	 * @return
	 */
	@RequestMapping("/toJudge")
	public String toJudge(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String, String> result = new HashMap<String,String>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		try{
			result = userChooseDocService.getOneSubscribe(param);
		}
		catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		request.setAttribute("diaInfo", result);
		return "treatDisease/userBespeak/diagnoseDetail";
	}
	/**
	 * 评价
	 */
	@RequestMapping("/judge")
	public void judge(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
		userChooseDocService.addFeedback(param);
		//userChooseDocService.updateSubscribe(param);
		result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
}
