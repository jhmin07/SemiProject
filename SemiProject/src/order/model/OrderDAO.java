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

import myshop.model.ProductVO;

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
	public List<OrderDetailVO> selectOrderList(Map<String, String> paraMap, String userid) throws SQLException {
		List<OrderDetailVO> orderList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select A.ordercode, A.fk_userid, A.totalprice, A.totalpoint, to_char(A.orderdate, 'yyyy-mm-dd') AS orderdate, B.fk_pnum, B.odAmount, B.deliveryCon, c.pname, c.pimage1, c.fk_decode "
					   + " from tbl_order A join tbl_order_details B "
					   + " on A.orderCode = B.fk_orderCode "
					   + " join tbl_product C "
					   + " on B.fk_pnum = C.pnum "
					   + " where fk_userid = ? "
					   + " and orderdate between ? and ? "
					   + " order by orderdate desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, paraMap.get("fromDate"));
			pstmt.setString(3, paraMap.get("toDate"));
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					orderList = new ArrayList<>();
				}
				
				OrderVO ovo = new OrderVO();				
				ovo.setOrderCode(rs.getString(1));
				ovo.setFk_userid(rs.getString(2));				
				ovo.setTotalPrice(rs.getInt(3));
				ovo.setTotalPoint(rs.getInt(4));
				ovo.setOrderDate(rs.getString(5));
				
				ProductVO pvo = new ProductVO();
				pvo.setPname(rs.getString(9));
				pvo.setPimage1(rs.getString(10));	
				pvo.setFk_decode(rs.getString(11));
				
				OrderDetailVO odvo = new OrderDetailVO();
				odvo.setFk_pnum(rs.getInt(6));
				odvo.setOdAmount(rs.getInt(7));
				odvo.setDeliveryCon(rs.getString(8));
				odvo.setOrd(ovo);
				odvo.setProd(pvo);
								
				orderList.add(odvo);				
			}
			
		} finally {
			close();
		}
		
		return orderList;
	}

}
