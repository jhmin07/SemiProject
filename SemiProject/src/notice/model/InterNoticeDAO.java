package notice.model;

import java.sql.SQLException;
import java.util.*;

import notice.model.NoticeVO;

public interface InterNoticeDAO {



	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<NoticeVO> selectPagingContent(Map<String, String> paraMap) throws SQLException;

	NoticeVO contentOneDetail(String ctNo) throws SQLException;
	
}
