package treatDisease.userBespeak.dao;

import java.util.List;
import java.util.Map;

public interface IUserChooseDocDao {

	public List<Map<String,String>> getAllDepartment();
	public List<Map<String,Object>> getAllDocs(Map<String,String> param);
	public int getAllDocsCount(Map<String,String> param);
	public Map<String, String> getOneDocInfo(Map<String, String> param);
	public void buildReservation(Map<String,Object> param);
	public List<Map<String, Object>> getSubscribeHis(Map<String, Object> param);
	public int getSubscribeHisCount(Map<String, Object> param);
	public Map<String, String> getOneSubscribe(Map<String, String> param);
	public void modifySub(Map<String, Object> param);
	public void deleteSub(Map<String, String> param);
	public Map<String, String> getDiagnoseDetail(Map<String, String> param);
	public void addFeedback(Map<String, Object> param);
	public void updateSubscribe(Map<String, String> param);
	public Map<String,Object> getDocLevelInfo(Map<String, Object> param);
	public void modifyDocLevel(Map<String, Object> param);
	
}
