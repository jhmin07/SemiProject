package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;
import member.model.*;
import my.util.Util;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	/*	
		// == 관리자 모드, 관리자로 로그인 했을 때만 조회가 가능하도록 한다. 
		HttpSession session = request.getSession();
		
		AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
		
		if(loginadmin != null) {
			// 관리자모드에서 로그인 했을 경우
	*/		
			InterAdminDAO adao = new AdminDAO();

			String currentShowPageNo = request.getParameter("currentShowPageNo"); // 관리자가 보고자하는 페이지번호			

			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}

			try {
				Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				// 숫자가 아닌 문자로 입력했을 때 1페이지가 보이도록 한다.
				currentShowPageNo = "1";
			}

			// 검색어가 들어온 경우			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);

			// 검색어가 들어온 경우
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);

			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
			int totalPage = adao.selectTotalPage(paraMap);

			if(Integer.parseInt(currentShowPageNo) > totalPage) {
				// 토탈페이지수보다 큰 값을 입력한 경우 1페이지로 보이도록 한다.
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}

			// 회원조회
			List<MemberVO> memberList = adao.seletPagingMember(paraMap);
			request.setAttribute("memberList", memberList);

			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);

			// 페이지바 만들기

			String pageBar = "";

			int blockSize = 10; // 블럭당 보여지는 페이지 번호의 개수

			int loop = 1; // 페이지번호의 개수

			int pageNo = 0; // 페이지바에서 보여지는 첫번째 번호

			pageNo = ((Integer.parseInt(currentShowPageNo) - 1 )/ blockSize) * blockSize + 1;

			if(searchType == null) {
				searchType = "";
			}
			if(searchWord == null) {
				searchWord = "";
			}


			// 맨처음, 이전 만들기
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo=1&searchType="+searchType+"&searchWord="+searchWord+"'>&lt;&lt;</a>&nbsp;"; 
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+(pageNo-1)+"&searchType="+searchType+"&searchWord="+searchWord+"'>&lt;</a>&nbsp;";
			}

			while(!(loop > blockSize || pageNo > totalPage)) {
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='font-weight: bold; font-size: 15pt; background-color: #d9f2d9;'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
				}
				loop++;

				pageNo++;
			}			

			// 다음, 마지막 만들기
			if(pageNo <= totalPage) {
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&searchType="+searchType+"&searchWord="+searchWord+"'>&gt;</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+totalPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>&gt;&gt;</a>&nbsp;";
			}			

			request.setAttribute("pageBar", pageBar);
			
			// 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기
			String currentURL = Util.getCurrentURL(request);
			
			currentURL = currentURL.replaceAll("&", " ");
			
			request.setAttribute("goBackURL", currentURL);			

		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");			
	/*		
		}
		else {
			// 관리자모드에서 로그인을 안한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	*/	
	}

}