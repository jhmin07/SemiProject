package order.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterOrderDAO {
	
	// 주문 내역 insert 하는 함수 
	public int orderlistInsert(Map<String, String> paraMap) throws SQLException;
	
	
}
