package base.service;

import org.springframework.web.multipart.MultipartFile;

public interface IExcelService {

	public String ExportModelExcel();
	public String readExcelFile(MultipartFile file);
	
}
