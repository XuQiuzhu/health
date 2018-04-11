package adminMgr.knowledgeBaseMgr.service.impl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import adminMgr.knowledgeBaseMgr.dao.IKonwledgeBaseMgrDao;
import adminMgr.knowledgeBaseMgr.service.IKonwledgeBaseMgrService;

@Service
@Transactional
public class KonwledgeBaseMgrServiceImpl implements IKonwledgeBaseMgrService {

	@Autowired
	private IKonwledgeBaseMgrDao konwledgeBaseMgrDao;
	
	@Autowired
	private HttpSession session;
	
}
