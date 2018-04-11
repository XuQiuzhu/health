package base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import base.constant.GlobalConstant;
import base.service.IExcelService;
import selfInfoMgr.userInfoMgr.dao.IHealthDataDao;
import util.excel.ExportExcel;
import util.excel.ReadExcel;

@Service
@Transactional
public class ExcelServiceImpl implements IExcelService {
	
	@Autowired
	private IHealthDataDao healthDataDao;
	
	@Autowired
	private HttpSession session;

	@Override
	public String ExportModelExcel() {
		String downLoadPath = "";
		ExportExcel export = new ExportExcel(); 
		downLoadPath = export.exportModelExcel();
		
		return downLoadPath;
	}
	
	@Override
	public String readExcelFile(MultipartFile file) {
		//Map<String,String> result = new HashMap<String, String>();
	        //创建处理EXCEL的类  
	        ReadExcel readExcel=new ReadExcel();  
	        //解析excel，获取上传的事件单  
	        List<Map<String,Object>> dataList = readExcel.getExcelInfo(file,String.valueOf(session.getAttribute(GlobalConstant.LOGIN_USER)));  
	        //至此已经将excel中的数据转换到list里面了,接下来就可以操作list,可以进行保存到数据库,或者其他操作,  
	        //和你具体业务有关,这里不做具体的示范  
	        if(null != dataList && dataList.size() != 0) {
	        	healthDataDao.excelImpDatas(dataList);
	        	return "success";
	        }else {
	        	return "null";
	        }
	    }

}
