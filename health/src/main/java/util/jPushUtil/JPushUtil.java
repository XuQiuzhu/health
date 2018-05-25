package util.jPushUtil;

import cn.jpush.api.push.model.PushPayload;

public class JPushUtil {

	public static PushPayload buildPushObject_all_all_alert(String alert) {
        return PushPayload.alertAll(alert);
    }
	
}
