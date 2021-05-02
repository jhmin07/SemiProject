package admin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.*;
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

	// Email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	
	// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;

		try {
			conn = ds.getConnection();

			String sql = " select ceil(count(*)/10) " +
						 " from tbl_member ";

			// 검색어가 있는 경우
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");

			if("email".equals(colname)) {
				// 검색대상이 email 인 경우 암호화해서 검색해야 한다.
				searchWord = aes.encrypt(searchWord);
			}

			if(searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 제대로 입력한 경우(공백만 입력하거나 아무것도 입력하지 않고 엔터하지 않는 경우
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			}

			pstmt = conn.prepareStatement(sql);

			if(searchWord != null && !searchWord.trim().isEmpty()) { 
				// 검색어를 제대로 입력한 경우(공백만 입력하거나 아무것도 입력하지 않고 엔터하지 않는 경우
				pstmt.setString(1, searchWord);
			}

			rs = pstmt.executeQuery();

			rs.next();

			totalPage = rs.getInt(1);

		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}		

		return totalPage;
	}


	// 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기
	@Override
	public List<MemberVO> seletPagingMember(Map<String, String> paraMap) throws SQLException {
		List<MemberVO> memberList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = " select userid, name, email, gender " +
						 " from " +
						 " ( " +
						 "     select rownum AS rno, userid, name, email, gender " + 
						 "     from " + 
						 "     ( " + 
						 "         select userid, name, email, gender " + 
						 "         from tbl_member ";

			// == 검색어가 있는 경우
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");

			if("email".equals(colname)) {
				// 검색대상이 email 인 경우 암호화해서 검색해야 한다.
				searchWord = aes.encrypt(searchWord);
			}

			if(searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 제대로 입력한 경우(공백만 입력하거나 아무것도 입력하지 않고 엔터하지 않는 경우
				sql += " where "+colname+" like '%'|| ? ||'%' ";
			}

			sql += "         order by registerday desc " +
				   "     ) V " +
				   " ) T " +
				   " where rno between ? and ? ";

			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 10; // 한 페이지당 화면상에 보여줄 제품의 개수는 10개			

			pstmt = conn.prepareStatement(sql);

			if(searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 제대로 입력한 경우(공백만 입력하거나 아무것도 입력하지 않고 엔터하지 않는 경우
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			else {
				// 검색어가 없는 경우
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}

			rs = pstmt.executeQuery();

			while(rs.next()) {
				MemberVO mvo = new MemberVO();

				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getNString(2));
				mvo.setEmail(aes.decrypt(rs.getString(3)));
				mvo.setGender(rs.getString(4));

				memberList.add(mvo);
			}			

		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return memberList;
	}

	// userid 값을 입력받아 회원 1명에 대한 상세정보 알아오기(select)
	@Override
	public MemberVO memberOneDetail(String userid) throws SQLException {
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender," +
						 "        substr(birthday, 1, 4) AS birthyyyy, substr(birthday, 6, 2) AS birthmm, substr(birthday, 9) AS birthdd, " +
						 "        point, to_char(registerday, 'yyyy-mm-dd') AS registerday " +
						 " from tbl_member " +
						 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new MemberVO();
				
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화
				mvo.setMobile(aes.decrypt(rs.getString(4))); // 복호화
				mvo.setPostcode(rs.getString(5));
				mvo.setAddress(rs.getString(6));
				mvo.setDetailaddress(rs.getString(7));
				mvo.setExtraaddress(rs.getString(8));
				mvo.setGender(rs.getString(9));
				mvo.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12)); // 예. 19950416 와 같이 "-" 없이 나타난다.				
				mvo.setPoint(rs.getInt(13));
				mvo.setRegisterday(rs.getString(14));
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return mvo;
	}


}
