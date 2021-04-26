package detailMenu.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyUtil {

	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		
		if(queryString != null) {	// 즉 GET 방식인 경우
			currentURL+="?"+queryString;
			
		}
		
		String ctxPath = request.getContextPath();
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		
		currentURL = currentURL.substring(beginIndex+1);
	
		
		
		return currentURL;
		
	}

}
