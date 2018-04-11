package bussinessConsole.docLogin.service;

import java.util.Map;

public interface IDocLoginService {

	public void register(Map<String, Object> param);
	public String docLogin(Map<String, Object> param);
	public void cancellation();
	
}
