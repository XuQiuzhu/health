package adminMgr.knowledgeBaseMgr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import adminMgr.knowledgeBaseMgr.service.IKonwledgeBaseMgrService;
import base.controller.BaseController;

@Controller
@RequestMapping("/knowledgeBaseMgr")
public class KonwledgeBaseMgrController extends BaseController {

	@Autowired
	private IKonwledgeBaseMgrService knowledgeBaseMgrService;
	
	@RequestMapping("/toKnowledgeBaseMgrPage")
	public String toKnowledgeBaseMgrPage() {
		return "adminMgr/knowledgeBaseMgr/knowledgeBaseMgr";
	}
	
}
