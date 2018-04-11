package selfInfoMgr.userInfoMgr.dao;

import java.util.List;
import java.util.Map;

public interface IHealthDataDao {

	public List<Map<String,Object>> getHealthData(Map<String,String> param);
	public void addHealthData(Map<String,Object> param);
	public int getHealthDataCount(Map<String,String> param);
	public Map<String,String> getOneHealthData(Map<String,String> param);
	public void modifyHealthData(Map<String,Object> param);
	public void deleteHealthData(Map<String,Object> param);
	public List<Map<String,Object>> getChartsData(Map<String,String> param);
	void excelImpDatas(List<Map<String,Object>> list);
	
}
