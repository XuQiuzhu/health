package selfInfoMgr.docInfoMgr.controller;

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
import selfInfoMgr.docInfoMgr.service.IDocInfoMgrService;

@Controller
@RequestMapping("/DocInfoMgrController")
public class DocInfoMgrController extends BaseController {

	@Autowired
	private IDocInfoMgrService docInfoMgrService;
	
	@RequestMapping("/toDocInfoCheckPage")
	public String toDocInfoCheckPage() {
		return "doc/docInfoMgr/docInfoCheck";
	}
	
	/**
	 * 获取医生信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getDocInfo")
	public void getUserInfo(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
		result = docInfoMgrService.getDocInfo();
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/updateDocInfo")
	public void updateDocInfo(HttpServletRequest request,HttpServletResponse response) {
		String data = request.getParameter("data");
		Map<String, Object> param = new HashMap<String, Object>();
		param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,String> result = new HashMap<String, String>();
		try{
			docInfoMgrService.updateDocInfo(param);;
			result.put("result", "success");
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/uploadDocPro")
	public void uploadDocPro(@RequestParam(value="file",required = false)MultipartFile file,HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		Map<String,String> result = new HashMap<String, String>();
		try{
		String path = docInfoMgrService.uploadDocPro(file);
		result.put("path", path);
		} catch (Exception e) {
			result.put("result", "error");
			throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("getDocPro")
	public void getDocPro(HttpServletRequest request,HttpServletResponse response) {
		Map<String,String> result = new HashMap<String, String>();
		try{
			result = docInfoMgrService.getDocPro();
			} catch (Exception e) {
				result.put("result", "error");
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
}
