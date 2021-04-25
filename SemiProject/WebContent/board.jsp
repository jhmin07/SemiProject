<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="header4.jsp"/>
	
<style type="text/css">
	div.container {		
		margin: 80px auto;
	}	
	table.table {
		width: 90%; 
		border: solid 1px gray;
		border-collapse: collapse;
	}
	td.page_tab1 {
		border: solid 1px gray;
		padding: 15px;
		text-align: center;		
	}
	th.page_tab2 {
		border: solid 1px gray;		
		text-align: center;
		padding: 3px;
		font-weight: normal;
	}
	th.board_tab2 {
		width: 80px;
	}	
	a {
		color: black;
		text-decoration: none;
		font-size: 15pt;
		font-weight: bold;
	}	
	td.page_tab1:hover {
		background-color: #e0ebeb;
	}
	td.list {
		font-size: 11pt;
	}
	td.list2 {
		text-align: center;
	}
	td.list:hover {
		cursor: pointer;
	}
</style>
<script type="text/javascript">
</script>
<div class="container" align="center">
<img src="image/board.png" style="width: 90%; height: 280px;"/>
	<table class="table page_tab" style="margin: 25px 0;">
		<tbody>
			<tr>
				<td class="page_tab1">
					<a href="">상품 Q&A</a>
				</td>
				<td class="page_tab1">
					<a href="">공지사항</a>
				</td>
			</tr>
		</tbody>
	</table>
	<div align="right" style="margin-right: 60px;">
	<form name="memberFrm">
		<select id="searchType" name="searchType">
			<option value="name">이름</option>
			<option value="title">제목</option>
			<option value="contents">내용</option>
			<option value="product">상품</option>
		</select>
		<input type="text" id="searchWord" name="searchWord" />
		<input type="text" style="display: none;">
		<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>				
	</form>
	</div>
	
	<table class="table table-bordered" style="width: 90%; margin-top: 20px;">
		<thead>
			<tr>
				<th class="page_tab2 board_tab2">No.</th>
				<th class="page_tab2">Contents</th>
				<th class="page_tab2 board_tab2">Name</th>
				<th class="page_tab2 board_tab2">Date</th>
				<th class="page_tab2 board_tab2">Hits</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td class="list list2">3</td>
				<td class="list">배송 기간, 배송비 안내, 적립금, 게시판 이용안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-22</td>
				<td class="list list2">10</td>
			</tr>
		</tbody>
		
		<tbody>
			<tr>
				<td class="list list2">2</td>
				<td class="list">게시판 이용규정 안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-22</td>
				<td class="list list2">20</td>
			</tr>
		</tbody>
		
		<tbody>
			<tr>
				<td class="list list2">1</td>
				<td class="list">AS센터 휴무안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-20</td>
				<td class="list list2">30</td>
			</tr>
		</tbody>
	</table>
</div>
<div align="center">
<ul class="pagination">
	<li class="previous"><a href="#">Previous</a></li>
    <li><a href="#">1</a></li>
    <li class="active"><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    <li class="next"><a href="#">Next</a></li>
</ul>
</div>
<jsp:include page="footer.jsp"/>