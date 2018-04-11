package adminMgr.login.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import adminMgr.login.dao.IAdminLoginDao;
import adminMgr.login.service.IAdminLoginService;
import base.constant.GlobalConstant;
import util.commonUtil.EncodeUtil;

@Service
@Transactional
public class AdminLoginServiceImpl implements IAdminLoginService {
	
	@Autowired
	private IAdminLoginDao adminLoginDao;
	
	@Autowired
	private HttpSession seesion;

	@Override
	public String adminLogin(Map<String, Object> param) {
		List<Map<String,Object>> resultList = adminLoginDao.adminLogin(param);
		Map<String,Object> result = new HashMap<String, Object>();
		if(null != resultList && resultList.size() != 0) {
			result = resultList.get(0);
			if(String.valueOf(result.get("PASSWORD")).equals(EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))))) {
				seesion.setAttribute(GlobalConstant.LOGIN_USER,result.get("UUID"));
				return "success";//登录成功
			}else {
				return "wrongPwd";//密码错误
			}
		}else {
			return "wrongPhone";//手机号未注册
		}
	}


}
