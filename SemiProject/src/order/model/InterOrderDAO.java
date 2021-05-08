package order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.model.ProductVO;

public interface InterOrderDAO {
	
	// == Transaction 처리 == 
	// 1. 주문내역 테이블에 주문내역 insert
	// 2. 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자,옵션} insert
	// 3. 장바구니 테이블에서 주문상품된 상품 delete
	public int orderInsertProcess(Map<String, Object> paraMap) throws SQLException;
	
	// 주문 코드 알아오는 함수
	public String getOrdercode() throws SQLException;

	// 배송지 정보 insert 하기
	public int deliverInfoInsert(DeliverInfoVO delivo) throws SQLException;

	// 주문하기 페이지에서 보여줄 상품의 정보 가져오기 (select)
	public ProductVO getProdInfo(String userid, String cartno) throws SQLException;

	// 주문 내역 조회(select) 하는 함수
	public List<OrderDetailVO> selectOrderList(Map<String, String> paraMap, String userid) throws SQLException;

	
	
}
