package treatDisease.docDiagnose.dao;

import java.util.List;
import java.util.Map;

public interface IDocTreatUserDao {

	public void manageSubscribe(Map<String, Object> param);
	public List<Map<String,String>> getSubscribeReq(Map<String,String> param);
	public int getSubscribeReqCount(Map<String,String> param);
	public Map<String, String> getOneSub(Map<String, String> param);
	public void docDoTreat(Map<String, Object> param);
	public void modifySubTreatStu(Map<String, Object> param);
	public List<Map<String, String>> getDiseasetype();
	
}
