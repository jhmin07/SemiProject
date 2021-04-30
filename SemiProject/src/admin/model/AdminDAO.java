package admin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class AdminDAO implements InterAdminDAO {
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private AES256 aes;
    
    //생성자
    public AdminDAO() {
 	   
 	   try {
 	         Context initContext = new InitialContext();
 	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
 	         ds = (DataSource)envContext.lookup("jdbc/semioracle");
 	         
 	         aes = new AES256(SecretMyKey.KEY);
 	         // SecretKey.key는 우리가 만든 비밀의 키이다.
 	         
 	      } catch(NamingException e) {
 	         e.printStackTrace();
 	      } catch(UnsupportedEncodingException e) {
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

    // 관리자 로그인을 해주는 메소드
	@Override
	public AdminVO loginAdmin(Map<String, String> paraMap) throws SQLException {
		
		AdminVO loginadmin = null;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select adId, adName, adEmail, adMobile "+
						  " from tbl_admin "+
						  " where adId = ? and adPwd= ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, paraMap.get("adId"));
			 pstmt.setString(2, Sha256.encrypt(paraMap.get("adPwd")));
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 
				 loginadmin = new AdminVO();
				 
				 loginadmin.setAdId(rs.getString(1));
				 loginadmin.setAdName(rs.getString(2));
				 loginadmin.setAdEmail(aes.decrypt(rs.getString(3)));  
				 loginadmin.setAdMobile(aes.decrypt(rs.getString(4))); 

			 }
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
	        e.printStackTrace();
	    } finally {
			close();
		}
		
		return loginadmin;
	}

	// 관리자등록을 해주는 메소드(tbl_admin 테이블에 insert)
	@Override
	public int adminRegister(AdminVO admin) throws SQLException {
		int n = 0;
		
		try {			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_admin(adId, adPwd, adName, adEmail, adMobile) "
					   + " values(?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, admin.getAdId());
			pstmt.setString(2, Sha256.encrypt(admin.getAdPwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
			pstmt.setString(3, admin.getAdName());
			pstmt.setString(4, aes.encrypt(admin.getAdEmail())); // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, aes.encrypt(admin.getAdMobile())); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.

			
			n = pstmt.executeUpdate();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}

	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String adId) throws SQLException {
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select adId "
					   + " from tbl_admin "
					   + " where adId = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adId);
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); 
			
		} finally {
			close();
		}
		
		return isExists;
	}


	


}
