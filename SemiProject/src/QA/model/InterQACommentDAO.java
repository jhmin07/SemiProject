package QA.model;

import java.sql.SQLException;
import java.util.List;

public interface InterQACommentDAO {

	int QACommentInsert(QACommentVO qcvo) throws SQLException;

	List<QACommentVO> qaView(String qaNo) throws SQLException;

	int getCommentCnt(String qaNo) throws SQLException;

	int delComment(String addno) throws SQLException;

	int commentUpdate(QACommentVO qacvo) throws SQLException;

}
