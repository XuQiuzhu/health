package bussinessConsole.userLogin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import base.constant.GlobalConstant;
import bussinessConsole.userLogin.dao.UserLoginDao;
import bussinessConsole.userLogin.service.IUserLoginService;
import util.commonUtil.EncodeUtil;
import util.commonUtil.UUIDUtil;

@Transactional
@Service
public class UserLoginServiceImpl implements IUserLoginService {

	@Autowired  
	private HttpSession session; 
	
	@Autowired  
	private HttpServletRequest request; 
	
	@Autowired
	private UserLoginDao userLoginDao;
	
	@Override
	public void register(Map<String, Object> param) {
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		param.put("PASSWORD", EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))));
		userLoginDao.register(param);
	}

	@Override
	public String userLogin(Map<String, Object> param) {
		List<Map<String,Object>> resultList = userLoginDao.userLogin(param);
		Map<String,Object> result = new HashMap<String, Object>();
		if(null != resultList && resultList.size() != 0) {
			result = resultList.get(0);
			request.getSession().setAttribute(GlobalConstant.LOGIN_USER,result.get("UUID"));
			//String user = (String)request.getSession().getAttribute(GlobalConstant.LOGIN_USER);
			if(String.valueOf(result.get("PASSWORD")).equals(EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))))) {
				return "success";//登录成功
			}else {
				return "wrongPwd";//密码错误
			}
		}else {
			return "wrongPhone";//手机号未注册
		}
	}

	@Override
	public void loginOut() {
		session.removeAttribute(GlobalConstant.LOGIN_USER);
	}

}
