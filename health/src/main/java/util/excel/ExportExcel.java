package util.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;

public class ExportExcel {

	public String exportModelExcel(){
		
		String filepath="";
		String sheetName = "数据导入模板";
		try{
			HSSFWorkbook workBook = new HSSFWorkbook();//创建工作簿
			HSSFSheet sheet = workBook.createSheet(sheetName);//创建sheet
			
			HSSFCellStyle columnTopStyle = this.getStyle(workBook,(short)11,"宋体");//获取列头样式对象
			HSSFCellStyle titleStyle = this.getTitleStyle(workBook);//数据单元格样式对象 
			//HSSFCellStyle dataStyle = this.getDataStyle(workBook);//数据单元格样式对象 getSignStyle
			
			// 创建一个单元格，从0开始,第一行
			HSSFRow rowTitle = sheet.createRow(0);
			rowTitle.setHeight((short)350);
			HSSFCell cellTiltle = rowTitle.createCell(0);//标题行  
			mergeCELLS(sheet,columnTopStyle,0,0,0,9);
			cellTiltle.setCellValue(sheetName); //设置标题
			
			// 创建二个单元格，第二行
			HSSFRow oneRow = sheet.createRow(1);
			rowTitle.setHeight((short)350);
			
			HSSFCell heartrate = oneRow.createCell(0);
			mergeCELLS(sheet,titleStyle,1,1,0,0);
			heartrate.setCellValue("心率");
			
			HSSFCell highpressure = oneRow.createCell(1);
			mergeCELLS(sheet,titleStyle,1,1,1,1);
			highpressure.setCellValue("高压");
			
			HSSFCell lowpressure = oneRow.createCell(2);
			mergeCELLS(sheet,titleStyle,1,1,2,2);
			lowpressure.setCellValue("低压");
			
			HSSFCell bloodsugar = oneRow.createCell(3);
			mergeCELLS(sheet,titleStyle,1,1,3,3);
			bloodsugar.setCellValue("血糖");
			
			HSSFCell bloodlipid = oneRow.createCell(4);
			mergeCELLS(sheet,titleStyle,1,1,4,4);
			bloodlipid.setCellValue("血清甘油三酯");
			
			HSSFCell highcholesterol = oneRow.createCell(5);
			mergeCELLS(sheet,titleStyle,1,1,5,5);
			highcholesterol.setCellValue("高密度脂蛋白胆固醇");
			
			HSSFCell cholesterol = oneRow.createCell(6);
			mergeCELLS(sheet,titleStyle,1,1,6,6);
			cholesterol.setCellValue("血清总胆固醇");
			
			HSSFCell trioxypurine = oneRow.createCell(7);
			mergeCELLS(sheet,titleStyle,1,1,7,7);
			trioxypurine.setCellValue("尿酸");
			
			HSSFCell temperature = oneRow.createCell(8);
			mergeCELLS(sheet,titleStyle,1,1,8,8);
			temperature.setCellValue("体温");
			
			HSSFCell createtime = oneRow.createCell(9);
			mergeCELLS(sheet,titleStyle,1,1,9,9);
			createtime.setCellValue("测量日期（格式2018-01-01 08:30:45）");
			
			
			/*
			 * 调整列宽
			 */
			//sheet.setColumnWidth(0,18*256);//第一列
			//sheet.setColumnWidth(1,18*256);//第二列
			
			/*
			 * 导出文件
			 */
		 File file = new File(System.getProperty("java.io.tmpdir"), getDateString().toString() +".xls");
	     FileOutputStream out = new FileOutputStream(file);
			workBook.write(out);
			out.close();
			File zipFile = new File(System.getProperty("java.io.tmpdir"),UUID.randomUUID().toString() + "test.zip");
			FileOutputStream outzip = new FileOutputStream(zipFile); 
			ZipOutputStream zipOutputStream = new ZipOutputStream(outzip);
			
			ZipEntry zipEntry = null;
			byte[] buffer = new byte[1024];
			int readtotal;
			
			zipEntry = new ZipEntry(file.getName());
			zipOutputStream.putNextEntry(zipEntry);
			FileInputStream in = new FileInputStream(file);
			while((readtotal = in.read(buffer)) > 0){
				zipOutputStream.write(buffer, 0, readtotal);
			}
			in.close();
			zipOutputStream.close();
			outzip.close();
			if(null != file){
				file.delete();
			}
			filepath = zipFile.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return filepath;
		
	}
	
	 private static  String getDateString() {
			return new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
		}
	
	/*  
     * 合并单元格 并设置样式
     */ 
	private void mergeCELLS(HSSFSheet sheet,HSSFCellStyle cs,int startRow,int endRow,int startCol,int endCol){
		CellRangeAddress region = new CellRangeAddress(startRow, endRow, startCol, endCol);
		sheet.addMergedRegion(region);
		for (int i = region.getFirstRow(); i <= region.getLastRow(); i++) {
		    HSSFRow row = HSSFCellUtil.getRow(i, sheet);
			for (int j = region.getFirstColumn(); j <= region.getLastColumn(); j++) {
				HSSFCell cell = HSSFCellUtil.getCell(row, (short) j);
				cell.setCellStyle(cs);
			}
		}
	}
	
	/*  
     * 单元格样式 
     */      
    public HSSFCellStyle getStyle(HSSFWorkbook workbook,short fontHeight,String fontName) {  
          
          // 设置字体  
          HSSFFont font = workbook.createFont();  
          //设置字体大小  
          font.setFontHeightInPoints(fontHeight);  
          //字体加粗  
          font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
          //设置字体名字   
          font.setFontName(fontName);  
          //设置样式;   
          HSSFCellStyle style = workbook.createCellStyle();    
          //在样式用应用设置的字体;    
          style.setFont(font);  
          //设置自动换行;   
          style.setWrapText(false);  
          //设置水平对齐的样式为居中对齐;    
          style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
          //设置垂直对齐的样式为居中对齐;   
          style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
          //设置底边框;   
          style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
          //设置底边框颜色;    
          style.setBottomBorderColor(HSSFColor.BLACK.index);  
          //设置左边框;     
          style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
          //设置左边框颜色;   
          style.setLeftBorderColor(HSSFColor.BLACK.index);  
          //设置右边框;   
          style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
          //设置右边框颜色;   
          style.setRightBorderColor(HSSFColor.BLACK.index);  
          //设置顶边框;   
          style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
          //设置顶边框颜色;    
          style.setTopBorderColor(HSSFColor.BLACK.index);  
            
          return style;  
            
    }   
    
    /*  
     * 列头单元格样式 
     */      
    public HSSFCellStyle getTitleStyle(HSSFWorkbook workbook) {  
    	// 设置字体  
        HSSFFont font = workbook.createFont();  
        //设置字体大小  
        font.setFontHeightInPoints((short) (9));  
        //字体加粗  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        //设置字体名字   
        font.setFontName("宋体");  
        //设置样式;   
        HSSFCellStyle style = workbook.createCellStyle();    
        //在样式用应用设置的字体;    
        style.setFont(font);  
        //设置自动换行;   
        style.setWrapText(true);  
        //设置水平对齐的样式为居中对齐;    
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        //设置垂直对齐的样式为居中对齐;   
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
          //设置样式;    
          //设置底边框;   
          style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
          //设置底边框颜色;    
          style.setBottomBorderColor(HSSFColor.BLACK.index);  
          //设置左边框;     
          style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
          //设置左边框颜色;   
          style.setLeftBorderColor(HSSFColor.BLACK.index);  
          //设置右边框;   
          style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
          //设置右边框颜色;   
          style.setRightBorderColor(HSSFColor.BLACK.index);  
          //设置顶边框;   
          style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
          //设置顶边框颜色;    
          style.setTopBorderColor(HSSFColor.BLACK.index);  
          return style;  
    }  
    
    public HSSFCellStyle getDataStyle(HSSFWorkbook workbook) {  
    	// 设置字体  
        HSSFFont font = workbook.createFont();  
        //设置字体大小  
        font.setFontHeightInPoints((short) (9));  
        //字体加粗  
        //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        //设置字体名字   
        font.setFontName("宋体");  
        //设置样式;   
        HSSFCellStyle style = workbook.createCellStyle();    
        //在样式用应用设置的字体;    
        style.setFont(font);  
        //设置自动换行;   
        style.setWrapText(true);  
        //设置水平对齐的样式为居中对齐;    
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        //设置垂直对齐的样式为居中对齐;   
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
          //设置样式;    
          //设置底边框;   
          style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
          //设置底边框颜色;    
          style.setBottomBorderColor(HSSFColor.BLACK.index);  
          //设置左边框;     
          style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
          //设置左边框颜色;   
          style.setLeftBorderColor(HSSFColor.BLACK.index);  
          //设置右边框;   
          style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
          //设置右边框颜色;   
          style.setRightBorderColor(HSSFColor.BLACK.index);  
          //设置顶边框;   
          style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
          //设置顶边框颜色;    
          style.setTopBorderColor(HSSFColor.BLACK.index);
          return style;  
            
    } 
}
