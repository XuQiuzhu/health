package android.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import android.dao.IAndroidDao;
import android.service.IAndroidService;
import util.algorithm.MD5;
import util.commonUtil.EncodeUtil;
import util.commonUtil.UUIDUtil;

@Service
@Transactional
public class AndroidServiceImpl implements IAndroidService{

	@Autowired
	private IAndroidDao androidDao;
	
	@Override
	public Map<String, Object> androidUserLogin(Map<String, Object> param) {
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> result = new HashMap<String, Object>();
		resultList = androidDao.androidUserLogin(param);
		if(resultList.size() > 0) {
			if(EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))).equals(resultList.get(0).get("PASSWORD"))) {
				result.put("userInfo", resultList.get(0));
				result.put("msg", "登录成功");
				result.put("result", true);
			}else {
				result.put("result", false);
				result.put("msg", "密码错误");
			}
		}
		else {
			result.put("result", false);
			result.put("msg", "账号不存在");
		}
		return result;
	}

	@Override
	public Map<String, Object> androidDocLogin(Map<String, Object> param) {
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> result = new HashMap<String, Object>();
		resultList = androidDao.androidDocLogin(param);
		if(resultList.size() > 0) {
			if(EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))).equals(resultList.get(0).get("PASSWORD"))) {
				result.put("doc", resultList.get(0));
				result.put("msg", "登录成功");
				result.put("result", true);
			}else {
				result.put("result", false);
				result.put("msg", "密码错误");
			}
		}
		else {
			result.put("result", false);
			result.put("msg", "账号不存在");
		}
		return result;
	}

	@Override
	public void androidDocRegister(Map<String, Object> param) {
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		param.put("PASSWORD", EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))));
		androidDao.androidDocRegister(param);
	}

	@Override
	public void androidUserRegister(Map<String, Object> param) {
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		param.put("PASSWORD", EncodeUtil.encode(String.valueOf(param.get("PASSWORD"))));
		androidDao.androidUserRegister(param);
	}
	
	@Override
	public List<Map<String, String>> androidGetAllDepartment() {
		return androidDao.androidGetAllDepartment();
	}

	@Override
	public void androidDocInfoChange(Map<String, Object> param) {
		androidDao.androidDocInfoChange(param);
	}

	@Override
	public Map<String, Object> getUserList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.getUserList(param);
		result.put("userList", resultList);
		return result;
	}

	@Override
	public Map<String, Object> getRemarkList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.getRemarkList(param);
		result.put("remarkList", resultList);
		return result;
	}

	@Override
	public Map<String, Object> getUserData(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.getUserData(param);
		result.put("userDataList", resultList);
		return result;
	}

	@Override
	public Map<String, Object> getDocReserve(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.getDocReserve(param);
		result.put("reserveList", resultList);
		return result;
	}

	@Override
	public void androidUserInfoChange(Map<String, Object> param) {
		androidDao.androidUserInfoChange(param);
	}

	@Override
	public Map<String, Object> getDocList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.getDocList(param);
		result.put("docList", resultList);
		return result;
	}

	@Override
	public void setUserData(Map<String, Object> param) {
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		Map<String,Object> result = androidDao.androidGetUserUUID(param).get(0);
		param.put("USERID", result.get("UUID"));
		androidDao.setUserData(param);
	}
	
	@Override
	public Map<String,Object> setDocReserve(Map<String, Object> param){
		Map<String, Object> param1 = new HashMap<String, Object>();
		param1.put("phone", param.get("DOCPHONE"));
		String UUID = UUIDUtil.uuidStr();
		param.put("UUID", UUID);
		Map<String,Object> resultDoc = androidDao.androidGetDocUUID(param1).get(0);
		param.put("docUUID", resultDoc.get("UUID"));
		param1.put("phone", param.get("USERPHONE"));
		Map<String,Object> resultUser = androidDao.androidGetUserUUID(param).get(0);
		param.put("USERUUID", resultUser.get("UUID"));
		androidDao.setDocReserve(param);
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		resultList = androidDao.androidGetAllReserve(param);
		result.put("reserveList", resultList);
		return result;
	}

	@Override
	public void handleDocReserve(Map<String, Object> param) {
		androidDao.handleDocReserve(param);
	}
	
}
