package member.model;

import java.sql.SQLException;
import java.util.*;

import myshop.model.ReviewVO;
import notice.model.NoticeVO;

public interface InterMemberDAO {
	
	// 로그인을 해주는 메소드
	MemberVO selectOneMember(Map<String, String> paraMap);

	// 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
	int memberRegister(MemberVO member) throws SQLException;

	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	boolean idDuplicateCheck(String userid) throws SQLException;

	// Email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다)
	boolean emailDuplicateCheck(String email) throws SQLException;

	// 회원의 개인 정보 변경하기
	int updateMember(MemberVO member) throws SQLException;
	
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<NoticeVO> selectPagingContent(Map<String, String> paraMap) throws SQLException;

	// 아이디찾기
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 비밀번호찾기
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;

	// 암호 변경하기
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	//이름알아오기
	String getUserName(String userid)throws SQLException;

	// 내가쓴 리뷰들 불러오기
	List<ReviewVO> getMyReviewList(String userid)throws SQLException;

	// 상품을 샀는지 알아보는 메소드
	boolean isBuy(String userid, String fk_pnum)throws SQLException;
}

