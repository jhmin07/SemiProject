package myshop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;

public class ProductDAO implements InterProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semioracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	// VO 를 사용하지 않고 Map 으로 처리해보겠습니다.	
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		List<HashMap<String, String>> categoryList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = " select cnum, code, cname " 
						+ " from tbl_category " 
						+ " order by cnum asc ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("cnum", rs.getString(1));
				map.put("code", rs.getString(2));
				map.put("cname", rs.getString(3));

				categoryList.add(map);
			} // end of while(rs.next())----------------------------------

		} finally {
			close();
		}

		return categoryList;
	}
	
	
	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	@Override
	public List<DetailCategoryVO> getDetailCategoryList() throws SQLException {
		List<DetailCategoryVO> detailCategList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = "select fk_cnum, code, cname, decode, dename "+
						"from tbl_detailcategory join tbl_category on fk_cnum = cnum "+
						"order by decode asc";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				DetailCategoryVO dcvo = new DetailCategoryVO();
				CategoryVO categvo = new CategoryVO(rs.getInt(1), rs.getString(2), rs.getString(3));
				
				dcvo.setCategvo(categvo);
				dcvo.setFk_cnum(rs.getInt(1));
				dcvo.setDecode(rs.getString(4));
				dcvo.setDename(rs.getString(5));

				detailCategList.add(dcvo);
			} 

		} finally {
			close();
		}

		return detailCategList;
	}
	
	
	
	// -----------------------------------------------------------------------------------
	@Override
	public List<ImageVO> imageSelectAll() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select imgno, imgfilename\n" + 
						"from tbl_main_image\n" + 
						"order by imgno asc";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ImageVO imgvo = new ImageVO();
				imgvo.setImgno(rs.getInt(1));
				imgvo.setImgfilename(rs.getString(2));
				
				imgList.add(imgvo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}

	
	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해  스펙별로 제품의 전체개수 알아오기 //
	@Override
	public int totalPspecCount(String fk_snum) throws SQLException {
		int totalCount = 0;

		try {
			conn = ds.getConnection();

			String sql = "select count(*) " 
						+ "from tbl_product " 
						+ "where fk_snum = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_snum);

			rs = pstmt.executeQuery();

			rs.next();

			totalCount = rs.getInt(1);

		} finally {
			close();
		}

		return totalCount;
	}

	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	@Override
	public List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = "select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate "+
	                     "from  "+
	                     "( "+
	                     "  select row_number() over(order by pnum desc) AS RNO "+
	                     "       , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point "+
	                     "      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate "+
	                     " from tbl_product P "+
	                     " JOIN tbl_category C "+
	                     " ON P.fk_cnum = C.cnum "+
	                     " JOIN tbl_spec S "+
	                     " ON P.fk_snum = S.snum "+
	                     " where S.sname = ? "+
	                     " ) V "+
	                     "where RNO between ? and ? ";
	          
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sname"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ProductVO pvo = new ProductVO();

				pvo.setPnum(rs.getInt(1)); // 제품번호
				pvo.setPname(rs.getString(2)); // 제품명

				CategoryVO categvo = new CategoryVO();
				categvo.setCode(rs.getString(3));

				pvo.setCategvo(categvo); // 카테고리코드
				pvo.setPcompany(rs.getString(4)); // 제조회사명
				pvo.setPimage1(rs.getString(5)); // 제품이미지1 이미지파일명
				pvo.setPimage2(rs.getString(6)); // 제품이미지2 이미지파일명
				pvo.setPqty(rs.getInt(7)); // 제품 재고량
				pvo.setPrice(rs.getInt(8)); // 제품 정가
				pvo.setSaleprice(rs.getInt(9)); // 제품 판매가(할인해서 팔 것이므로)

				SpecVO spvo = new SpecVO();
				spvo.setSname(rs.getString(10));

				pvo.setSpvo(spvo); // 스펙

				pvo.setPcontent(rs.getString(11)); // 제품설명
				pvo.setPoint(rs.getInt(12)); // 포인트 점수
				pvo.setPinputdate(rs.getString(13)); // 제품입고일자

				prodList.add(pvo);
			} // end of while-----------------------------------------

		} finally {
			close();
		}

		return prodList;
	}

	// spec 목록 조회해오기
	@Override
	public List<SpecVO> selectSpecList() throws SQLException {
		List<SpecVO> specList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = " select snum, sname " + 
						" from tbl_spec " + 
						" order by snum asc ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SpecVO spvo = new SpecVO();
				spvo.setSnum(rs.getInt(1));
				spvo.setSname(rs.getString(2));

				specList.add(spvo);
			}

		} finally {
			close();
		}

		return specList;
	}

	// 제품번호 채번해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
		int pnum = 0;

		try {
			conn = ds.getConnection();

			String sql = " select seq_tbl_product_pnum.nextval AS PNUM " + 
						" from dual ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			rs.next();
			pnum = rs.getInt(1);

		} finally {
			close();
		}

		return pnum;
	}

	// tbl_product 테이블에 제품정보 insert 하기
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_product(pnum, pname, fk_decode, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point) " +  
	                    " values(?,?,?,?,?,?,?,?,?,?,?,?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, pvo.getPnum());
	         pstmt.setString(2, pvo.getPname());
	         pstmt.setString(3, pvo.getFk_decode());    
	         pstmt.setString(4, pvo.getPcompany()); 
	         pstmt.setString(5, pvo.getPimage1());    
	         pstmt.setString(6, pvo.getPimage2()); 
	         pstmt.setInt(7, pvo.getPqty()); 
	         pstmt.setInt(8, pvo.getPrice());
	         pstmt.setInt(9, pvo.getSaleprice());
	         pstmt.setInt(10, pvo.getFk_snum());
	         pstmt.setString(11, pvo.getPcontent());
	         pstmt.setInt(12, pvo.getPoint());
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}

	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기  
	@Override
	public int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException {
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = " insert into tbl_product_imagefile(imgfileno, fk_pnum, imgfilename) "
					+ " values(seqImgfileno.nextval, ?, ?) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, pnum);
			pstmt.setString(2, attachFileName);

			result = pstmt.executeUpdate();

		} finally {
			close();
		}

		return result;
	}

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO selectOneProductByPnum(String pnum) throws SQLException {
		ProductVO pvo = null;

		try {
			conn = ds.getConnection();

			String sql = " select S.sname, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, fk_decode "
					+ " from " 
					+ " ( "
					+ "  select fk_snum, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, fk_decode "
					+ "  from tbl_product " 
					+ "  where pnum = ? " 
					+ " ) P JOIN tbl_spec S " 
					+ " ON P.fk_snum = S.snum ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				String sname = rs.getString(1); // "HIT", "NEW", "BEST" 값을 가짐
				int npnum = rs.getInt(2); // 제품번호
				String pname = rs.getString(3); // 제품명
				String pcompany = rs.getString(4); // 제조회사명
				int price = rs.getInt(5); // 제품 정가
				int saleprice = rs.getInt(6); // 제품 판매가
				int point = rs.getInt(7); // 포인트 점수
				int pqty = rs.getInt(8); // 제품 재고량
				String pcontent = rs.getString(9); // 제품설명
				String pimage1 = rs.getString(10); // 제품이미지1
				String pimage2 = rs.getString(11); // 제품이미지2
				String fk_decode = rs.getString(12); // 세부카테고리

				pvo = new ProductVO();

				SpecVO spvo = new SpecVO();
				spvo.setSname(sname);

				pvo.setSpvo(spvo);
				pvo.setPnum(npnum);
				pvo.setPname(pname);
				pvo.setPcompany(pcompany);
				pvo.setPrice(price);
				pvo.setSaleprice(saleprice);
				pvo.setPoint(point);
				pvo.setPqty(pqty);
				pvo.setPcontent(pcontent);
				pvo.setPimage1(pimage1);
				pvo.setPimage2(pimage2);
				pvo.setFk_decode(fk_decode);

			} // end of if-----------------------------

		} finally {
			close();
		}

		return pvo;
	}

	// 제품번호를 가지고 해당 제품의 추가된 이미지 정보를 가져오기
	@Override
	public List<String> getImagesByPnum(String pnum) throws SQLException {
		List<String> imgList = new ArrayList<>();

		try {
			conn = ds.getConnection();

			String sql = " select imgfilename " + 
						" from tbl_product_imagefile " + 
						" where fk_pnum = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String imgfilename = rs.getString(1); // 이미지파일명
				imgList.add(imgfilename);
			}

		} finally {
			close();
		}

		return imgList;
	}
	
	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO productDetailPage(String pnum) throws SQLException {
		
		ProductVO pvo = null;
	      
	      try {
	          conn = ds.getConnection(); 
	          
	          String sql = " select S.sname, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, fk_decode, fk_snum "+
	                     " from "+
	                     " ( "+
	                     "  select fk_snum, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, fk_decode "+
	                     "  from tbl_product "+
	                     "  where pnum = ? "+
	                     " ) P JOIN tbl_spec S "+
	                     " ON P.fk_snum = S.snum ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, pnum);
	          
	          rs = pstmt.executeQuery();
	          
	          if(rs.next()) {
	             
	             String sname = rs.getString(1);     // "HIT", "NEW", "BEST" 값을 가짐 
	             int    npnum = rs.getInt(2);        // 제품번호
	             String pname = rs.getString(3);     // 제품명
	             String pcompany = rs.getString(4);  // 제조회사명
	             int    price = rs.getInt(5);        // 제품 정가
	             int    saleprice = rs.getInt(6);    // 제품 판매가
	             int    point = rs.getInt(7);        // 포인트 점수
	             int    pqty = rs.getInt(8);         // 제품 재고량
	             String pcontent = rs.getString(9);  // 제품설명
	             String pimage1 = rs.getString(10);  // 제품이미지1
	             String pimage2 = rs.getString(11);  // 제품이미지2
	             String fk_decode = rs.getString(12); // 제품카테고리
	             int fk_snum = rs.getInt(13);
	             
	             pvo = new ProductVO(); 
	             
	             SpecVO spvo = new SpecVO();
	             spvo.setSname(sname);
	             spvo.setSnum(fk_snum);
	             
	             pvo.setSpvo(spvo);
	             pvo.setPnum(npnum);
	             pvo.setPname(pname);
	             pvo.setPcompany(pcompany);
	             pvo.setPrice(price);
	             pvo.setSaleprice(saleprice);
	             pvo.setPoint(point);
	             pvo.setPqty(pqty);
	             pvo.setPcontent(pcontent);
	             pvo.setPimage1(pimage1);
	             pvo.setPimage2(pimage2);
	             pvo.setFk_decode(fk_decode);
	             
	          } // end of if-----------------------------
	          
	      } finally {
	         close();
	      }
	      
	      return pvo;   
		
	}


	//세부카테고리 목록 조회해오기
		@Override
		public List<DetailCategoryVO> selectdetailList(String cnum) throws SQLException {
			
			List<DetailCategoryVO> detailList = new ArrayList<>();

			try {
				conn = ds.getConnection();

				String sql = " select fk_cnum, decode, dename "+
								" from tbl_detailCategory P "+
								" JOIN tbl_category C "+
								" ON P.fk_cnum = C.cnum "+
								" where C.cnum = ? ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, cnum);
				
				rs = pstmt.executeQuery();

				while (rs.next()) {
					DetailCategoryVO devo = new DetailCategoryVO();
					devo.setFk_cnum(rs.getInt(1));
					devo.setDecode(rs.getString(2));
					devo.setDename(rs.getString(3));

					detailList.add(devo);
				}

			} finally {
				close();
			}

			return detailList;
		}

		// 특정 카테고리에 속하는 제품들을 일반적인 페이징 처리하여 조회(select)해오기
		@Override
		public List<ProductVO> selectProductByCategory(Map<String, String> paraMap) throws SQLException {
			
			List<ProductVO> prodList = new ArrayList<>();
			
			try {
				conn=ds.getConnection();
				
				String sql = " select dename, sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate, fk_decode, fk_snum "+
								" from "+
								" ( "+
								"    select rownum AS RNO, dename, sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate, fk_decode, fk_snum "+
								"    from "+
								"    ( "+
								"        select C.dename, S.sname, pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, pinputdate, fk_decode, fk_snum "+
								"        from "+
								"        ( "+
								"            select pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate, fk_decode, fk_snum "+
								"            from tbl_product "+
								"            where fk_decode = ? "+
								"            order by pnum desc "+
								"        ) P "+
								"        JOIN tbl_detailCategory C "+
								"        ON P.fk_decode = C.decode "+
								"        JOIN tbl_spec S "+
								"        ON P.fk_snum = S.snum "+
								"    ) V "+
								" ) T "+
								" where T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				int sizePerPage = 8;
				
				pstmt.setString(1, paraMap.get("decode"));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); 
		        pstmt.setInt(3, (currentShowPageNo * sizePerPage));  
		        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()) {
		        	
		        	ProductVO pvo = new ProductVO();
		        	
		        	 pvo.setPnum(rs.getInt("pnum"));      // 제품번호
		             pvo.setPname(rs.getString("pname")); // 제품명
		             
		             DetailCategoryVO decategvo = new DetailCategoryVO(); 
		             decategvo.setDename(rs.getString("dename"));  // 카테고리명  
		             //decategvo.setDecode(rs.getString("fk_decode"));
		    
		             pvo.setDecategvo(decategvo);				// 세부카테고리
		             pvo.setFk_decode(rs.getString("fk_decode"));
		             pvo.setPcompany(rs.getString("pcompany")); // 제조회사명
		             pvo.setPimage1(rs.getString("pimage1"));   // 제품이미지1   이미지파일명
		             pvo.setPimage2(rs.getString("pimage2"));   // 제품이미지2   이미지파일명
		             pvo.setPqty(rs.getInt("pqty"));            // 제품 재고량
		             pvo.setPrice(rs.getInt("price"));          // 제품 정가
		             pvo.setSaleprice(rs.getInt("saleprice"));  // 제품 판매가(할인해서 팔 것이므로)
		               
		             SpecVO spvo = new SpecVO(); 
		             spvo.setSnum(rs.getInt("fk_snum")); 
		             spvo.setSname(rs.getString("sname"));
		             pvo.setSpvo(spvo); // 스펙 
		               
		             pvo.setPcontent(rs.getString("pcontent"));       // 제품설명 
		             pvo.setPoint(rs.getInt("point"));              // 포인트 점수        
		             pvo.setPinputdate(rs.getString("pinputdate")); // 제품입고일자                                             
		             
		             prodList.add(pvo);
		        }// end of while
		        
			} finally {
				close();
			}
			
			return prodList;
		}

		// 페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수 알아오기(select)
		@Override
		public int getTotalPage(String decode) throws SQLException {
			
			int totalPage = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " select  count(*) "  
		                  + " from tbl_product "
		                  + " where fk_decode = ? "; 
		         
		         pstmt = conn.prepareStatement(sql);
		         
		         pstmt.setString(1, decode);
		               
		         rs = pstmt.executeQuery();
		         
		         rs.next();
		         
		         totalPage = rs.getInt(1);
		         
		      } finally {
		         close();
		      }      
		      
		      return totalPage;
		}
		
		// 장바구니에 담기
		@Override
		public int addCart(String userid, String pnum, String odAmount, String optionNo) throws SQLException {
			
			int n = 0;
			// System.out.println("optionNo 확인" + optionNo);
			// System.out.println("odAmount 확인" + odAmount);
			// System.out.println("pnum 확인" + pnum);
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select cartno, optionNo_es"
						  	  + " from tbl_cart "
						  	  + " where fk_userid = ? and fk_pnum = ? ";
				
				pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, userid);
		        pstmt.setString(2, pnum);
		          
		        rs = pstmt.executeQuery(); 
		        
		        if ( rs.next() ) {
		        // 제품이 존재하는 경우
		        	
			       int cartno = rs.getInt("cartno");
			       String optionNo_es = rs.getString("optionNo_es");
			       // System.out.println("optionNo_es : "+optionNo_es);
			       // System.out.println("optionNo 2차확인 : "+optionNo);
			        		        
			        if( optionNo_es.equals(optionNo) ) {
			        // System.out.println("// 같은 제품이 존재하고 옵션도 같은 경우");
		        	// 같은 제품이 존재하고 옵션도 같은 경우
		        	        	
		        	sql = " update tbl_cart set odAmount = odAmount + ? "
		        		+	" where cartno = ? and optionNo_es = ? ";
		        	 
		        	pstmt = conn.prepareStatement(sql);
		        	pstmt.setInt(1, Integer.parseInt(odAmount));
		        	pstmt.setInt(2, cartno);
		        	pstmt.setString(3, optionNo);
		        	
		        	n = pstmt.executeUpdate();
		        	
			        }
			        
			        else if ( !optionNo_es.equals(optionNo) )  {
			        	
			        	 optionNo_es = "";
			        	
			        	// System.out.println("// 같은 제품이 존재하고 옵션이 같지 않은 경우");
			        	// 같은 제품이 존재하고 옵션이 같지 않은 경우
			        	
			        	sql = " insert into tbl_cart(cartno, fk_userid, fk_pnum, odAmount, cartdate, optionNo_es) "
			                 + " values(seq_tbl_cart_cartno.nextval, ?, ?, ?, default, ?) ";
			        	
			        	pstmt = conn.prepareStatement(sql);
			        	pstmt.setString(1, userid);
			        	pstmt.setInt(2, Integer.parseInt(pnum));
			        	pstmt.setInt(3, Integer.parseInt(odAmount));
			        	pstmt.setString(4, optionNo);
			        	
			        	n = pstmt.executeUpdate();		        	
			        }
			        
		        }	        
		        else {
		        	// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
		        	
		        	sql = " insert into tbl_cart(cartno, fk_userid, fk_pnum, odAmount, cartdate, optionNo_es) "
		                 + " values(seq_tbl_cart_cartno.nextval, ?, ?, ?, default, ?) ";
		        	
		        	pstmt = conn.prepareStatement(sql);
		        	pstmt.setString(1, userid);
		        	pstmt.setInt(2, Integer.parseInt(pnum));
		        	pstmt.setInt(3, Integer.parseInt(odAmount));
		        	pstmt.setString(4, optionNo);
		        	
		        	n = pstmt.executeUpdate();
		        	
		        }
				
			} finally {
				close();
			}
			
			return n;
			
		}

		
	// tbl_option 테이블에 제품의 추가이미지 파일명 insert 해주기  
	@Override
	public int product_option_insert(OptionVO ovo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_option (optionNo, onum, oname, fk_pnum, addprice, ocontents) "
					+ "values (seq_tbl_option_optionNo.nextval, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ovo.getOnum());
			pstmt.setString(2, ovo.getOname());
			pstmt.setInt(3, ovo.getFk_pnum());
			pstmt.setInt(4, ovo.getAddprice());
			pstmt.setString(5, ovo.getOcontents());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	// 제품번호를 가지고서 해당 제품의 옵션정보를 조회해오기
	@Override
	public List<OptionVO> selectoption(String pnum) throws SQLException {
		
		List<OptionVO> optionList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " select onum, oname, fk_pnum, addprice, ocontents "+
							 " from tbl_option " +
						 	 " where fk_pnum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				OptionVO ovo = new OptionVO();
				
				int onum = rs.getInt("onum");
				String oname = rs.getString("oname");
				int fk_pnum = rs.getInt("fk_pnum");
				int addprice = rs.getInt("addprice");
				String ocontents = rs.getString("ocontents");
				
				ovo.setOnum(onum);
				ovo.setOname(oname);
				ovo.setFk_pnum(fk_pnum);
				ovo.setAddprice(addprice);
				ovo.setOcontents(ocontents);
				
				optionList.add(ovo);
				
			}

		} finally {
			close();
		}
		
		return optionList;
		
	}

	// New 또는 HIT 상품 불러오기
		@Override
		public List<ProductVO> newHitList(String fk_snum) throws SQLException {
			
			List<ProductVO> newHitList = new ArrayList<>();

			try {
				conn = ds.getConnection();

				String sql = " select pnum, pname, pcompany, pimage1, pimage2, pqty, price, saleprice, pcontent, point, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate, fk_decode, fk_snum "              
			            	+ " from tbl_product "              
			            	+ " where fk_snum = ? "          
			            	+ " order by pinputdate desc ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, fk_snum);
				
				rs = pstmt.executeQuery();

				 while(rs.next()) {
			        	
		        	ProductVO pvo = new ProductVO();
		        	
		        	 pvo.setPnum(rs.getInt("pnum"));      // 제품번호
		             pvo.setPname(rs.getString("pname")); // 제품명	             
		             pvo.setPcompany(rs.getString("pcompany")); // 제조회사명
		             pvo.setPimage1(rs.getString("pimage1"));   // 제품이미지1   이미지파일명
		             pvo.setPimage2(rs.getString("pimage2"));   // 제품이미지2   이미지파일명
		             pvo.setPqty(rs.getInt("pqty"));            // 제품 재고량
		             pvo.setPrice(rs.getInt("price"));          // 제품 정가
		             pvo.setSaleprice(rs.getInt("saleprice"));  // 제품 판매가(할인해서 팔 것이므로)
		             pvo.setPcontent(rs.getString("pcontent"));       // 제품설명 
		             pvo.setPoint(rs.getInt("point"));              // 포인트 점수        
		             pvo.setPinputdate(rs.getString("pinputdate")); // 제품입고일자  	             
		             pvo.setFk_decode(rs.getString("fk_decode"));               
		                                                       
		             
		             newHitList.add(pvo);
		        }// end of while
				 
				
			} finally {
				close();
			}

			return newHitList;
	}
	
	// 제품번호를 가지고서 해당 제품의 옵션정보를 조회해오기
	@Override
	public List<OptionVO> selectoname(String pnum) throws SQLException {
		
		List<OptionVO> onameList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " select distinct(oname),onum "+
							 " from tbl_option " +
						 	 " where fk_pnum = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				OptionVO ovo = new OptionVO();
				
				String oname = rs.getString(1);
				int onum = rs.getInt(2);
				
				ovo.setOnum(onum);
				ovo.setOname(oname);
				
				onameList.add(ovo);
				
			}

		} finally {
			close();
		}
		
		return onameList;
		
	}

	// 리뷰남기기 (insert)
	@Override
	public int addComent(ReviewVO reviewsvo) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_review(reviewNo, fk_userid, fk_pnum, reviewSubject, review_like, reviewRegisterday) "
	                  + " values(seq_tbl_review_reviewNo.nextval, ?, ?, ?, ?, default) ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, reviewsvo.getFk_userid());
	         pstmt.setInt(2, reviewsvo.getFk_pnum());
	         pstmt.setString(3, reviewsvo.getReviewSubject());
	         pstmt.setInt(4, reviewsvo.getReview_like());
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	// 리뷰리스트 불러오기
	@Override
	public List<ReviewVO> commentList(String fk_pnum) throws SQLException {
		List<ReviewVO> commentList = new ArrayList<>();
        
        try {
           conn = ds.getConnection();
           
           String sql = " select reviewNo, fk_userid, name, fk_pnum, reviewSubject, to_char(reviewRegisterday, 'yyyy-mm-dd hh24:mi:ss') AS reviewRegisterday , review_like "+
           		" from tbl_review R join tbl_member M "+
           		" on R.fk_userid = M.userid  "+
           		" where R.fk_pnum = ? "+
           		" order by reviewNo desc ";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, fk_pnum);
           
           rs = pstmt.executeQuery();
           
           while(rs.next()) {
               String reviewSubject = rs.getString("reviewSubject");
               String name = rs.getString("name");
               String reviewRegisterday = rs.getString("reviewRegisterday");
               String fk_userid = rs.getString("fk_userid");
               int reviewNo = rs.getInt("reviewNo");
               int review_like = rs.getInt("review_like");
                                       
               ReviewVO reviewvo = new ReviewVO();
               reviewvo.setReviewSubject(reviewSubject);
               
               MemberVO mvo = new MemberVO();
               mvo.setName(name);
               
               reviewvo.setMvo(mvo);
               reviewvo.setReviewRegisterday(reviewRegisterday);
               reviewvo.setFk_userid(fk_userid);
               reviewvo.setReviewNo(reviewNo);
               reviewvo.setReview_like(review_like);
               
               commentList.add(reviewvo);
            }
           
        } finally {
           close();
        }
        
        return commentList;
	}
	

	// 특정제품의 상품 후기 삭제하기(delete)
	@Override
	public int reviewDel(String review_seq) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_review "
	                  + " where reviewNo = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, review_seq);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	@Override
	public List<OptionVO> selectProductOption(String pnum, String oname) throws SQLException {
		
		List<OptionVO> optionList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = " select ocontents, optionNo "+
							 " from tbl_option " +
						 	 " where fk_pnum = ? and oname = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, pnum);
			pstmt.setString(2, oname);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				OptionVO ovo = new OptionVO();
				
				String ocontents = rs.getString(1);
				int optionNo = rs.getInt(2);
				
				ovo.setOcontents(ocontents);
				ovo.setOptionNo(optionNo);
				
				optionList.add(ovo);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			close();
		}
		
		return optionList;
		
	}

}
