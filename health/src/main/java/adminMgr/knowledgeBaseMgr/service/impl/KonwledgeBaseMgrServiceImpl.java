package adminMgr.knowledgeBaseMgr.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;

import adminMgr.knowledgeBaseMgr.dao.IKonwledgeBaseMgrDao;
import adminMgr.knowledgeBaseMgr.service.IKonwledgeBaseMgrService;
import base.model.Grid;
import util.commonUtil.UUIDUtil;

@Service
@Transactional
public class KonwledgeBaseMgrServiceImpl implements IKonwledgeBaseMgrService {

	@Autowired
	private IKonwledgeBaseMgrDao konwledgeBaseMgrDao;
	
	@Autowired
	private HttpSession session;

	@Override
	public Grid<Map<String, Object>> getKnowledgeData(Map<String, String> param) {
		Grid<Map<String, Object>> result = new Grid<Map<String,Object>>();
		PageHelper.startPage(Integer.parseInt(param.get("page")),Integer.parseInt(param.get("rows")));
		result.setRows(konwledgeBaseMgrDao.getKnowledgeData(param));
		result.setTotal(konwledgeBaseMgrDao.getKnowledgeDataCount(param));
		return result;
	}

	@Override
	public List<Map<String, String>> getClassification() {
		return konwledgeBaseMgrDao.getClassification();
	}

	@Override
	public void addKnowledgeData(Map<String, Object> param) {
		param.put("UUID", UUIDUtil.uuidStr());
		konwledgeBaseMgrDao.addKnowledgeData(param);
	}

	@Override
	public Map<String, String> getOneKnowledgeData(Map<String, String> param) {
		return konwledgeBaseMgrDao.getOneKnowledgeData(param);
	}

	@Override
	public void modifyKnowledgeData(Map<String, Object> param) {
		konwledgeBaseMgrDao.modifyKnowledgeData(param);
	}

	@Override
	public void deleteKnowledgeData(Map<String, Object> param) {
		konwledgeBaseMgrDao.deleteKnowledgeData(param);
	}
	
}
