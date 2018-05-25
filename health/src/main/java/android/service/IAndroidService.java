package android.service;

import java.util.List;
import java.util.Map;

public interface IAndroidService {

	public Map<String,Object> androidUserLogin(Map<String, Object> param) ;
	public void androidUserRegister(Map<String, Object> param);
	public void androidUserInfoChange(Map<String, Object> param);
	public Map<String,Object> getDocList(Map<String, Object> param);
	public void setUserData(Map<String, Object> param);
	public Map<String,Object> setDocReserve(Map<String, Object> param);
	public Map<String,Object> androidDocLogin(Map<String, Object> param) ;
	public void androidDocRegister(Map<String, Object> param);
	public List<Map<String,String>> androidGetAllDepartment();
	public void androidDocInfoChange(Map<String, Object> param);
	public Map<String,Object> getUserList(Map<String, Object> param);
	public Map<String,Object> getRemarkList(Map<String, Object> param);
	public Map<String,Object> getUserData(Map<String, Object> param);
	public Map<String,Object> getDocReserve(Map<String, Object> param);
	public void handleDocReserve(Map<String, Object> param);
	
}
