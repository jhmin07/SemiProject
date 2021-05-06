package order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
    
    
	// 주문 내역 insert 하는 함수 
	@Override
	public int orderlistInsert(Map<String, String> paraMap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into tbl_order(ordercode, fk_userid, totalprice, totalpoint)\n"+
						"values (seq_tbl_order_ordercode.nextval, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_userid"));
			pstmt.setString(2, paraMap.get("totalPrice"));
			pstmt.setString(3, paraMap.get("totalPoint"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	
	// 주문 내역 조회(select) 하는 함수
	@Override
	public List<OrderVO> selectOrderList(Map<String, String> paraMap, String userid) throws SQLException {
		List<OrderVO> orderList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select totalprice, totalpoint, to_char(orderdate, 'yyyy-mm-dd') AS orderdate "
					   + " from tbl_order "
					   + " where fk_userid = ?"
					   + " and orderdate between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, paraMap.get("fromDate"));
			pstmt.setString(3, paraMap.get("toDate"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderVO ovo = new OrderVO();
				
				ovo.setTotalPrice(rs.getInt(1));
				ovo.setTotalPoint(rs.getInt(2));
				ovo.setOrderDate(rs.getString(3));
				
				orderList.add(ovo);
			}
			
		} finally {
			close();
		}
		
		return orderList;
	}

}
