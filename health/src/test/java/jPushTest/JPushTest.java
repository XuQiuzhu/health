package jPushTest;

import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.Notification;

public class JPushTest {
	
	private final static String ALERT = "这是测试信息";
	private final static String TITLE = "这是标题";
	private final static String MASTER_SECRET = "e6d2daef80ba3c44792eab68";
	private final static String APP_KEY = "86b04531ed04f1d18aa2dc79";
	
	public static PushPayload buildPushObject_all_all_alert() {
        return PushPayload.alertAll(ALERT);
    }
	
	public static PushPayload buildPushObject_all_alias_alert() {
        return PushPayload.newBuilder()
                .setPlatform(Platform.all())
                .setAudience(Audience.alias("alias1"))
                .setNotification(Notification.alert(ALERT))
                .build();
    }
	
	 public static PushPayload buildPushObject_android_tag_alertWithTitle() {
	        return PushPayload.newBuilder()
	                .setPlatform(Platform.all())
	                .setAudience(Audience.tag())
	                .setNotification(Notification.android(ALERT, TITLE, null))
	                .build();
	    }

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JPushClient jpushClient = new JPushClient(MASTER_SECRET, APP_KEY, null, ClientConfig.getInstance());

	    // For push, all you need do is to build PushPayload object.
	    PushPayload payload = buildPushObject_all_all_alert();

	    try {
	        PushResult result = jpushClient.sendPush(payload); 
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
	}

}
