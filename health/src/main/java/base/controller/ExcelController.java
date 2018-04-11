package base.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import base.service.IExcelService;

@Controller
@RequestMapping("/ImpExcel")
public class ExcelController extends BaseController {

	@Autowired
	private IExcelService excelService;
	
	@RequestMapping("/ExportModelExcel")
	public void ExportModelExcel(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> result = new HashMap<String, Object>();
		String filePath = "";
		try {
			filePath = excelService.ExportModelExcel();
			result.put("success", true);
			result.put("msg", filePath);
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "导出失败");
		}
		printHttpServletResponse(new Gson().toJson(result),response);
	}
	
	@RequestMapping("/downloadTask")
	public void downloadTask(HttpServletRequest request, HttpServletResponse response){
		String filePath = request.getParameter("filepath");
		//String pageName = request.getParameter("pageName");
		try {
			download(request, response, filePath, "数据导入模板.zip");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
}
