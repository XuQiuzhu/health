package bussinessConsole.userLogin.service;

import java.util.Map;

public interface IUserLoginService {

	public void register(Map<String, Object> param);
	public String userLogin(Map<String, Object> param) ;
	
}
