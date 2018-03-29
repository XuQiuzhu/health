package selfInfoMgr.userInfoMgr.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import base.constant.GlobalConstant;
import selfInfoMgr.userInfoMgr.dao.IHealthDataDao;
import selfInfoMgr.userInfoMgr.service.IHealthdataService;
import util.commonUtil.UUIDUtil;

@Transactional
@Service
public class HealthDataServiceImpl implements IHealthdataService{

	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private IHealthDataDao healthDataDao;
	
	@Override
	public List<Map<String, Object>> getHealthData(Map<String,Object> param) {
		String UUID = (String) session.getAttribute(GlobalConstant.LOGIN_USER);
		param.put("UUID", (String) session.getAttribute(GlobalConstant.LOGIN_USER));
		List<Map<String,Object>> result = healthDataDao.getHealthData(param);
		return result;
	}

	@Override
	public void addHealthData(Map<String, Object> param) {
	param.put("USERID", (String)session.getAttribute(GlobalConstant.LOGIN_USER));
	param.put("UUID", UUIDUtil.uuidStr());
	healthDataDao.addHealthData(param);
	}

}
