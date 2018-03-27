package util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletWebRequest;

public class HttpUtil {

	public static void printHttpServletResponse(Object obj) {
        PrintWriter prw = null;
        try {
        	HttpServletResponse response = ((ServletWebRequest)RequestContextHolder.getRequestAttributes()).getResponse(); 
        	response.setContentType("text/html;charset=utf-8");
        	
            prw = response.getWriter();
            prw.print(obj);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            prw.close();
        }
    }
	
}
