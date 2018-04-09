package treatDisease.docDiagnose.service;

import java.util.List;
import java.util.Map;

import base.model.Grid;

public interface IDocTreatUserService {

	public void manageSubscribe(Map<String,Object> param);
	public Grid<Map<String,String>> getSubscribeReq(Map<String, String> param);
	public Grid<Map<String,Object>> getHealthDataLook(Map<String, String> param);
	public Map<String,String> getOneSub(Map<String, String> param);
	public void docDoTreat(Map<String,Object> param);
	public List<Map<String,String>> getDiseasetype();
	
	
}
