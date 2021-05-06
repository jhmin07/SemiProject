package order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderDAO implements InterOrderDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
    //생성자
    public OrderDAO() {
 	   
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
    
    // 주문 코드 알아오는 함수 
    @Override
	public String getOrdercode() throws SQLException {
    	String ordercode = "";

		try {
			conn = ds.getConnection();

			String sql = " select seq_tbl_order_ordercode.nextval AS ordercode " + 
						" from dual ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			rs.next();
			ordercode = rs.getString(1);

		} finally {
			close();
		}

		return ordercode;
	}
    
    
	// 주문 내역 insert 하는 함수 
	@Override
	public int orderlistInsert(Map<String, String> paraMap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into tbl_order(ordercode, fk_userid, totalprice, totalpoint)\n"+
						"values (?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("ordercode"));
			pstmt.setString(2, paraMap.get("fk_userid"));
			pstmt.setString(3, paraMap.get("totalPrice"));
			pstmt.setString(4, paraMap.get("totalPoint"));
			
			conn.setAutoCommit(false);
			
			n = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			conn.rollback();
		} finally {
			close();
		}
		
		return n;
	}

	// 배송지 정보 insert 하기
	@Override
	public int deliverInfoInsert(DeliverInfoVO delivo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into tbl_delivery(fk_ordercode, recMobile, recPostcode, recAddress, recDetailAddress, recExtraAddress, dvMessage)" +
						" values (?, ?, ?, ?, ?, ? ,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, delivo.getFk_orderCode());
			pstmt.setString(2, delivo.getRecMobile());
			pstmt.setString(3, delivo.getRecPostcode());
			pstmt.setString(4, delivo.getRecAddress());
			pstmt.setString(5, delivo.getRecDetailaddress());
			pstmt.setString(6, delivo.getRecExtraaddress());
			pstmt.setString(7, delivo.getDvMessage());
			
			n = pstmt.executeUpdate();
			
			conn.commit();
		} catch (SQLException e){
			e.printStackTrace();
			conn.rollback();
		} finally {
			close();
		}
		return n;
	}

	

}
