package adminMgr.pushMgr.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import base.constant.GlobalConstant;
import base.controller.BaseController;
import base.exception.IServiceException;
import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.PushPayload;
import util.jPushUtil.JPushUtil;

@Controller
@RequestMapping("/PushMgrController")
public class PushMgrController extends BaseController {

	@RequestMapping("/toNewPushPage")
	public String toNewPushPage() {
		return "adminMgr/push/newPush";
	}
	
	@RequestMapping("/toAddANewPushPage")
	public String toAddANewPushPage() {
		return "adminMgr/push/addANewPush";
	}
	
	@RequestMapping("/addATreat")
	public void addATreat(HttpServletRequest request,HttpServletResponse response) {
		PushResult result = new PushResult();
		Map<String, Object> param = new HashMap<String, Object>();
		String data = request.getParameter("data");
		if(null != data && !"".equals(data)) {
			param =  new Gson().fromJson(data, new TypeToken<Map<String, Object>>() {}.getType());
		}
		JPushClient jpushClient = new JPushClient(GlobalConstant.MASTER_SECRET, GlobalConstant.APP_KEY, null, ClientConfig.getInstance());

	    // For push, all you need do is to build PushPayload object.
	    PushPayload payload = JPushUtil.buildPushObject_all_all_alert(String.valueOf(param.get("CONTENT")));
	    try {
	        result = jpushClient.sendPush(payload); 
	        //LOG.info("Got result - " + result);
	        System.out.println("Got result - " + result);

	    } catch (APIConnectionException e) {
	        // Connection error, should retry later
	        //LOG.error("Connection error, should retry later", e);
	    	System.out.println("Connection error, should retry later"+ e);

	    } catch (APIRequestException e) {
	        // Should review the error, and fix the request
	        /*LOG.error("Should review the error, and fix the request", e);
	        LOG.info("HTTP Status: " + e.getStatus());
	        LOG.info("Error Code: " + e.getErrorCode());
	        LOG.info("Error Message: " + e.getErrorMessage());*/
	    	System.out.println("Should review the error, and fix the request"+ e);
	    	System.out.println("HTTP Status: " + e.getStatus());
	    	System.out.println("Error Code: " + e.getErrorCode());
	    	System.out.println("Error Message: " + e.getErrorMessage());
	    }
			printHttpServletResponse(new Gson().toJson(result),response);
	}
	
}
