package selfInfoMgr.userInfoMgr.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface IUserInfoMgrService {

	public Map<String,Object> getUserInfo();
	public void updateUserInfo(Map<String,Object> param);
	public String uploadUserPro(MultipartFile file) throws IllegalStateException, IOException;
}
