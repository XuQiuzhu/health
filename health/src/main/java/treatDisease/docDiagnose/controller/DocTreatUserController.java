package treatDisease.docDiagnose.controller;

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
import treatDisease.docDiagnose.service.IDocTreatUserService;

@Controller
@RequestMapping("/docTreatUserController")
public class DocTreatUserController extends BaseController{

	@Autowired
	private IDocTreatUserService docTreatUserService;
	
	@RequestMapping("/toSubscribeReqPage")
	public String toSubscribeReqPage() {
		return "treatDisease/docDiagnose/subscribeReq";
	}
	
	@RequestMapping("/manageSubscribe")
	public void manageSubscribe(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			docTreatUserService.manageSubscribe(param);
		result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/getSubscribeReq")
	public void getSubscribeReq(HttpServletRequest request,HttpServletResponse response) {
		Grid<Map<String, String>> result = new Grid<Map<String,String>>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
		try{
			result = docTreatUserService.getSubscribeReq(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/doTreat")
	public String doTreat() {
		return "treatDisease/docDiagnose/doTreat";
	}
	
	@RequestMapping("/tohealthDataLook")
	public String tohealthDataLook(HttpServletRequest request) {
		request.setAttribute("USERUUID", request.getParameter("USERID"));
		return "treatDisease/docDiagnose/healthDataLook";
	}
	
	@RequestMapping("/healthDataLook")
	public void healthDataLook(HttpServletRequest request,HttpServletResponse response) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
		try{
		result = docTreatUserService.getHealthDataLook(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/toDocDoTreatPage")
	public String toDocDoTreatPage(HttpServletRequest request) {
		String UUID = request.getParameter("UUID");
		Map<String,String> param = new HashMap<String, String>();
		param.put("UUID", UUID);
		Map<String,String> subInfo = docTreatUserService.getOneSub(param);
		request.setAttribute("subInfo", subInfo);
		return "treatDisease/docDiagnose/docDoTreat";
	}
	
	@RequestMapping("/docDoTreat")
	public void docDoTreat(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			docTreatUserService.docDoTreat(param);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/getDiseasetype")
	public void getDiseasetype(HttpServletRequest request,HttpServletResponse response) {
		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		try{
			result = docTreatUserService.getDiseasetype();
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
}
