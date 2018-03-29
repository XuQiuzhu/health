package selfInfoMgr.userInfoMgr.dao;

import java.util.List;
import java.util.Map;

public interface IHealthDataDao {

	public List<Map<String,Object>> getHealthData(Map<String,Object> param);
	public void addHealthData(Map<String,Object> param);
	
}
