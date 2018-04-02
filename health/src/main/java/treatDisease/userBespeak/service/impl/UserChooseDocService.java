package treatDisease.userBespeak.service.impl;

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
import net.sf.jsqlparser.expression.StringValue;
import treatDisease.userBespeak.dao.IUserChooseDocDao;
import treatDisease.userBespeak.service.IUserChooseDocService;
import util.commonUtil.UUIDUtil;

@Transactional
@Service
public class UserChooseDocService implements IUserChooseDocService {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private IUserChooseDocDao userChooseDocDao;

	@Override
	public List<Map<String, String>> getAllDepartment() {
		return userChooseDocDao.getAllDepartment();
	}

	@Override
	public Grid<Map<String, Object>> getAllDocs(Map<String, String> param) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		PageHelper.startPage(Integer.parseInt(param.get("page")),Integer.parseInt(param.get("rows")));
		result.setRows(userChooseDocDao.getAllDocs(param));
		result.setTotal(userChooseDocDao.getAllDocsCount(param));
		return result;
	}

	@Override
	public Map<String, String> getOneDocInfo(Map<String, String> param) {
		return userChooseDocDao.getOneDocInfo(param);
	}

	@Override
	public void buildReservation(Map<String, Object> param) {
		String userUUID = (String) session.getAttribute(GlobalConstant.LOGIN_USER);
		String UUID = UUIDUtil.uuidStr();
		param.put("userUUID", userUUID);
		param.put("UUID", UUID);
		userChooseDocDao.buildReservation(param);
	}

	@Override
	public Grid<Map<String,Object>> getSubscribeHis(Map<String, Object> param) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		param.put("UUID",session.getAttribute(GlobalConstant.LOGIN_USER));
		PageHelper.startPage(Integer.parseInt(String.valueOf(param.get("page"))),Integer.parseInt(String.valueOf(param.get("rows"))));
		result.setRows(userChooseDocDao.getSubscribeHis(param));
		result.setTotal(userChooseDocDao.getSubscribeHisCount(param));
		return result;
	}

	@Override
	public Map<String, String> getOneSubscribe(Map<String, String> param) {
		return userChooseDocDao.getOneSubscribe(param);
	}

	@Override
	public void modifySub(Map<String, String> param) {
		userChooseDocDao.updateSubscribe(param);;
	}

	@Override
	public void deleteSub(Map<String, String> param) {
		userChooseDocDao.deleteSub(param);
		
	}

	@Override
	public Map<String, String> getDiagnoseDetail(Map<String, String> param) {
		return userChooseDocDao.getDiagnoseDetail(param);
	}

	@Override
	public void addFeedback(Map<String, String> param) {
		String userUUID = (String) session.getAttribute(GlobalConstant.LOGIN_USER);
		String UUID = UUIDUtil.uuidStr();
		param.put("USERID", userUUID);
		param.put("UUID", UUID);
		userChooseDocDao.addFeedback(param);
		userChooseDocDao.modifySub(param);
	}
	
}
