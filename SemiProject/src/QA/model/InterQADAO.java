package QA.model;

import java.sql.SQLException;
import java.util.*;

import notice.model.NoticeVO;

public interface InterQADAO {

	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<QAVO> selectPagingContent(Map<String, String> paraMap) throws SQLException;

	QAVO qaOneDetail(String qaNo) throws SQLException;

	// tbl_qaboard 테이블에 Q&A insert 하기
	int QAInsert(QAVO qvo) throws SQLException;



	
}
