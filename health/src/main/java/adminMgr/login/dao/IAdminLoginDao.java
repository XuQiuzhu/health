package adminMgr.login.dao;

import java.util.List;
import java.util.Map;

public interface IAdminLoginDao {

	public List<Map<String,Object>> adminLogin(Map<String, Object> param);
	
}
