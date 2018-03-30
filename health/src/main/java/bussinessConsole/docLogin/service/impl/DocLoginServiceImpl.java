package bussinessConsole.docLogin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import base.constant.GlobalConstant;
import bussinessConsole.docLogin.dao.IDocLoginDao;
import bussinessConsole.docLogin.service.IDocLoginService;
import util.commonUtil.EncodeUtil;
import util.commonUtil.UUIDUtil;

@Transactional
@Service
public class DocLoginServiceImpl implements IDocLoginService{

	@Autowired  
	private HttpSession session; 
	
	@Autowired  
	private HttpServletRequest request;
	
	@Autowired
	private IDocLoginDao docLoginDao;
	
	@Override
	public void register(Map<String, Object> param) {
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		param.put("PASSWORD", EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))));
		docLoginDao.docRegister(param);
	}

	@Override
	public String docLogin(Map<String, Object> param) {
		List<Map<String,Object>> resultList = docLoginDao.docLogin(param);
		Map<String,Object> result = new HashMap<String, Object>();
		if(null != resultList && resultList.size() != 0) {
			result = resultList.get(0);
			request.getSession().setAttribute(GlobalConstant.LOGIN_USER,result.get("UUID"));
			String user = (String)request.getSession().getAttribute(GlobalConstant.LOGIN_USER);
			if(String.valueOf(result.get("PASSWORD")).equals(EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))))) {
				return "success";//登录成功
			}else {
				return "wrongPwd";//密码错误
			}
		}else {
			return "wrongPhone";//手机号未注册
		}
	}

}
