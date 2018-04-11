package base.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import base.service.IExcelService;
import util.excel.ExportExcel;

@Service
@Transactional
public class ExcelServiceImpl implements IExcelService {

	@Override
	public String ExportModelExcel() {
		String downLoadPath = "";
		ExportExcel export = new ExportExcel(); 
		downLoadPath = export.exportModelExcel();
		
		return downLoadPath;
	}

}
