package selfInfoMgr.docInfoMgr.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface IDocInfoMgrService {

	public Map<String,Object> getDocInfo();
	public void updateDocInfo(Map<String,Object> param);
	public String uploadDocPro(MultipartFile file) throws IllegalStateException, IOException;
	public Map<String,String> getDocPro();
	
}
