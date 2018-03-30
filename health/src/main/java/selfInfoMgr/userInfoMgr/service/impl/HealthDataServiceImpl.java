package selfInfoMgr.userInfoMgr.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;

import base.constant.GlobalConstant;
import base.model.Grid;
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
	public Grid<Map<String, Object>> getHealthData(Map<String,String> param) {
		param.put("UUID", (String) session.getAttribute(GlobalConstant.LOGIN_USER));
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		PageHelper.startPage(Integer.parseInt(param.get("page")),Integer.parseInt(param.get("rows")));
		result.setRows(healthDataDao.getHealthData(param));
		result.setTotal(healthDataDao.getHealthDataCount(param));
		return result;
	}

	@Override
	public void addHealthData(Map<String, Object> param) {
	param.put("USERID", (String)session.getAttribute(GlobalConstant.LOGIN_USER));
	param.put("UUID", UUIDUtil.uuidStr());
	healthDataDao.addHealthData(param);
	}

	@Override
	public Map<String, String> getOneHealthData(Map<String, String> param) {
		return healthDataDao.getOneHealthData(param);
	}

	@Override
	public void modifyHealthData(Map<String, Object> param) {
		healthDataDao.modifyHealthData(param);
	}

	@Override
	public void deleteHealthData(Map<String, Object> param) {
		healthDataDao.deleteHealthData(param);
	}

	@Override
	public List<Map<String, Object>> getChartsData(Map<String, String> param) {
		param.put("USERID", (String)session.getAttribute(GlobalConstant.LOGIN_USER));
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = healthDataDao.getChartsData(param);
		return resultList;
	}

}
