package QA.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class QACommentDAO implements InterQACommentDAO {

	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
	
	 //생성자
    public QACommentDAO() {
 	   
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
	public int QACommentInsert(QACommentVO qcvo) throws SQLException {
		
		int result = 0;
	      try {
	         conn = ds.getConnection();

	         String sql = " insert into tbl_coment(addno, addSubject, fk_qaNo, writer, addRegisterday) " +  
	                    " values(seq_tbl_coment_no.nextval, ? , ? , ? ,sysdate) ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, qcvo.getAddSubject());
	         pstmt.setInt(2, qcvo.getFk_qaNo());
	         pstmt.setString(3, qcvo.getWriter());  
	        
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}

	@Override
	public List<QACommentVO> qaView(String qaNo) throws SQLException {
		List<QACommentVO> QACommentList = new ArrayList<>();
	      try {
	         conn = ds.getConnection();

	         String sql = " select addno, addSubject, fk_qaNo, writer, addRegisterday " +  
	                      " from tbl_coment " +
	                      " where fk_qaNo = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, qaNo);  
	        
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	     		QACommentVO qcvo = new QACommentVO();
	        	 qcvo.setAddno(rs.getInt(1));
	        	 qcvo.setAddSubject(rs.getString(2));
	        	 qcvo.setFk_qaNo(rs.getInt(3));
	        	 qcvo.setWriter(rs.getString(4));
	        	 qcvo.setAddRegisterday(rs.getString(5));
	        	 
	        	 QACommentList.add(qcvo);
	         }
	         
	      } catch (SQLException e) {
			e.printStackTrace();
		 } finally {
	         close();
	      }
	      
	      return QACommentList;
		
	}

	@Override
	public int getCommentCnt(String qaNo) throws SQLException {
		int n =0;
	      try {
	         conn = ds.getConnection();

	         String sql = " select count(*) " +  
	                      " from tbl_coment " +
	                      " where fk_qaNo = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, qaNo);  
	        
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
		         n = rs.getInt("count(*)");
		        }
	      } catch (SQLException e) {
			e.printStackTrace();
		 } finally {
	         close();
	      }
	      
	      return n;
	}

	@Override
	public int delComment(String addno) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	         String sql = " delete from tbl_coment " + 
	         			  "	where addno = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, addno);
	        
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}

	@Override
	public int commentUpdate(QACommentVO qacvo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();

	         String sql = " update tbl_coment set addSubject = ? , addRegisterday = sysdate " + 
	         			  "	where addno = ? ";

	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, qacvo.getAddSubject());
	         pstmt.setInt(2, qacvo.getAddno());
	        
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;	}

	@Override
	public int getQAno(String addno) throws SQLException {
		int n =0;
	      try {
	         conn = ds.getConnection();

	         String sql = " select fk_qano " +  
	                      " from tbl_coment " +
	                      " where addno = ? ";
	     
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, addno);  
	        
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
		         n = rs.getInt(1);
		        }
	      } catch (SQLException e) {
			e.printStackTrace();
		 } finally {
	         close();
	      }
	      
	      return n;
	}

}
