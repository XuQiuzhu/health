package diseasePrediction.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import diseasePrediction.dao.IDiseasePredictionDao;
import diseasePrediction.service.IDiseasePredictionService;
import net.sf.jsqlparser.expression.StringValue;

@Transactional
@Service
public class DiseasePredictionServiceImpl implements IDiseasePredictionService {

	@Autowired
	private IDiseasePredictionDao diseasePredictionDao;
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private HttpSession session;

	@Override
	public List<Map<String, Object>> doPrediction(String[] symptoms) {
		Map<String,String> param = new HashMap<String, String>();
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		double allDiseaseCount = diseasePredictionDao.getAllDiseaseCount();//总数量
		List<Map<String,Object>> eachDiseaseKind = diseasePredictionDao.getEachDiseaseKind();
		for(int a = 0;a < eachDiseaseKind.size();a++) {
			double biaozhunhua = 1;//*标准化常量
			double shiran = 1;//*似然函数
			Map<String,Object> oneResult = new HashMap<String, Object>();
			param.put("DISEASETYPE_CODE", String.valueOf(eachDiseaseKind.get(a).get("DISEASETYPE_CODE")));
			double eachDiseaseCount = diseasePredictionDao.getEachDiseaseCount(param);//每种数量
			double xianyan = eachDiseaseCount/allDiseaseCount;//*先验概率
			for(int b = 0;b < symptoms.length;b++) {
				param.put("SYMPTOM", symptoms[b]);
				double symptomCount = diseasePredictionDao.getSymptomCount(param);
				double oneOfbiaozhunhua = symptomCount/allDiseaseCount;//标准化常量之一
				BigDecimal biaozhunhuaB = new BigDecimal(Double.toString(biaozhunhua));
				BigDecimal oneOfbiaozhunhuaB = new BigDecimal(Double.toString(oneOfbiaozhunhua));
				biaozhunhua = biaozhunhuaB.multiply(oneOfbiaozhunhuaB).doubleValue();
				param.put("CONDITION", "yes");
				double conditionSymptomCount = diseasePredictionDao.getSymptomCount(param);
				double oneOfShiran = conditionSymptomCount/symptomCount;//似然函数之一
				BigDecimal shiranB = new BigDecimal(Double.toString(shiran));
				BigDecimal oneOfShiranB = new BigDecimal(Double.toString(oneOfShiran));
				shiran = shiranB.multiply(oneOfShiranB).doubleValue();
				param.put("CONDITION", "");
			}
			BigDecimal xianyanB = new BigDecimal(Double.toString(xianyan));
			BigDecimal shiranB = new BigDecimal(Double.toString(shiran));
			BigDecimal biaozhunhuaB = new BigDecimal(Double.toString(biaozhunhua));
			double huanbinggailv = xianyanB.multiply(shiranB.divide(biaozhunhuaB, 3,BigDecimal.ROUND_HALF_UP)).doubleValue();//先验概率*似然函数/标准化常量，保留三位小数，四舍五入
			oneResult.put("DISEASETYPE_CODE", eachDiseaseKind.get(a).get("DISEASETYPE_CODE"));
			oneResult.put("DISEASETYPE_NAME", eachDiseaseKind.get(a).get("DISEASETYPE_NAME"));
			oneResult.put("huanbinggailv", huanbinggailv);
			result.add(oneResult);
		}
		 Collections.sort(result, new Comparator<Map<String, Object>>() {
	            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
	                return (String.valueOf(o2.get("huanbinggailv")) ).compareTo(String.valueOf(o1.get("huanbinggailv")));
	            }
	        });//排序
		 if(result.size() > 15) {
			 result = result.subList(0, 15);
		 }
		return result;//返回前15个值
	}
	
}
