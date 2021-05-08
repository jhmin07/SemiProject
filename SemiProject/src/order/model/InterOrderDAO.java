package order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterOrderDAO {
	
	// 주문 내역 insert 하는 함수 
	public int orderlistInsert(Map<String, String> paraMap) throws SQLException;

	// 주문 내역 조회(select) 하는 함수
	public List<OrderDetailVO> selectOrderList(Map<String, String> paraMap, String userid) throws SQLException;
	
	
}
