<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
   
<jsp:include page="../header4.jsp"/>

<style type="text/css">

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
	}
	.page_click{
		background-color: black;
		color: white !important;
	}
	td.page_hover:hover {
		cursor: pointer;
	}
	
	
	
	div#QAWrite{
		margin-top: 100px;
	}
	input.QATitle{
		font-size: 10pt;
		color: gray;
		height: 40px;
		width: 1000px
	}
	input.QAContent{
		font-size: 10pt;
		color: gray;
		height: 700px;
		width: 1000px; 		
	}
	span#QAWriter{
		display: inline-block;
		width: 90%;
		font-size: 15pt;
		padding-left: 30px;
	}
</style>

<script type="text/javascript">
$(document).ready(function(){	
	
	if("${fn:trim(requestScope.searchWord)}" != ""){
		$("select#searchType").val("${requestScope.searchType}");
		$("input#searchWord").val("${requestScope.searchWord}");
	}
	
	$(".Notice").removeClass("page_click");
	$(".GoodsQA").addClass("page_click");
	
	$("td.GoodsQA").click(function(){
		location.href="<%=request.getContextPath()%>/board/boardQA.up";
	});
	$("td.Notice").click(function(){
		location.href="<%=request.getContextPath()%>/board/board.up" ;
	});
	
});

// Function Declaration
function goModify(){
	var frm = document.QAModify;
	frm.action = "QAModifySubmit.up?"; 
	// 자기자신한테 간다. 그냥 목록 갯수만 바꿔줄 뿐
	frm.method = "GET";	// 숨길필요 없이 빨리빨리 이동해야해서 get 사용
	frm.submit();
}
</script>


<div class="container" id="QAWrite" align="center">
	<img id="boardImg" src="../image/board.png"/>
	<table class="table page_tab" style="margin: 25px 0;">
		<tbody>
			<tr>
				<td class="page_tab1 GoodsQA page_hover">
					<a class="GoodsQA boardA">상품 Q&A</a>
				</td>
				<td class="page_tab1 QA page_hover">
					<a class="QA boardA">공지사항</a>
				</td>
			</tr>
		</tbody>
	</table>

	<form name="QAModify">
		<span id="QAWriter">작성자:${requestScope.userid}</span>
		<br><br>
		<table>
			<tbody>
				<tr>
					<td><input type="hidden" class="QANo QAinput" value="${requestScope.qvo.qaNo}" name="qaNo"/></td>
				</tr>
				<tr>
					<td><input class="QATitle QAinput" value="${requestScope.qvo.qaTitle}"  type="text" name="QATitle"/></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
				</tr>
				<tr>
					<td><input class="QAContent QAinput" value="${requestScope.qvo.qaContent}"  type="text" name="QAContent" /></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
				</tr>
				<!-- <tr>
					<td><input type="file" name="QAImg" class="QAImg" /></td>
				</tr> -->
			</tbody>
		</table>
		<br><br>
		<button onClick='goModify();' style="background-color: #196666; color: white; height: 50px; width: 150px; font-size: 25px; font-weight: bold;">작성완료</button>
	</form>

</div>





<jsp:include page="../footer.jsp"/>	