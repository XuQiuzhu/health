package base.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import base.model.PaginationContext;


public class PageInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		PaginationContext.setPageNum(getPageNum(request));
        PaginationContext.setPageSize(getPageSize(request));
        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		PaginationContext.removePageNum();
        PaginationContext.removePageSize();
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

	/**
     * 获取PageNum
     */
    protected int getPageNum(HttpServletRequest request) {
        int pageNum = 1;//默认为第一页
        try {
        	if(request.getParameterMap().containsKey("pageNum")) {
        		String parameter = request.getParameter("pageNum");
        		if(StringUtils.isNumeric(parameter)) {
        			pageNum = Integer.parseInt(parameter);
        		}
        	}
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return pageNum;
    }

    /**
     * 获取PageSize
     */
    protected int getPageSize(HttpServletRequest request) {
        int pageSize = 10;//默认每页10条记录
        try {
        	if(request.getParameterMap().containsKey("pageSize")) {
        		String parameter = request.getParameter("pageSize");
        		if (StringUtils.isNumeric(parameter)) {
                    pageSize = Integer.parseInt(parameter);
                }
        	}
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return pageSize;
    }
}
