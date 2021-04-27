<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<jsp:include page="../../header4.jsp"/>
	


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">	
	img {
		width: 90%;		
		height: 280px;
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
		width: 100%;
		height: 100%;
	}	
	table.table-bordered td {
		font-size: 11pt;
		text-align: center;
	}
	td.ctTitle:hover {
		cursor: pointer;
	}
	.page_click{
		background-color: black;
		color: white;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){		
		
		
		$("td.GoodsQA").click(function(){
			$(".GoodsQA").addClass("page_click");
			$(".Notice").removeClass("page_click");
			location.href="<%=request.getContextPath()%>/detailMenu/boardQA.up";
		});
		$("td.Notice").click(function(){
			$(".GoodsQA").removeClass("page_click");
			$(".Notice").addClass("page_click");
			location.href="<%=request.getContextPath()%>/detailMenu/boardBody.up" ;
		});
	});
</script>
<div class="container" align="center">
<img src="../image/board.png"/>
	<table class="table page_tab" style="margin: 25px 0;">
		<tbody>
			<tr>
				<td class="page_tab1 GoodsQA">
					<a class=" GoodsQA">상품 Q&A</a>
				</td>
				<td class="page_tab1 Notice">
					<a class=" Notice">공지사항</a>
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
	

<div align="center">


</div>
<%-- <jsp:include page="../../footer.jsp"/> --%>