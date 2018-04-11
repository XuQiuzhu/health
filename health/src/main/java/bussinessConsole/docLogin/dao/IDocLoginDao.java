package bussinessConsole.docLogin.dao;

import java.util.List;
import java.util.Map;

public interface IDocLoginDao {

	public void docRegister(Map<String, Object> param);
	public List<Map<String, Object>> docLogin(Map<String, Object> param);
	public void cancellation(Map<String,String> param);
	
}
