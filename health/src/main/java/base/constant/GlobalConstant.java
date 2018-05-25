package base.constant;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.context.WebApplicationContext;


public class GlobalConstant {
	/**
	 * 当前登录用户
	 */
	public static final String LOGIN_USER = "LOGIN_USER";
	
	/**
	 * 当前系统使用的账套
	 */
	public static final String ISOLATION_CODE = "800";

	/**
	 * 当前登录用户角色
	 */
	public static final String LOGIN_USER_CURRENT_ROLE = "LOGIN_USER_CURRENT_ROLE";
	public static final String LOGIN_USER_DEFAULT_ROLE = "LOGIN_USER_DEFAULT_ROLE";
	public static final String MENU_ROOT = "0";

	/**
	 * 根 部门
	 */
	public static final String DEPARTMENT_ROOT = "0";

	/**
	 * 根部门 自身代码
	 */
	public static final String DEPARTMENT_ROOT_BM_DM = "1";
	/**
	 * 默认密码
	 */
	public static final String DEFAULT_PWD = "123456";

	public static final String USER_MENU_ROOT = "100";



	/**
	 * 超级管理员标记 1 是
	 */
	public static final String GLY_BJ = "1";
	
	/**
	 * 普通用户标记
	 */
	public static final String GLY_BJ_N = "0";



	/**
	 * 作废标记 1 作废
	 */
	public static final char ZF_BJ = '1';

	/**
	 * 作废标记 0 不作废
	 */
	public static final String ZF_BJ_N = "0";


	/**
	 * 用工性质 1 主业
	 */
	public static final String YGXZ = "1";
	/**
	 * 用工性质 0 外包
	 */
	public static final String YGXZ_N = "0";

	
	/**
	 * 用于存储临时数据
	 */
	public static Map<String,Object> map = new HashMap<String,Object>();
	
	/**
	 * 装载spring文件
	 */
	public static WebApplicationContext WEB = null;
	
	/**
	 * 定时任务执行类uuid
	 */
	public static String ZXL_UUID_SCLSWJ = "22ABB489D19D5818E050FADCE1405AB6";
	
	/**
	 * 极光推送
	 */
	public static String MASTER_SECRET = "e6d2daef80ba3c44792eab68";
	public static String APP_KEY = "86b04531ed04f1d18aa2dc79";
}
