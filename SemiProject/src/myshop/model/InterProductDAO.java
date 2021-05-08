package myshop.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO {

	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	
	// tbl_detailcategory 테이블에서 카테고리 대분류 번호(fk_cnum), 카테고리코드(code), 카테고리명(cname), 세부 카테고리코드(decode), 세부 카테고리명(dename)을 조회해오기 
	List<DetailCategoryVO> getDetailCategoryList() throws SQLException ;

	
	// ------------------ MVC에서 만들었던 method --------------------- //
	
	// 메인페이지에 보여지는 상품이미지파일명을 모두 조회(select)하는 메소드 
	// DTO(Data Transfer Object) == VO(Value Object)	
	List<ImageVO> imageSelectAll() throws SQLException;
	
	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해  스펙별로 제품의 전체개수 알아오기 // 
	int totalPspecCount(String fk_snum) throws SQLException;

	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;

	// spec 목록 조회해오기
	List<SpecVO> selectSpecList() throws SQLException;

	// 제품번호 채번해오기
	int getPnumOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert 하기
	int productInsert(ProductVO pvo) throws SQLException;

	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기  
	int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	ProductVO selectOneProductByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고 해당 제품의 추가된 이미지 정보를 가져오기
	List<String> getImagesByPnum(String pnum) throws SQLException;
	
	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	ProductVO productDetailPage(String pnum) throws SQLException;

	// 특정 카테고리에 속하는 제품들을 일반적인 페이징 처리하여 조회(select)해오기
	List<ProductVO> selectProductByCategory(Map<String, String> paraMap) throws SQLException;
		
	// 페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수 알아오기(select)
	int getTotalPage(String decode) throws SQLException;

	//세부카테고리 목록 조회해오기
	List<DetailCategoryVO> selectdetailList(String cnum) throws SQLException;

	
	// 장바구니에 담기
	int addCart(String userid, String pnum, String odAmount, String optionNo) throws SQLException;
	

	// tbl_option 테이블에 제품의 추가이미지 파일명 insert 해주기  
	int product_option_insert(OptionVO ovo) throws SQLException;

	
	// 제품번호를 가지고서 해당 제품의 옵션정보를 조회해오기
	List<OptionVO> selectoption(String pnum) throws SQLException;

	// New 또는 HIT 상품 불러오기	
	List<ProductVO> newHitList(String fk_snum) throws SQLException;
	
	// 제품번호를 가지고서 해당 제품의 옵션정보를 조회해오기
	List<OptionVO> selectoname(String pnum) throws SQLException;

	// 리뷰남기기 (insert)
	int addComent(ReviewVO reviewsvo) throws SQLException;

	// 리뷰리스트 불러오기(select)
	List<ReviewVO> commentList(String fk_pnum) throws SQLException;

	// 리뷰지우기
	int reviewDel(String review_seq)throws SQLException;
	
	// 제품번호와 옵션분류명을 가지고서 해당 제품의 옵션정보를 조회해오기
	List<OptionVO> selectProductOption(String pnum, String oname) throws SQLException;
	
}
