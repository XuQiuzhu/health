package diseasePrediction.controller;

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
import diseasePrediction.service.IDiseasePredictionService;

@Controller
@RequestMapping("/DiseasePredictionController")
public class DiseasePredictionController extends BaseController {

	@Autowired
	private IDiseasePredictionService diseasePredictionService;
	
	@RequestMapping("/toDiseasePredictionPage")
	public String toDiseasePredictionPage() {
		return "user/diseasePrediction/diseasePrediction";
	}
	
	@RequestMapping("/doPrediction")
	public void doPrediction(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String,Object>();
		List<Map<String,Object>> forecastResult = new ArrayList<Map<String,Object>>();
		Map<String, String> param = new HashMap<String, String>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		String[] symptoms = param.get("SYMPTOM").split(" ");
		try{
				forecastResult = diseasePredictionService.doPrediction(symptoms);
				result.put("forecastResult", forecastResult);
				result.put("success", true);
			} catch (Exception e) {
				result.put("success", false);
				throw new IServiceException(this.getClass() + " --> getTodoTasksListComp() Exception : " + e);
			}
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
}
