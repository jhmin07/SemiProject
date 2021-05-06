package order.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterOrderDAO {
	
	// 주문 내역 insert 하는 함수 
	public int orderlistInsert(Map<String, String> paraMap) throws SQLException;
	
	// 주문 코드 알아오는 함수
	public String getOrdercode() throws SQLException;

	// 배송지 정보 insert 하기
	public int deliverInfoInsert(DeliverInfoVO delivo) throws SQLException;
	
	
}
