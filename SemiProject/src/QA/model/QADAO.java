package QA.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import member.model.MemberVO;
import notice.model.NoticeVO;
import util.security.AES256;
import util.security.Sha256;


public class QADAO implements InterQADAO {
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private AES256 aes;
    
    //생성자
    public QADAO() {
 	   
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

    
    
	
	
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		try {
			
			conn = ds.getConnection();
			String sql = " select ceil(count(*)/?) " + 
						 " from tbl_qaBoard ";
			
			//// == 검색어가 있는 경우 시작 == ////
			String searchWord = paraMap.get("searchWord");
			String colname = paraMap.get("searchType");
			if(colname!= null && colname.equals("name")) {
				colname="fk_userid";
			}
			if(colname!= null && colname.equals("title")) {
				colname="qaTitle";
			}
			if(colname!= null && colname.equals("contents")) {
				colname="qaContent";
			}
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// 검색어를 공백이 아닌 것을 입력해준 경우
				sql += " where "+ colname +" like '%'||?||'%' ";	// 테이블명이나 컬럼명에는 위치홀더(?) 쓰면 안된다...(여기서의 name같은거..)
			}
			//// == 검색어가 있는 경우 끝 == ////
			
			pstmt = conn.prepareStatement(sql);
			System.out.println("paraMap.get(\"sizePerPage\")=> "+paraMap.get("sizePerPage"));
			pstmt.setString(1, paraMap.get("sizePerPage"));
			System.out.println("Asgddags");
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(2, searchWord);
				System.out.println("서치워드"+searchWord);
			}
			rs = pstmt.executeQuery();
			
			rs.next();
			System.out.println("rs.getInt(1);=> "+rs.getInt(1));
			totalPage = rs.getInt(1);
			

			
		
		}  finally {
			close();
		}
				
		
		return totalPage;
	}

	@Override
	public List<QAVO> selectPagingContent(Map<String, String> paraMap) throws SQLException {

		List<QAVO> qaList = new ArrayList<>();
		try {
			
			conn = ds.getConnection();
			String sql = " select qaNo, qaTitle, qaContent, qaPwd, fk_userid, qaRegisterday, qaViewcount " + 
						 " from " + 
						 " ( " + 
				 	 	 " 		select rownum AS rno, qaNo, qaTitle, qaContent, qaPwd, fk_userid, qaRegisterday, qaViewcount " + 
						 " 		from " + 
						 " 		( " + 
						 "			select qaNo, qaTitle, qaContent, qaPwd, fk_userid, qaRegisterday, qaViewcount " + 
						 "			from tbl_qaBoard ";
			
			
		//// == 검색어가 있는 경우 시작 == ////
		String searchWord = paraMap.get("searchWord");
		String colname = paraMap.get("searchType");
		if(colname!= null && colname.equals("name")) {
			colname="fk_userid";
		}
		if(colname!= null && colname.equals("title")) {
			colname="qaTitle";
		}
		if(colname!= null && colname.equals("contents")) {
			colname="qaContent";
		}
				
		if( searchWord != null && !searchWord.trim().isEmpty() ) {
			// 검색어를 공백이 아닌 것을 입력해준 경우
			sql += " where "+ colname +" like '%'||?||'%' ";	// 테이블명이나 컬럼명에는 위치홀더(?) 쓰면 안된다...(여기서의 name같은거..)
		}
		//// == 검색어가 있는 경우 끝 == ////
			
			
			sql += " order by qaNo desc " + 
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
				System.out.println("11111");
				QAVO qvo = new QAVO();
				 qvo.setQaNo(rs.getInt(1));
				 qvo.setQaTitle(rs.getString(2));
				 qvo.setQaContent(rs.getString(3));
				 qvo.setQaPwd(rs.getString(4));
				 qvo.setFk_userid(rs.getString(5));
				 qvo.setQaRegisterday(rs.getString(6));
				 qvo.setQaViewcount(rs.getInt(7));
				 qaList.add(qvo);
			}
			
		} finally {
			close();
		}
		
		
		return qaList;
	}

	@Override
	public QAVO qaOneDetail(String qaNo) throws SQLException {
		QAVO qvo = null; 
		try { 
			conn = ds.getConnection(); 
			String sql = " select qaNo, qaTitle,qaContent,qaPwd, fk_userid, qaRegisterday, qaViewcount " +
						 " from tbl_qaBoard "+ 
						 " where qaNo = ? "; 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, qaNo);
				 
				  rs = pstmt.executeQuery();
				  
				  if(rs.next()) {
				  
				  qvo = new QAVO(); 
				  qvo.setQaNo(rs.getInt(1));
				  qvo.setQaTitle(rs.getString(2)); 
				  qvo.setQaContent(rs.getString(3));
				  qvo.setQaPwd(rs.getString(4)); 
				  qvo.setFk_userid(rs.getString(5));
				  qvo.setQaRegisterday(rs.getString(6));
				  qvo.setQaViewcount(rs.getInt(7));
				  
				  } 
			} finally { 
				
				close(); 
			}
				  
				  return qvo; 
	}

	
}	

