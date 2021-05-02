package notice.model;

import java.sql.SQLException;
import java.util.*;

import notice.model.NoticeVO;

public interface InterNoticeDAO {



	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<NoticeVO> selectPagingContent(Map<String, String> paraMap) throws SQLException;

	NoticeVO contentOneDetail(String ctNo) throws SQLException;

	// tbl_product 테이블에 공지사항 insert 하기
	int noticeInsert(NoticeVO nvo) throws SQLException;
	
}
