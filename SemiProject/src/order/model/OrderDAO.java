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
    
    
	// == Transaction 처리 ==
	// 1. 주문내역 테이블에 주문내역 insert
	// 2. 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자,옵션} insert
    // 3. 상품 재고 감소(update)
	// 4. 장바구니 테이블에서 주문상품된 상품 delete
    // 5. 사용자 포인트 증감(update)
	@Override
	public int orderInsertProcess(Map<String, Object> paraMap) throws SQLException {
		int n1 = 0, n2 = 0, n3 = 0, n4 = 1, n5 = 0;
		int isSuccess = 0;

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			// 1. 주문내역 테이블에 주문내역 insert
			String sql = "insert into tbl_order(ordercode, fk_userid, totalprice, totalpoint)\n"
					+ "values (?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String) paraMap.get("ordercode"));
			pstmt.setString(2, (String) paraMap.get("fk_userid"));
			pstmt.setString(3, (String) paraMap.get("sumtotalPrice"));
			pstmt.setString(4, (String) paraMap.get("sumtotalPoint"));

			n1 = pstmt.executeUpdate();
//			System.out.println("~~~~~~ n1 : " + n1);
			
			// 2. 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자,옵션} insert
			if (n1 == 1) {
				String[] pnumArr = (String[])paraMap.get("pnumArr");
				String[] oqtyArr = (String[])paraMap.get("oqtyArr");
				String[] totalPriceArr = (String[])paraMap.get("totalPriceArr");
				String[] optionArr = (String[])paraMap.get("optionArr");
				
				for (int i=0; i<pnumArr.length; i++) {
					
					sql = "insert into tbl_order_details(odNo, fk_orderCode, fk_pnum, odAmount, odPrice, optionContents, deliveryCon, deliveryDone) "
							+ "values (seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), ?, '', '')";

//					System.out.println("optionArr"+i+" => ["+optionArr[i] +"]");
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, (String) paraMap.get("ordercode"));
					pstmt.setString(2, pnumArr[i]);
					pstmt.setString(3, oqtyArr[i]);
					pstmt.setString(4, totalPriceArr[i]);
					pstmt.setString(5, optionArr[i]);

					n2 += pstmt.executeUpdate();
				}
				
				if (n2 == pnumArr.length) {
					n2 = 1;
				}
			}
//			System.out.println("~~~~~~ n2 : " + n2);
			
		    // 3. 상품 재고 감소(update)
			if (n2 == 1) {
				String[] pnumArr = (String[]) paraMap.get("pnumArr");
				String[] oqtyArr = (String[]) paraMap.get("oqtyArr");

				for (int i = 0; i < pnumArr.length; i++) {
					sql = " update tbl_product set pqty = pqty - ? " + 
							" where pnum = ? ";

					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(oqtyArr[i]));
					pstmt.setString(2, pnumArr[i]);

					n3 += pstmt.executeUpdate();
				}
				
				if (n3 == pnumArr.length) {
					n3 = 1;
				}
			}
//			System.out.println("~~~~~~ n3 : " + n3);
			boolean cartFlag = !"".equals(paraMap.get("cartno_es")); // 카트번호 ""일 때
			
			// 4. 장바구니 테이블에서 주문상품된 상품 delete 
			if (cartFlag && n3 == 1) { // 장바구니에서 넘어와 결제가 진행되는 것이라면
				sql = "delete from tbl_cart "
					+ "where cartno in ("+ (String)paraMap.get("cartno_es") + ")";
				
				pstmt = conn.prepareStatement(sql);
				n4 = pstmt.executeUpdate();
			}
//			System.out.println("~~~~~~ n4 : " + n4);
			
			// 5. 사용자 포인트 증감(update)
			if (n4 > 0) {
				sql = " update tbl_member set point = point + ? - ?" 
						+ " where userid = ? ";

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt((String) paraMap.get("sumtotalPoint")));
				pstmt.setInt(2, Integer.parseInt((String) paraMap.get("usePoint")));
				pstmt.setString(3, (String) paraMap.get("fk_userid"));

				n5 = pstmt.executeUpdate();
			}
//			System.out.println("~~~~~~ n5 : " + n5);
			
			// 6. 모든처리가 성공되었을시 commit 하기(commit)
			if (n1 * n2 * n3 * n4 * n5 > 0) {
				conn.commit();
				conn.setAutoCommit(true); // 자동커밋으로 전환
//				System.out.println("n1*n2*n3*n4*n5 = " + (n1 * n2 * n3 * n4 * n5));

				isSuccess = 1;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			conn.setAutoCommit(true); // 자동커밋으로 전환
			
			isSuccess = 0;
		} finally {
			close();
		}

		return isSuccess;
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
    
	// 배송지 정보 insert 하기
	@Override
	public int deliverInfoInsert(DeliverInfoVO delivo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into tbl_delivery(fk_ordercode, recMobile, recPostcode, recAddress, recDetailAddress, recExtraAddress, dvMessage, recName)" +
						" values (?, ?, ?, ?, ?, ? ,?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, delivo.getFk_orderCode());
			pstmt.setString(2, delivo.getRecMobile());
			pstmt.setString(3, delivo.getRecPostcode());
			pstmt.setString(4, delivo.getRecAddress());
			pstmt.setString(5, delivo.getRecDetailaddress());
			pstmt.setString(6, delivo.getRecExtraaddress());
			pstmt.setString(7, delivo.getDvMessage());
			pstmt.setString(8, delivo.getRecName());
			
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
	
	// 주문하기 페이지에서 보여줄 상품의 정보 가져오기 (select)
	@Override
	public ProductVO getProdInfo(String userid, String cartno) throws SQLException {
		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();

			String sql = "select pimage1, pname, price, saleprice, point, fk_decode "+
						"from tbl_product "+
						"where pnum in ( "+
						"    select fk_pnum "+
						"    from tbl_cart "+
						"    where fk_userid = ? and cartno = ? "+
						")";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, cartno);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pvo = new ProductVO();
				
				pvo.setPimage1(rs.getString(1));
				pvo.setPname(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
				pvo.setSaleprice(rs.getInt(4));
				pvo.setPoint(rs.getInt(5));
				pvo.setFk_decode(rs.getString(6));
			}

		} finally {
			close();
		}
		
		return pvo;
	}
	
	// 주문 내역 조회(select) 하는 함수
	@Override
	public List<OrderDetailVO> selectOrderList(Map<String, String> paraMap, String userid) throws SQLException {
		List<OrderDetailVO> orderList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select A.ordercode, A.fk_userid, to_char(A.orderdate, 'yyyy-mm-dd') AS orderdate, "
					   + " B.fk_pnum, B.odPrice, B.odAmount, B.deliveryCon, B.optionContents, "
					   + " c.pname, c.pimage1, c.fk_decode, (C.point*B.odamount) AS point "
					   + " from tbl_order A join tbl_order_details B "
					   + " on A.orderCode = B.fk_orderCode "
					   + " join tbl_product C "
					   + " on B.fk_pnum = C.pnum "
					   + " where fk_userid = ? "
					   + " and to_char(A.orderdate, 'yyyy-mm-dd') between ? and ? "
					   + " order by A.orderdate desc ";
			
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
				ovo.setOrderDate(rs.getString(3));
				
				ProductVO pvo = new ProductVO();
				pvo.setPname(rs.getString(9));
				pvo.setPimage1(rs.getString(10));	
				pvo.setFk_decode(rs.getString(11));
				pvo.setPoint(rs.getInt(12));
				
				OrderDetailVO odvo = new OrderDetailVO();
				odvo.setFk_pnum(rs.getInt(4));
				odvo.setOdPrice(rs.getInt(5));
				odvo.setOdAmount(rs.getInt(6));
				odvo.setDeliveryCon(rs.getString(7));
				odvo.setOptionContents(rs.getString(8));
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
