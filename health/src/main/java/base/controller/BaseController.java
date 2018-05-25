package base.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import util.commonUtil.HttpUtil;

@Controller
@RequestMapping("/BaseController")
public class BaseController {

	public void printHttpServletResponse(Object obj,HttpServletResponse response)
	  {
	    HttpUtil.printHttpServletResponse(obj,response);
	  }
	
	@RequestMapping("/index")
	public String SessionOutToIndex() {
		return "index";
	}
	
	public static void download(HttpServletRequest request,HttpServletResponse response, String filePath, String backFilname) {
		File file = null;

		FileInputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			//Linux系统用
			if (filePath.lastIndexOf("/")>0) {
				file=new File(filePath);
			}else {
				//windows系统用
				file = new File(filePath);
			}

			inputStream = new FileInputStream(file);
			outputStream = response.getOutputStream();

			response.setCharacterEncoding("UTF-8");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.setContentType("application/x-download charset=UTF-8");

			setContentDisposition(request, response, backFilname);

			byte[] buffer = new byte[1024];
			int total;

			while ((total = inputStream.read(buffer)) > 0) {
				outputStream.write(buffer, 0, total);
			}

			outputStream.flush();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != outputStream) {
					outputStream.close();
				}

				if (null != inputStream) {
					inputStream.close();
				}

			} catch (IOException e) {
				e.printStackTrace();
			}
			file.delete();
		}
	}
	
	private static void setContentDisposition(HttpServletRequest request,HttpServletResponse response, String showName)
			throws UnsupportedEncodingException {
		String userAgent = request.getHeader("USER-AGENT").toLowerCase();
		String contentDisposition = "";
		if (userAgent != null) {
			if (userAgent.indexOf("msie") >= 0) {
				contentDisposition = "attachment; filename="
						+ URLEncoder.encode(showName, "UTF-8").replace("+",
								"%20");

			} else if (userAgent.indexOf("mozilla") >= 0) {
				contentDisposition = "attachment; filename*=UTF-8''"
						+ URLEncoder.encode(showName, "UTF-8").replace("+",
								"%20");

			} else if (userAgent.indexOf("applewebkit") >= 0) {
				contentDisposition = "attachment; filename="
						+ URLEncoder.encode(showName, "UTF-8").replace("+",
								"%20");
			} else if (userAgent.indexOf("safari") >= 0) {
				contentDisposition = "attachment; filename="
						+ new String(showName.getBytes("UTF-8"), "ISO8859-1");

			} else if (userAgent.indexOf("opera") >= 0) {
				contentDisposition = "attachment; filename*=UTF-8''"
						+ URLEncoder.encode(showName, "UTF-8").replace("+",
								"%20");

			} else {
				contentDisposition = "attachment; filename*=UTF-8''"
						+ URLEncoder.encode(showName, "UTF-8").replace("+",
								"%20");
			}
		}

		response.setHeader("Content-Disposition", contentDisposition);
	}
}
