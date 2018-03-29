package selfInfoMgr.userInfoMgr.dao;

import java.util.Map;

public interface IUserInfoMgrDao {
	
	public Map<String,Object> getUserInfo(Map<String,String> param);
	public void updateUserInfo(Map<String,Object> param);
	public void uploadUserPro(Map<String,String> param);
	public Map<String,String> getPro(Map<String,String> param);
	
}
