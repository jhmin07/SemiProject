package notice.model;

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


public class NoticeDAO implements InterNoticeDAO {
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private AES256 aes;
    
    //생성자
    public NoticeDAO() {
 	   
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
						 " from tbl_noticeBoard ";
			
			//// == 검색어가 있는 경우 시작 == ////
			String searchWord = paraMap.get("searchWord");
			String colname = paraMap.get("searchType");
			if(colname!= null && colname.equals("name")) {
				colname="fk_adId";
			}
			if(colname!= null && colname.equals("title")) {
				colname="ctTitle";
			}
			if(colname!= null && colname.equals("contents")) {
				colname="ctContent";
			}
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
		if(colname!= null && colname.equals("name")) {
			colname="fk_adId";
		}
		if(colname!= null && colname.equals("title")) {
			colname="ctTitle";
		}
		if(colname!= null && colname.equals("contents")) {
			colname="ctContent";
		}
				
		if( searchWord != null && !searchWord.trim().isEmpty() ) {
			// 검색어를 공백이 아닌 것을 입력해준 경우
			sql += " where "+ colname +" like '%'||?||'%' ";	// 테이블명이나 컬럼명에는 위치홀더(?) 쓰면 안된다...(여기서의 name같은거..)
		}
		//// == 검색어가 있는 경우 끝 == ////
			
			
			sql += " order by ctNo desc " + 
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

	@Override
	public NoticeVO contentOneDetail(String ctNo) throws SQLException {
		NoticeVO nvo = null;
		try {
			conn = ds.getConnection();
			String sql = " select ctNo, ctTitle,ctContent, fk_adId, ctRegisterday, ctViewcount " + 
						 " from tbl_noticeBoard "+
						 " where ctNo = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ctNo);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				nvo = new NoticeVO();
				nvo.setCtNo(rs.getInt(1));
				nvo.setCtTitle(rs.getString(2));
				nvo.setCtContent(rs.getString(3));
				nvo.setFk_adId(rs.getString(4));
				nvo.setCtRegisterday(rs.getString(5));
				nvo.setCtViewcount(rs.getInt(6));
	            	            
			}
		} finally {
			close();
		}
		
		return nvo;
	}
	
	@Override
	public int getCtno(NoticeVO nvo) throws SQLException {
		int ctno = 0;
	      try {
	    	  conn = ds.getConnection();
	 		  String sql = " select seq_tbl_noticeBoard_ctNo.nextval " + 
	 					" from dual ";
	       

		       pstmt = conn.prepareStatement(sql);
		       
		       rs = pstmt.executeQuery();
		       
		       
		       
		       if(rs.next()) {
		      	 ctno = Integer.parseInt(rs.getString(1));
		       }
		} finally {
	         close();
	      }
	         
	      return ctno;
	}
	// tbl_product 테이블에 공지사항 insert 하기
	@Override
	public int noticeInsert(NoticeVO nvo, int ctno) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	        
	         
	         String sql = " insert into tbl_noticeBoard(ctNo, ctTitle,ctContent, fk_adId, ctRegisterday, ctViewcount) " +  
	                    " values(?,?,?,?,sysdate,0)";
	     
	         pstmt = conn.prepareStatement(sql);

	         pstmt.setInt(1, ctno);
	         pstmt.setString(2, nvo.getCtContent());
	         pstmt.setString(3, nvo.getCtContent());
	         pstmt.setString(4, nvo.getFk_adId());    
	        
	            
	         result = pstmt.executeUpdate();
	         
	         
	     
	         
	      } finally {
		         close();
		  }
	      
	      return result;
	}

	@Override
	public int contentHitUp(int hit, int ctNo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	         String sql = " update tbl_noticeBoard set ctViewcount = ? " + 
	         			  "			    where ctNo = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, hit+1);
	         pstmt.setInt(2, ctNo);
	        
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
		
	}

	@Override
	public int delNotice(String ctNo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	         String sql = " delete from tbl_noticeBoard " + 
	         			  "	where ctNo = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, ctNo);
	        
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}

	@Override
	public int noticeUpdate(NoticeVO nvo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	         String sql = " update tbl_noticeBoard set ctTitle = ? , ctContent = ? " + 
	         			  "	where ctNo = ? ";

	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, nvo.getCtTitle());
	         pstmt.setString(2, nvo.getCtContent());
	         pstmt.setInt(3, nvo.getCtNo());
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}


	
}	

