package selfInfoMgr.userInfoMgr.service;

import java.util.List;
import java.util.Map;

public interface IHealthdataService {

	public List<Map<String,Object>> getHealthData(Map<String,Object> param);
	public void addHealthData(Map<String,Object> param);
	
}
