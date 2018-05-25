package base.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import base.constant.GlobalConstant;

public class SessionTimeoutInterceptor implements HandlerInterceptor {  
	  
    private List<String> allowUrls;  
      
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
            String requestUrl = request.getRequestURI();    
              
            /** 
             * 对所有的请求，*.f进行拦截 
             */  
            if(requestUrl.indexOf(".do")!=-1){  
                /** 
                 * 登录页login.do不进行拦截 
                 */  
                for(String url : allowUrls) {    
                    if(requestUrl.contains(url)) {    
                        return true;    
                    }    
                }   
                  
                Object obj = request.getSession().getAttribute(GlobalConstant.LOGIN_USER);  
                if(obj != null) {    
                    return true;    
                }else {    
                    response.setHeader("sessionstatus", "timeout");  
                    response.sendRedirect(request.getContextPath() + "/index.jsp");  
                    return false;  
                }    
            }else{  
                return true;  
            }  
  
    }  
  
    @Override  
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {  
    		
    }  
  
    @Override  
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)throws Exception {  
  
    }  
  
    public List<String> getAllowUrls() {  
        return allowUrls;  
    }  
  
    public void setAllowUrls(List<String> allowUrls) {  
        this.allowUrls = allowUrls;  
    }  
}  
