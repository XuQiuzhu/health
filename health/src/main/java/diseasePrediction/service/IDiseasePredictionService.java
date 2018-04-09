package diseasePrediction.service;

import java.util.List;
import java.util.Map;

public interface IDiseasePredictionService {

	public List<Map<String,Object>> doPrediction(String[] symptoms);
	
}
