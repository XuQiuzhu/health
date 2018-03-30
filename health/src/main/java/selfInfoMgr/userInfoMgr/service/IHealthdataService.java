package selfInfoMgr.userInfoMgr.service;

import java.util.List;
import java.util.Map;

import base.model.Grid;

public interface IHealthdataService {

	public Grid<Map<String,Object>> getHealthData(Map<String,String> param);
	public void addHealthData(Map<String,Object> param);
	public Map<String,String> getOneHealthData(Map<String,String> param);
	public void modifyHealthData(Map<String,Object> param);
	public void deleteHealthData(Map<String,Object> param);
	public List<Map<String,Object>> getChartsData(Map<String,String> param);
	
}
