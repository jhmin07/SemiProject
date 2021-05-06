package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import QA.model.InterQACommentDAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import common.controller.AbstractController;

public class CommentViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String qaNo = request.getParameter("qaNo");
		
		InterQACommentDAO qcdao = new QACommentDAO();
		List<QACommentVO> QAcommentList = qcdao.qaView(qaNo);
		
		JSONArray jsonArr = new JSONArray();	// 제이슨 배열!! []
		if(QAcommentList.size() > 0) {	// prodList에 저장된 값이 있냐는 뜻

			for(QACommentVO qcvo : QAcommentList) {
				JSONObject jsonObj = new JSONObject();	// 제이슨 객체 {}
				jsonObj.put("addno", qcvo.getAddno());
				jsonObj.put("addSubject", qcvo.getAddSubject());
				jsonObj.put("fk_qaNo", qcvo.getFk_qaNo());
				jsonObj.put("writer", qcvo.getWriter());
				jsonObj.put("addRegisterday", qcvo.getAddRegisterday());
				
	            jsonArr.put(jsonObj);
	            
	            
	            String json = jsonArr.toString(); // 문자열로 변환
	      request.setAttribute("json", json);
	      
	      super.setRedirect(false);
	      super.setViewPage("/WEB-INF/jsonview.jsp");
	      
			} // end of for------------------------------
		}
		else {
			// DB에서 조회된 것이 없다라면
			// *** 만약에  select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. *** --   
		      //   System.out.println("~~~~ 확인용 json => " + json);
		      //   ~~~~ 확인용 json => []
            String json = jsonArr.toString(); // 문자열로 변환
            request.setAttribute("json", json);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}

}
