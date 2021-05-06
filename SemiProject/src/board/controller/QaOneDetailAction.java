package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import QA.model.InterQADAO;
import QA.model.QADAO;
import QA.model.QAVO;
import common.controller.AbstractController;
public class QaOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

					String qaNo = request.getParameter("qaNo");
					InterQADAO qdao = new QADAO();
					QAVO qvo = qdao.qaOneDetail(qaNo);
					

					int n = qdao.qaHitUp(qvo.getQaViewcount(), qvo.getQaNo());
					  request.setAttribute("qvo", qvo);
					/////////////////////////////////////////////////
					// *** 현재페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기
					String goBackURL = request.getParameter("goBackURL");
					
					
					request.setAttribute("goBackURL", goBackURL);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/board/QANoticeDetail.jsp");
				

	}

}
