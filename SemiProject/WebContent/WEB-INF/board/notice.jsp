<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
   
<jsp:include page="../header4.jsp"/>
	


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<style type="text/css">	
	div.noticeDiv{
   		margin-top: 100px;
	}
	img#boardImg {
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
	a.boardA {
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
	td.Title:hover {
		cursor: pointer;
		text-decoration: underline;
	}
	.page_click{
		background-color: black;
		color: white !important;
	}
	td.page_hover:hover {
		cursor: pointer;
	}
	table.writeSearchTable{
		width: 90%;
		text-align: right;
	}
	table.writeSearchTable td#write{
		width: 85px;
	}
	div#pageBar{
		margin-bottom: 100px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){	
		
		if("${fn:trim(requestScope.searchWord)}" != ""){
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		$(".GoodsQA").removeClass("page_click");
		$(".Notice").addClass("page_click");
		
		$("td.GoodsQA").click(function(){
			location.href="<%=request.getContextPath()%>/board/boardQA.up";
		});
		$("td.Notice").click(function(){
			location.href="<%=request.getContextPath()%>/board/board.up" ;
		});
		$("tr.NoticeHead").click(function(){
			var ctNo = $(this).children(".ctNo").text();				
			// $(this) 는 td가 아니라 tr 이므로 자식들(td) 중 class가 .userid인 것들을 찾는다.
			
			  location.href = "<%=request.getContextPath()%>/board/contentOneDetail.up?ctNo="+ctNo+"&goBackURL=${requestScope.goBackURL}";
		});
		
	});
	
	
	// Function Declaration
	function goSearch(){
		var frm = document.SearchFrm;
		frm.action = "board.up"; // 자기자신한테 간다. 그냥 목록 갯수만 바꿔줄 뿐
		frm.method = "GET";	// 숨길필요 없이 빨리빨리 이동해야해서 get 사용
		frm.submit();
	}
	function goWriteNotice(){
		location.href="<%=request.getContextPath()%>/board/noticeWrite.up";
	};
</script>

<div class="container noticeDiv" align="center">
<img id="boardImg" src="../image/board.png"/>
	<table class="table page_tab" style="margin: 25px 0;">
		<tbody>
			<tr>
				<td class="page_tab1 GoodsQA page_hover">
					<a class="GoodsQA boardA">상품 Q&A</a>
				</td>
				<td class="page_tab1 Notice page_hover">
					<a class="Notice boardA">공지사항</a>
				</td>
			</tr>
		</tbody>
	</table>

	<table class="writeSearchTable">
		<tr>
			<td id="search">
					<form name="SearchFrm">
						<select id="searchType" name="searchType">
							<option value="name">이름</option>
							<option value="title">제목</option>
							<option value="contents">내용</option>
						</select>
						<input type="text" id="searchWord" name="searchWord" />
						<input type="text" style="display: none;">
						<button type="button" onclick="goSearch();" style="background-color: white; color: black; font-size: 15px; font-weight: bold; border-radius: 5%">검색</button>				
					</form>
			</td>
			<c:if test="${sessionScope.loginadmin.adId != null}">
				<td id="write">
					<button onClick="goWriteNotice();" style="background-color: black; color: white; font-size: 15px; font-weight: bold; border-radius: 5%">글쓰기</button>
				</td>
			</c:if>
		</tr>
	</table>
	

		<table class="table table-bordered" style="width: 90%; margin-top: 20px;">
		<thead>
			<tr>
				<th class="page_tab2 board_tab2">No.</th>
				<th class="page_tab2">Contents</th>
				<th class="page_tab2 board_tab2" style="width: 100px;">Name</th>
				<th class="page_tab2 board_tab2" style="width: 200px;">Date</th>
				<th class="page_tab2 board_tab2">Hits</th>
			</tr>
		</thead>
		
		
		<tbody id="NoticeList">
        	<c:forEach var="nvo" items="${requestScope.noticeList}">
        		<tr class= "NoticeHead">
        			<td class="ctNo">${nvo.ctNo}</td>
        			<td class="Title">${nvo.ctTitle}</td>
        			<td>${nvo.fk_adId}</td>
        			<td>${nvo.ctRegisterday}</td>
        			<td>${nvo.ctViewcount}</td>
        		</tr>
        	</c:forEach>
        </tbody>
        
        
        
	</table>

	
</div>

<div id="pageBar" align="center">

	${requestScope.pageBar }

</div>
<jsp:include page="../footer.jsp"/>	