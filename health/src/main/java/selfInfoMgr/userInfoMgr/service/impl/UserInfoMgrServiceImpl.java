package selfInfoMgr.userInfoMgr.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import base.constant.GlobalConstant;
import selfInfoMgr.userInfoMgr.dao.IUserInfoMgrDao;
import selfInfoMgr.userInfoMgr.service.IUserInfoMgrService;

@Transactional
@Service
public class UserInfoMgrServiceImpl implements IUserInfoMgrService {

	@Autowired  
	private HttpSession session;
	
	@Autowired  
	private HttpServletRequest request;
	
	@Autowired
	private IUserInfoMgrDao userInfoMgrDao;
	
	@Override
	public Map<String, Object> getUserInfo() {
		Map<String, String> param = new HashMap<String, String>();
		param.put("UUID", (String) session.getAttribute(GlobalConstant.LOGIN_USER));
		Map<String, Object> result = userInfoMgrDao.getUserInfo(param);
		System.out.println(result);
		return result;
	}

	@Override
	public void updateUserInfo(Map<String, Object> param) {
		userInfoMgrDao.updateUserInfo(param);
	}

	@Override
	public String uploadUserPro(MultipartFile file) throws IllegalStateException, IOException {
		Map<String,String> update = new HashMap<String, String>();
        String pathRoot = session.getServletContext().getRealPath("");  
        String path="";  
	        if(!file.isEmpty()){  
	            //生成uuid作为文件名称  
	            String uuid = UUID.randomUUID().toString().replaceAll("-","");  
	            //获得文件类型（可以判断如果不是图片，禁止上传）  
	            String contentType=file.getContentType();  
	            //获得文件后缀名称  
	            String imageName=contentType.substring(contentType.indexOf("/")+1);  
	            path="/static/images/"+uuid+"."+imageName;  
	            file.transferTo(new File(pathRoot+path));  
	            update.put("PORTRAIT", path);
	            update.put("UUID", (String) session.getAttribute(GlobalConstant.LOGIN_USER));
	            userInfoMgrDao.uploadUserPro(update);
        }
	        return path;
	}

}
