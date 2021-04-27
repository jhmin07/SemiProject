package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("GET".equalsIgnoreCase(method)) {
			// 회원가입창을 띄운다
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		else {
			// 일반적인 회원으로 회원가입한 경우			
			String userid = request.getParameter("userid");			
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailaddress = request.getParameter("detailAddress"); 
			String extraaddress = request.getParameter("extraAddress"); 
			String gender = request.getParameter("gender"); 
			String birthyyyy = request.getParameter("birthyyyy"); 
			String birthmm = request.getParameter("birthmm"); 
			String birthdd = request.getParameter("birthdd");
			
			String mobile = hp1 + hp2 + hp3;
			String birthday = birthyyyy + "-" + birthmm + "-" + birthdd;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday);
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.memberRegister(member);
								
				if(n == 1) {
					// 회원가입 성공 후 자동 로그인 하기
					
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/member/registerAfterAutoLogin.jsp");			
				}
				else {
					String message = "회원가입 실패";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");				
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}		
			
		}
		
	}

}
