package bussinessConsole.userLogin.dao;

import java.util.List;
import java.util.Map;

public interface UserLoginDao {

	public void register(Map<String, Object> param);
	public List<Map<String,Object>> userLogin(Map<String, Object> param);
	
}
