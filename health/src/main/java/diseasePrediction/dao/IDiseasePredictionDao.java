package diseasePrediction.dao;

import java.util.List;
import java.util.Map;

public interface IDiseasePredictionDao {

	public int getAllDiseaseCount();
	public List<Map<String,Object>> getEachDiseaseKind();
	public int getEachDiseaseCount(Map<String,String> param);
	public int getSymptomCount(Map<String,String> param);
	
}
