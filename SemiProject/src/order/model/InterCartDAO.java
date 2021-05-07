package order.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterCartDAO {

	// 로그인한 사용자가 가지고 있는 장바구니 리스트를 가져오는 메소드
	List<CartVO> getCartList(String userid) throws SQLException ;

	// 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 알아오기 
	HashMap<String, String> selectCartSumPricePoint(String userid) throws SQLException ;

	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기 
	int delCart(String cartno) throws SQLException ;

	// 장바구니 테이블에서 특정제품을 장바구니에서 전체 비우기 
	int delAllCart(String userid) throws SQLException ;

	// 장바구니 테이블에서 특정제품을 장바구니에서 수량을 변경하기  
	int updateCart(String cartno, String oqty) throws SQLException ;

	// 장바구니에 담긴 물건 갯수알아오기 select
	int getCartCount(String userid) throws SQLException ;


	


}
