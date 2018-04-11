package selfInfoMgr.docInfoMgr.dao;

import java.util.Map;

public interface IDocInfoMgrDao {

	public Map<String,Object> getDocInfo(Map<String,String> param);
	public void updateDocInfo(Map<String,Object> param);
	public void uploadDocPro(Map<String,String> param);
	public Map<String,String> getDocPro(Map<String,String> param);
	
}
