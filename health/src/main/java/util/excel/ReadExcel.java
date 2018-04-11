package util.excel;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.format.CellFormatType;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import base.constant.GlobalConstant;
import util.commonUtil.UUIDUtil;

public class ReadExcel {
	//总行数  
    private int totalRows = 0;    
    //总条数  
    private int totalCells = 0;   
    //错误信息接收器  
    private String errorMsg;  
    //构造方法  
    public ReadExcel(){}  
    //获取总行数  
    public int getTotalRows()  { return totalRows;}   
    //获取总列数  
    public int getTotalCells() {  return totalCells;}   
    //获取错误信息  
    public String getErrorInfo() { return errorMsg; }    
      
  /** 
   * 读EXCEL文件，获取信息集合 
   * @param fielName 
   * @return 
   */  
    public List<Map<String,Object>> getExcelInfo(MultipartFile mFile,String userUUID) {  
        String fileName = mFile.getOriginalFilename();//获取文件名  
        List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
        try {  
            if (!validateExcel(fileName)) {// 验证文件名是否合格  
                return null;  
            }  
            boolean isExcel2003 = true;// 根据文件名判断文件是2003版本还是2007版本  
            if (isExcel2007(fileName)) {  
                isExcel2003 = false;  
            }  
            dataList = createExcel(mFile.getInputStream(), isExcel2003,userUUID);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return dataList;  
    }  
    
  /** 
   * 根据excel里面的内容读取客户信息 
   * @param is 输入流 
   * @param isExcel2003 excel是2003还是2007版本 
   * @return 
   * @throws IOException 
   */  
    public List<Map<String,Object>> createExcel(InputStream is, boolean isExcel2003,String userUUID) { 
    	List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
        try{  
            Workbook wb = null;  
            if (isExcel2003) {// 当excel是2003时,创建excel2003  
                wb = new HSSFWorkbook(is);  
            } else {// 当excel是2007时,创建excel2007  
                wb = new XSSFWorkbook(is);  
            }  
            dataList = readExcelValue(wb,userUUID);// 读取Excel里面客户的信息  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return dataList;  
    }  
    
  /** 
   * 读取Excel里面客户的信息 
   * @param wb 
   * @return 
   */  
    private List<Map<String,Object>> readExcelValue(Workbook wb,String userUUID) {  
        // 得到第一个shell  
        Sheet sheet = wb.getSheetAt(0);  
        // 得到Excel的行数  
        this.totalRows = sheet.getPhysicalNumberOfRows();  
        // 得到Excel的列数(前提是有行数)  
        if (totalRows > 1 && sheet.getRow(0) != null) {  
            this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();  
        }  
        List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();  
        // 循环Excel行数  
        for (int r = 2; r < totalRows; r++) {  
            Row row = sheet.getRow(r);  
            if (row == null){  
                continue;  
            }  
            Map<String,Object> data = new HashMap<String,Object>(); 
            data.put("UUID", UUIDUtil.uuidStr());//主键
            data.put("USERID", userUUID);//用户uuid
            // 循环Excel的列  
            for (int c = 0; c < this.totalCells; c++) {  
                Cell cell = row.getCell(c); 
                //cell.setCellType(Cell.CELL_TYPE_STRING);
                if (null != cell) {  
                    if (c == 0) {  
                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25  
                        /*if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){  
                            String name = String.valueOf(cell.getNumericCellValue());  
                            user.setName(name.substring(0, name.length()-2>0?name.length()-2:1));//名称  
                        }else{  
                            user.setName(cell.getStringCellValue());//名称  
                        }*/  
                    	data.put("HEARTRATE", cell.getNumericCellValue());//心率
                    } else if (c == 1) {  
                    	data.put("HIGHPRESSURE", cell.getNumericCellValue());//高压
                    } else if (c == 2){  
                    	data.put("LOWPRESSURE", cell.getNumericCellValue());//低压  
                    } else if (c == 3){  
                    	data.put("BLOODSUGAR", cell.getNumericCellValue());//血糖
                    } else if (c == 4){  
                    	data.put("BLOODLIPID", cell.getNumericCellValue());//血清甘油三酯
                    } else if (c == 5){  
                    	data.put("HIGHCHOLESTEROL", cell.getNumericCellValue());//高密度脂蛋白胆固醇
                    } else if (c == 6){  
                    	data.put("CHOLESTEROL", cell.getNumericCellValue());//血清总胆固醇
                    } else if (c == 7){  
                    	data.put("TRIOXYPURINE", cell.getNumericCellValue());//尿酸
                    } else if (c == 8){  
                    	data.put("TEMPERATURE", cell.getNumericCellValue());//体温
                    } else if (c == 9){  
                    	//data.put("CREATETIME", cell.getDateCellValue());//创建日期
                    	/*if(cell.getStringCellValue()!=null){
                    		try {
								data.put("CREATETIME",new SimpleDateFormat("yyyy-MM-dd").parse(cell.getStringCellValue()));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
                    	     }*/
                   if(cell.getCellType() == 0) {
                        if(HSSFDateUtil.isCellDateFormatted(cell)){
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            data.put("CREATETIME",sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue())));
                        }
                    	}
                    }
                   }  
                }  
            // 添加到list  
        dataList.add(data);  
        }  
        return dataList;  
    }  
      
    /** 
     * 验证EXCEL文件 
     *  
     * @param filePath 
     * @return 
     */  
    public boolean validateExcel(String filePath) {  
        if (filePath == null || !(isExcel2003(filePath) || isExcel2007(filePath))) {  
            errorMsg = "文件名不是excel格式";  
            return false;  
        }  
        return true;  
    }  
      
    // @描述：是否是2003的excel，返回true是2003   
    public static boolean isExcel2003(String filePath)  {    
         return filePath.matches("^.+\\.(?i)(xls)$");    
     }    
     
    //@描述：是否是2007的excel，返回true是2007   
    public static boolean isExcel2007(String filePath)  {    
         return filePath.matches("^.+\\.(?i)(xlsx)$");    
     }    
}
