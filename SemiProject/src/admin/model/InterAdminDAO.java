package admin.model;

import java.sql.SQLException;
import java.util.Map;


public interface InterAdminDAO {
	
		// 관리자 로그인을 해주는 메소드
		AdminVO loginAdmin(Map<String, String> paraMap) throws SQLException;

		// 관리자등록을 해주는 메소드(tbl_admin 테이블에 insert)
		int adminRegister(AdminVO admin) throws SQLException;

		// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
		boolean idDuplicateCheck(String adId) throws SQLException;


		

}
