package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import notice.model.NoticeVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;


public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private AES256 aes;
    
    //생성자
    public MemberDAO() {
 	   
 	   try {
 	         Context initContext = new InitialContext();
 	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
 	         ds = (DataSource)envContext.lookup("jdbc/semioracle");
 	         
 	         aes = new AES256(SecretMyKey.KEY);
 	         // SecretMyKey.KEY 은 우리가 만든 비밀키 이다.
 	      } catch(NamingException e) {
 	         e.printStackTrace();
 	      } catch (UnsupportedEncodingException e) {
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
			 pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")));
			 
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

	
	// 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
	@Override
	public int memberRegister(MemberVO member) throws SQLException {
		int n = 0;
		
		try {			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) "
					   + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail())); // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, aes.encrypt(member.getMobile())); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(6, member.getPostcode());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getDetailaddress());
			pstmt.setString(9, member.getExtraaddress());
			pstmt.setString(10, member.getGender());
			pstmt.setString(11, member.getBirthday());
			
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
	public boolean idDuplicateCheck(String userid) throws SQLException {
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid "
					   + " from tbl_member "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
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
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select email "
					   + " from tbl_member "
					   + " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email)); // DB에 있는 email 이 암호화되어 있으므로 email 을 암호화해야 한다.
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExists;
	}
	

	// 회원의 개인 정보 변경하기
	@Override
	public int updateMember(MemberVO member) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set name = ? "
					   + "                     , pwd = ? "
					   + "                     , email = ? " 
					   + "                     , mobile = ? "
					   + "                     , postcode = ? "
					   + "                     , address = ? "
					   + "                     , detailaddress = ? "
					   + "                     , extraaddress = ? "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getName()); 
			pstmt.setString(2, Sha256.encrypt(member.getPwd()) );
			pstmt.setString(3, aes.encrypt(member.getEmail()) );
			pstmt.setString(4, aes.encrypt(member.getMobile()) );
			pstmt.setString(5, member.getPostcode() );
			pstmt.setString(6, member.getAddress() );
			pstmt.setString(7, member.getDetailaddress() );
			pstmt.setString(8, member.getExtraaddress() );
			pstmt.setString(9, member.getUserid() );
			
			n = pstmt.executeUpdate();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}
	
	
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		try {
			
			conn = ds.getConnection();
			String sql = " select ceil(count(*)/?) " + 
						 " from tbl_noticeBoard ";
			
			//// == 검색어가 있는 경우 시작 == ////
			String searchWord = paraMap.get("searchWord");
			String colname = paraMap.get("searchType");
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// 검색어를 공백이 아닌 것을 입력해준 경우
				sql += " where "+ colname +" like '%'||?||'%' ";	// 테이블명이나 컬럼명에는 위치홀더(?) 쓰면 안된다...(여기서의 name같은거..)
			}
			//// == 검색어가 있는 경우 끝 == ////
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(2, searchWord);
			}
			rs = pstmt.executeQuery();
			
			rs.next();
			totalPage = rs.getInt(1);
			

			
		
		}  finally {
			close();
		}
				
		
		return totalPage;
	}

	@Override
	public List<NoticeVO> selectPagingContent(Map<String, String> paraMap) throws SQLException {

		List<NoticeVO> noticeList = new ArrayList<>();
		try {
			
			conn = ds.getConnection();
			String sql = " select ctNo, ctTitle, ctContent, fk_adId, ctRegisterday, ctViewcount " + 
						 " from " + 
						 " ( " + 
				 	 	 " 		select rownum AS rno, ctNo, ctTitle,ctContent, fk_adId, ctRegisterday, ctViewcount " + 
						 " 		from " + 
						 " 		( " + 
						 "			select ctNo, ctTitle,ctContent, fk_adId, ctRegisterday, ctViewcount " + 
						 "			from tbl_noticeBoard ";
			
			
		//// == 검색어가 있는 경우 시작 == ////
		String searchWord = paraMap.get("searchWord");
		String colname = paraMap.get("searchType");
		
				
		if( searchWord != null && !searchWord.trim().isEmpty() ) {
			// 검색어를 공백이 아닌 것을 입력해준 경우
			sql += " where "+ colname +" like '%'||?||'%' ";	// 테이블명이나 컬럼명에는 위치홀더(?) 쓰면 안된다...(여기서의 name같은거..)
		}
		//// == 검색어가 있는 경우 끝 == ////
			
			
			sql += " order by ctRegisterday desc " + 
				   " ) V " + 
				   " ) T " + 
				   " where rno between ? and ? ";
		
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo")); 
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage")); 
			pstmt = conn.prepareStatement(sql);
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NoticeVO nvo = new NoticeVO();
				 nvo.setCtNo(rs.getInt(1));
				 nvo.setCtTitle(rs.getString(2));
				 nvo.setCtContent(rs.getString(3)); // 복호화
				 nvo.setFk_adId(rs.getString(4));
				 nvo.setCtRegisterday(rs.getString(5));
				 nvo.setCtViewcount(rs.getInt(6));
				
				noticeList.add(nvo);
			}
			
		} finally {
			close();
		}
		
		
		return noticeList;
	}

	
	
	
}	

