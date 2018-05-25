package android.dao;

import java.util.List;
import java.util.Map;

public interface IAndroidDao {

	public List<Map<String,Object>> androidUserLogin(Map<String, Object> param);
	public void androidUserRegister(Map<String, Object> param);
	public void androidUserInfoChange(Map<String, Object> param);
	public List<Map<String, Object>> getDocList(Map<String, Object> param);
	public List<Map<String, Object>> androidGetUserUUID(Map<String, Object> param);
	public List<Map<String, Object>> androidGetDocUUID(Map<String, Object> param);
	public void setUserData(Map<String, Object> param);
	public void setDocReserve(Map<String, Object> param);
	public List<Map<String,Object>> androidGetAllReserve(Map<String, Object> param);
	public List<Map<String,Object>> androidDocLogin(Map<String, Object> param);
	public void androidDocRegister(Map<String, Object> param);
	public List<Map<String,String>> androidGetAllDepartment();
	public void androidDocInfoChange(Map<String, Object> param);
	public List<Map<String, Object>> getUserList(Map<String, Object> param);
	public List<Map<String,Object>> getRemarkList(Map<String, Object> param);
	public List<Map<String,Object>> getUserData(Map<String, Object> param);
	public List<Map<String,Object>> getDocReserve(Map<String, Object> param);
	public void handleDocReserve(Map<String, Object> param);
	
}
