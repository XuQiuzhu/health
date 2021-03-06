package adminMgr.knowledgeBaseMgr.service;

import java.util.List;
import java.util.Map;

import base.model.Grid;

public interface IKonwledgeBaseMgrService {

	public Grid<Map<String,Object>> getKnowledgeData(Map<String,String> param);
	public List<Map<String,String>> getClassification();
	public void addKnowledgeData(Map<String,Object> param);
	public Map<String,String> getOneKnowledgeData(Map<String, String> param);
	public void modifyKnowledgeData(Map<String,Object> param);
	public void deleteKnowledgeData(Map<String,Object> param);
	
}
