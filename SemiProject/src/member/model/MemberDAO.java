package member.model;

import java.sql.*;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;



public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
  
    
    //생성자
    public MemberDAO() {
 	   
 	   try {
 	         Context initContext = new InitialContext();
 	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
 	         ds = (DataSource)envContext.lookup("jdbc/semioracle");
 	         
 	      } catch(NamingException e) {
 	         e.printStackTrace();
 	      }
    }
    
    // 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
       try {
          if(rs != null)    {rs.close();    rs=null;}
          if(pstmt != null) {pstmt.close(); pstmt=null;}
          if(conn != null)  {conn.close();  conn=null;}
       } catch(SQLException e) {
          e.printStackTrace();
       }
    }

    
    // 로그인 메소드
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) {
	
		MemberVO member = null;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, "+
							  "       	 substr(BIRTHDAY,1,4) as birthyyyy, substr(BIRTHDAY,6,2) as birthmm, substr(BIRTHDAY,9) as birthdd, "+
							  "       	 point, to_char(registerday, 'yyyy-mm-dd') as registerday "+
							  " from tbl_member "+
							  " where status=1 and userid = ? and pwd= ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, paraMap.get("userid"));
			 pstmt.setString(2, paraMap.get("pwd"));
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 
				 member = new MemberVO();
				 
				 member.setUserid(rs.getString(1));
				 member.setName(rs.getString(2));
				 member.setEmail(rs.getString(3));  
				 member.setMobile(rs.getString(4)); 
				 member.setPostcode(rs.getString(5));
			     member.setAddress(rs.getString(6));
				 member.setDetailaddress(rs.getString(7));
				 member.setExtraaddress(rs.getString(8));
				 member.setGender(rs.getString(9));
				 member.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12) );
				 member.setPoint(rs.getInt(13));
				 member.setRegisterday(rs.getString(14));
					 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, paraMap.get("userid"));
				 pstmt.setString(2, paraMap.get("pwd"));
				 
				 pstmt.executeUpdate();

			 }
			 
		} catch(Exception e) {
	          e.printStackTrace();
	    } finally {
			close();
		}
		
		return member;
	}
	
}	

