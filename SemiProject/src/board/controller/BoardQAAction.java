package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import QA.model.InterQADAO;
import QA.model.QADAO;
import QA.model.QAVO;
import common.controller.AbstractController;
import detailMenu.controller.MyUtil;

public class BoardQAAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		// == 관리자(admin)로 로그인 했s을 때만 조회가 가능하도록 한다. == //
/*				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				if( loginuser!=null && "admin".equals(loginuser.getUserid()) ) {*/
					InterQADAO qdao = new QADAO();
					String currentShowPageNo = request.getParameter("currentShowPageNo");
					String sizePerPage = "10";
										
					if(currentShowPageNo == null ) {	// 몇페이지 볼지 선택안한경우
						currentShowPageNo = "1";
					}					
					
					
					try {
						Integer.parseInt(currentShowPageNo);	// 21억 이상을 입력하면 int 형태로 불가능
					} catch (NumberFormatException e) {	// 숫자 이상하게 치거나, 문자를 입력한 경우
						currentShowPageNo = "1";
					}
					
					///////////////////////////////////////////////////////////
					// == 검색어가 들어온 경우 ==
					String searchType = request.getParameter("searchType");
					String searchWord = request.getParameter("searchWord");
					
					System.out.println("~~확인용 searchType " + searchType);
					System.out.println("~~확인용 searchWord " + searchWord);
					///////////////////////////////////////////////////////////
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("currentShowPageNo", currentShowPageNo);
					paraMap.put("sizePerPage", sizePerPage);
					
					// 검색어가 들어온 경우
					paraMap.put("searchType", searchType);
					paraMap.put("searchWord", searchWord);
					
				
					//////////////////////////////////////////////////////////////////////////////
					// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에
					//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우를 1페이지로 가게끔 막아주는 것 시작.  
								
					// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
					int totalPage = qdao.selectTotalPage(paraMap);
					if(Integer.parseInt(currentShowPageNo) > totalPage ) {	// 없는 페이지로 장난치는 경우
						currentShowPageNo = "1";
						paraMap.put("currentShowPageNo", currentShowPageNo);	// 다시 map에 저장한다.
					}
					//////////////////////////////////////////////////////////////////////////////
					
					List<QAVO> qaList = qdao.selectPagingContent(paraMap);

					request.setAttribute("sizePerPage", sizePerPage);
					request.setAttribute("qaList", qaList);
					
			        request.setAttribute("searchType", searchType); 
			        request.setAttribute("searchWord", searchWord); 

					String pageBar = "";
					
					int blockSize = 10;
					// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
					
					int loop = 1;
					// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
					
					int pageNo = 0;
					// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
					
					// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
					pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;

			
					  
					  if(searchType == null) {
						  searchType = "";
					  }
					  if(searchWord == null) {
						  searchWord = "";
					  }
					  
					// **** [맨처음][이전] 만들기 **** //
					if( pageNo != 1 ) {
						pageBar +=  "&nbsp;<a href = 'boardQA.up?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;";	
						pageBar +=  "&nbsp;<a href = 'boardQA.up?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
						
					}
					
					while( !(loop > blockSize || pageNo > totalPage) ) {	// 10개 이상 페이지 번호가 찍히지 않게 || 없는 페이지 나오지 않게
						if( pageNo == Integer.parseInt(currentShowPageNo)) {
							 pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</span>&nbsp;";       
							 // 현재 들어와있는 페이지는 클릭해도 넘어가지 않게 해준다.
						}
						else {
							pageBar +=  "&nbsp;<a href = 'boardQA.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>" + pageNo + "</a>&nbsp;";
							
						}
						
						loop++;
						pageNo++;	

						
					} // end of while ------------------------------------------------------------------
					


					if( pageNo <= totalPage ) {
						pageBar +=  "&nbsp;<a href = 'boardQA.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
						pageBar +=  "&nbsp;<a href = 'boardQA.up?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'8>[마지막]</a>&nbsp;";
						
					}
					
					
					
					request.setAttribute("pageBar", pageBar);

					  ///////////////////////////////////////////////
					  // *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
						String currentURL = MyUtil.getCurrentURL(request);
						// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임
						System.out.println("확인용 currentURL="+currentURL);
						// setAttribute로 읽어가면서 &이전까지만 읽게 돼서
						// member/memberList.up?currentShowPageNo=9&sizePerPage=10&searchType=name&searchWord=혜
						// 에서 페이지 사이즈와 검색어에 대해서는 읽어오지 못하게 된다.
						currentURL=currentURL.replace("&", " ");
						request.setAttribute("goBackURL", currentURL);
						int menu = 2;
						request.setAttribute("menu", menu);	
						
					super.setRedirect(false);
			        super.setViewPage("/WEB-INF/board/QA.jsp");			
					
					/*
					 * } else { // 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
					 * 
					 * String message = "관리자만 접근이 가능합니다."; String loc = "javascript:history.back()";
					 * 
					 * request.setAttribute("message", message); request.setAttribute("loc", loc);
					 * 
					 * // super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp");
					 * 
					 * }
					 */

	}

}
