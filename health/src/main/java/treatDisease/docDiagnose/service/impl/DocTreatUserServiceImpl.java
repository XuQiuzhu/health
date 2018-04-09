package treatDisease.docDiagnose.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;

import base.constant.GlobalConstant;
import base.model.Grid;
import selfInfoMgr.userInfoMgr.dao.IHealthDataDao;
import treatDisease.docDiagnose.dao.IDocTreatUserDao;
import treatDisease.docDiagnose.service.IDocTreatUserService;
import util.commonUtil.UUIDUtil;

@Transactional
@Service
public class DocTreatUserServiceImpl implements IDocTreatUserService {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private IDocTreatUserDao docTreatUserDao;
	
	@Autowired
	private IHealthDataDao healthDataDao;

	@Override
	public void manageSubscribe(Map<String, Object> param) {
		docTreatUserDao.manageSubscribe(param);
	}

	@Override
	public Grid<Map<String, String>> getSubscribeReq(Map<String, String> param) {
		Grid<Map<String, String>> result = new Grid<Map<String,String>>();
		param.put("DOCUUID", (String) session.getAttribute(GlobalConstant.LOGIN_USER));
		PageHelper.startPage(Integer.parseInt(param.get("page")),Integer.parseInt(param.get("rows")));
		result.setRows(docTreatUserDao.getSubscribeReq(param));
		result.setTotal(docTreatUserDao.getSubscribeReqCount(param));
		return result;
	}

	@Override
	public Grid<Map<String, Object>> getHealthDataLook(Map<String, String> param) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		PageHelper.startPage(Integer.parseInt(param.get("page")),Integer.parseInt(param.get("rows")));
		result.setRows(healthDataDao.getHealthData(param));
		result.setTotal(healthDataDao.getHealthDataCount(param));
		return result;
	}

	@Override
	public Map<String, String> getOneSub(Map<String, String> param) {
		return docTreatUserDao.getOneSub(param);
	}

	@Override
	public void docDoTreat(Map<String, Object> param) {
		param.put("UUID", UUIDUtil.uuidStr());
		docTreatUserDao.docDoTreat(param);
		docTreatUserDao.modifySubTreatStu(param);
	}

	@Override
	public List<Map<String, String>> getDiseasetype() {
		return docTreatUserDao.getDiseasetype();
	}
	
}
