package notice.model;

import java.sql.SQLException;
import java.util.*;

import QA.model.QAVO;
import notice.model.NoticeVO;

public interface InterNoticeDAO {



	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<NoticeVO> selectPagingContent(Map<String, String> paraMap) throws SQLException;

	NoticeVO contentOneDetail(String ctNo) throws SQLException;

	// tbl_product 테이블에 공지사항 insert 하기

	int contentHitUp(int hit, int ctNo) throws SQLException;

	int delNotice(String ctNo) throws SQLException;

	int getCtno(NoticeVO nvo) throws SQLException;

	int noticeInsert(NoticeVO nvo, int ctno) throws SQLException;

	int noticeUpdate(NoticeVO nvo) throws SQLException;

	
}
