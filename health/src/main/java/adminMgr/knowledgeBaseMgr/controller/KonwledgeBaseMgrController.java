package adminMgr.knowledgeBaseMgr.controller;

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

import adminMgr.knowledgeBaseMgr.service.IKonwledgeBaseMgrService;
import base.controller.BaseController;
import base.exception.IServiceException;
import base.model.Grid;

@Controller
@RequestMapping("/knowledgeBaseMgr")
public class KonwledgeBaseMgrController extends BaseController {

	@Autowired
	private IKonwledgeBaseMgrService knowledgeBaseMgrService;
	
	@RequestMapping("/toKnowledgeBaseMgrPage")
	public String toKnowledgeBaseMgrPage() {
		return "adminMgr/knowledgeBaseMgr/knowledgeBaseMgr";
	}
	
	/**
	 * 查询所有知识库
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getKnowledgeData")
	public void getKnowledgeData(HttpServletRequest request,HttpServletResponse response) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		String data = request.getParameter("data");
		Map<String, String> param = new HashMap<String, String>();
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		param.put("page", request.getParameter("page"));
		param.put("rows", request.getParameter("rows"));
		try{
		result = knowledgeBaseMgrService.getKnowledgeData(param);
		} catch (Exception e) {
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 跳转到添加页面
	 * @return
	 */
	@RequestMapping("/toAddDataPage")
	public String toAddDataPage() {
		return "adminMgr/knowledgeBaseMgr/addKnowledgeBase";
	}
	
	/**
	 * 得到所有知识分类
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getClassification")
	public void getClassification(HttpServletRequest request,HttpServletResponse response) {
		List<Map<String,String>> result = new ArrayList<Map<String,String>>();
		try{
			result = knowledgeBaseMgrService.getClassification();
			} catch (Exception e) {
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	/**
	 * 添加分类
	 */
	@RequestMapping("/addKnowledgeData")
	public void addKnowledgeData(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		try{
			knowledgeBaseMgrService.addKnowledgeData(param);
				result.put("success", true);
			} catch (Exception e) {
				result.put("success", false);
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
}
