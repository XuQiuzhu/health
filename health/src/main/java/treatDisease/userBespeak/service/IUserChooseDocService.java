package treatDisease.userBespeak.service;

import java.util.List;
import java.util.Map;

import base.model.Grid;

public interface IUserChooseDocService {

	public List<Map<String,String>> getAllDepartment();
	public Grid<Map<String,Object>> getAllDocs(Map<String, String> param);
	public Map<String,String> getOneDocInfo(Map<String,String> param);
	public void buildReservation(Map<String,Object> param);
	public Grid<Map<String,Object>> getSubscribeHis(Map<String,Object> param);
	public Map<String,String> getOneSubscribe(Map<String,String> param);
	public void modifySub(Map<String,String> param);
	public void deleteSub(Map<String,String> param);
	public Map<String,String> getDiagnoseDetail(Map<String,String> param);
	public void addFeedback(Map<String,String> param);
	
}
