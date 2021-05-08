package order.model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import myshop.model.ProductVO;


public class CartDAO implements InterCartDAO{
	
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    //생성자
    public CartDAO() {
 	   
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

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
	// 로그인한 사용자가 가지고 있는 장바구니 리스트를 가져오는 메소드
    @Override
	public List<CartVO> getCartList(String userid) throws SQLException {
    	
    	List<CartVO> cartList = null;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select A.cartNo, A.fk_userid, A.fk_pnum, "+
	                    "        B.pname, B.pimage1, B.price, B.saleprice, B.point, A.odAmount, B.fk_decode "+
	                    " from tbl_cart A join tbl_product B "+
	                    " on A.fk_pnum = B.pnum "+
	                    " where A.fk_userid = ? "+
	                    " order by A.cartno desc ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         int cnt = 0;
	         while(rs.next()) {
	            cnt++;
	            
	            if(cnt==1) {
	               cartList = new ArrayList<>();
	            }
	            
	            int cartno = rs.getInt(1);
	            String fk_userid = rs.getString(2);
	            int fk_pnum = rs.getInt(3);
	            String pname = rs.getString(4);
	            String pimage1 = rs.getString(5);
	            int price = rs.getInt(6);
	            int saleprice = rs.getInt(7);
	            int point = rs.getInt(8);
	            int odAmount = rs.getInt(9);  // 주문량 
	            String fk_decode = rs.getString(10);
	                        
	            ProductVO prodvo = new ProductVO();
	            prodvo.setPnum(fk_pnum);
	            prodvo.setPname(pname);
	            prodvo.setPimage1(pimage1);
	            prodvo.setPrice(price);
	            prodvo.setSaleprice(saleprice);
	            prodvo.setPoint(point);
	            prodvo.setFk_decode(fk_decode);
	            
	            // **** !!!! 중요함 !!!! **** //
	            prodvo.setTotalPriceTotalPoint(odAmount);
	            // **** !!!! 중요함 !!!! **** //
	            
	            CartVO cvo = new CartVO();
	            cvo.setCartNo(cartno);
	            cvo.setFk_userid(fk_userid);
	            cvo.setFk_pnum(fk_pnum);
	            cvo.setOdAmount(odAmount);
	            cvo.setProd(prodvo);
	            
	            cartList.add(cvo);
	         }// end of while---------------------------------
	                  
	      } finally {
	         close();
	      }
	      
	      return cartList;
	}

    // 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 알아오기 
	@Override
	public HashMap<String, String> selectCartSumPricePoint(String userid) throws SQLException {
		HashMap<String, String> sumMap = new HashMap<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select nvl(sum(odAmount * saleprice), 0) AS SUMTOTALPRICE "+
	                    "      , nvl(sum(odAmount * point), 0) AS SUMTOTALPOINT "+
	                    " from tbl_cart A join tbl_product B "+
	                    " on A.fk_pnum = B.pnum "+
	                    " where A.fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         sumMap.put("SUMTOTALPRICE", rs.getString("SUMTOTALPRICE"));
	         sumMap.put("SUMTOTALPOINT", rs.getString("SUMTOTALPOINT"));
	         
	         System.out.println(rs.getString("SUMTOTALPRICE"));
	                  
	      } finally {
	         close();
	      }
	      
	      return sumMap;
	}

	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기 
	@Override
	public int delCart(String cartno) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "
	                    + " where cartNo = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	         
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	// 장바구니 테이블에서 특정제품을 장바구니에서 전체 비우기
	public int delAllCart(String userid) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "
	                    + " where fk_userid = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         n = pstmt.executeUpdate();
	         
	         
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	// 장바구니 테이블에서 특정제품을 장바구니에서 수량을 변경하기  
	@Override
	public int updateCart(String cartno, String oqty) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_cart set odAmount = ? "
	                  + " where cartNo = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, oqty);
	         pstmt.setString(2, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n; 
	}

	//장바구니에 담긴 물건갯수 알아오기 select
	@Override
	public int getCartCount(String userid) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select count(*) from tbl_cart "
	                    + " where fk_userid = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	        	 n = rs.getInt(1);
	         }
	         
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

}
