package adminMgr.knowledgeBaseMgr.dao;

import java.util.List;
import java.util.Map;

public interface IKonwledgeBaseMgrDao {

	public List<Map<String,Object>> getKnowledgeData(Map<String,String> param);
	public int getKnowledgeDataCount(Map<String,String> param);
	public List<Map<String,String>> getClassification();
	public void addKnowledgeData(Map<String, Object> param);
	
}
