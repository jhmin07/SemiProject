<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
	
<jsp:include page="board.jsp"/>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("tr.NoticeHead").click(function(){
			var ctNo = $(this).children(".ctNo").text();				
			// $(this) 는 td가 아니라 tr 이므로 자식들(td) 중 class가 .userid인 것들을 찾는다.
			
			  location.href = "<%=request.getContextPath()%>/detailMenu/contentOneDetail.up?ctNo="+ctNo+"&goBackURL=${requestScope.goBackURL}";
		});
		$("tr.QAHead").click(function(){
			var qaNo = $(this).children(".qaNo").text();				
			// $(this) 는 td가 아니라 tr 이므로 자식들(td) 중 class가 .userid인 것들을 찾는다.
			
			  location.href = "<%=request.getContextPath()%>/detailMenu/qaOneDetail.up?qaNo="+qaNo+"&goBackURL=${requestScope.goBackURL}";
		});
		
		
	});
</script>
<div class="container" align="center">

	
	
	<c:if test="${menu == 1 }">
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
		
		<tbody>
			<tr>
				<td class="list list2">3</td>
				<td class="list ctTitle">배송 기간, 배송비 안내, 적립금, 게시판 이용안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-22</td>
				<td class="list list2">10</td>
			</tr>
		</tbody>
		
		<tbody>
			<tr>
				<td class="list list2">2</td>
				<td class="list ctTitle">게시판 이용규정 안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-22</td>
				<td class="list list2">20</td>
			</tr>
		</tbody>
		
		<tbody>
			<tr>
				<td class="list list2">1</td>
				<td class="list ctTitle">AS센터 휴무안내</td>
				<td class="list list2">관리자</td>
				<td class="list list2">2021-04-20</td>
				<td class="list list2">30</td>
			</tr>
		</tbody>
				
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
	</c:if>
	
	
	<c:if test="${menu == 2 }">
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
        	<c:forEach var="qvo" items="${requestScope.qaList}">
        		<tr class= "QAHead">
        			<td class="qaNo">${qvo.qaNo}</td>
        			<td class="Title">${qvo.qaTitle}</td>
        			<td>${qvo.fk_userid}</td>
        			<td>${qvo.qaRegisterday}</td>
        			<td>${qvo.qaViewcount}</td>
        		</tr>
        	</c:forEach>
        </tbody>
        
        
        
	</table>
	</c:if>
	
</div>

<div align="center">

	${requestScope.pageBar }

</div>
<jsp:include page="../../footer.jsp"/>