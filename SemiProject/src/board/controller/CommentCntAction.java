package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import QA.model.InterQACommentDAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import QA.model.QAVO;
import common.controller.AbstractController;

public class CommentCntAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String qaNo = request.getParameter("qaNo");
		
		InterQACommentDAO qcdao = new QACommentDAO();
		int n = qcdao.getCommentCnt(qaNo);

		JSONObject jsonObj = new JSONObject();	// 제이슨 객체 {}
		jsonObj.put("CommentCnt", n);
		if(n!=0) {
			
	            String json = jsonObj.toString(); // 문자열로 변환
	            request.setAttribute("json", json);
	      System.out.println("json=> "+ json);
	      super.setRedirect(false);
	      super.setViewPage("/WEB-INF/jsonview.jsp");


		}
		else {
			// DB에서 조회된 것이 없다라면
			// *** 만약에  select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. *** --   
		      //   System.out.println("~~~~ 확인용 json => " + json);
		      //   ~~~~ 확인용 json => []
            String json = jsonObj.toString(); // 문자열로 변환
            request.setAttribute("json", json);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}

}
