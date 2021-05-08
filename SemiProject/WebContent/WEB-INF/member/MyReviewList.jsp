<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% 
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header4.jsp"/>

<style type="text/css">
div.container {
	margin: 80px auto;
}

div.stateSelect{
	border: solid 2.5px #ddd;
	padding: 20px;
}

a.btnNormal {
	border: solid 1px #f2f2f2;
	color: black;
	font-size: 9pt;
}

span.period {
	margin-right: 10px;
}

span#showOrderList{
	border: solid 1px #336699;
	background-color: #336699;
	color: white;
	padding: 2px;
	margin-left: 5px;
	cursor: pointer;
}

span.chkbox {
	font-size: 9pt;
	border: solid 1px gray;
	color: gray;
	border-radius: 5px;
	margin-right: 2px;
	padding-left: 3px;	
}

input.dateType{
	display: none;
}

input.datepicker{
	width: 100px;
}

label{
	cursor: pointer;
	font-weight: normal;
}

table.odr_list {
	border-bottom: solid 1px #ddd !important;
}

table.odr_list > thead {
	background-color: #f2f2f2;
}

img.odr_img {
	width: 100px;
	height: 100px;
}

tr.odr_tr > td {
	vertical-align: middle !important;
}


</style>

<script type="text/javascript">
$(document).ready(function(){
	
	
	

	
});
	
	// Function Declaration
	
//특정 제품의 제품후기를 삭제하는 함수
 function delMyReview(review_seq){
	   var bool = confirm("정말로 삭제하시겠습니까?");
	   if(bool){
		   $.ajax({
			   url:"<%= request.getContextPath()%>/shop/reviewDel.up",
	         type:"post",
	         data:{"review_seq":review_seq},
	         dataType:"json",
	         success:function(json){
	         	if(json.n == 1){
	         		alert("제품후기 삭제가 성공되었습니다.");
	         		location.href="showMyReview.up";
	         	}
	         	else{
	         		alert("제품후기 삭제가 실패했습니다.");
	         	}
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
		   });
	   }
	   
}  
	
</script>

<div class="container">	
	<h2 align="center">My Review List</h2>
	
	
	<%-- 주문 내역 보여주기 --%>
	<table class="table odr_list">
		<thead>
			<tr>
				<th>구매날짜</th>
				<th>상품정보</th>
				<th>상품구매금액</th>
				<th>리뷰작성날짜</th>
				<th>별점</th>
				<th>리뷰내용</th>
				<th>리뷰삭제</th>				
			</tr>
		</thead>
		
		<tbody>		
			<c:if test="${empty requestScope.orderList}">
				<tr>
					<td colspan="7" align="center" class="ordertext">
						주문한 상품이 없습니다.
					</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty requestScope.orderList}">
			
				<c:forEach var="review" items="${requestScope.review}" varStatus="status">
				<tr>
					<td> <%-- 구매날짜 --%>
						<span>${review.ovo.orderDate}</span>
					</td>
					<td> <%-- 상품정보 --%>
					<a href="<%= ctxPath%>/detailMenu/productDetailPage.up?pnum=${review.fk_pnum}">
						<img src="<%= ctxPath%>/image/product/${review.pvo.fk_decode}/${review.pvo.pimage1}" width="130px"/>
					</a>
					<span>${review.pvo.pname}</span>	
					</td>
					<td> <%-- 상품구매금액 --%>
						<span id="totalprice">
							<fmt:formatNumber value="${review.ovo.totalPrice}" pattern="###,###" />
							
						</span> 원
					</td>
					<td> <%-- 리뷰작성날짜 --%>
						<span>${review.reviewRegisterday}</span>
					</td>
					<td> <%-- 별점 --%>
						<span>${review.review_like}</span>
					</td>
					<td> <%-- 리뷰내용 --%>
						<span>${review.reviewSubject}</span>
					</td>
					<td> <%-- 리뷰삭제 --%>
						<span class="del" style="cursor: pointer;" onClick="goReviewDel('${review.reviewNo}');"><img id="delete_cart" src="../image/cart/delete.png" style="width: 11px; height: 11px;"/></span>
					</td>
				</tr>				
				</c:forEach>
							
			</c:if>
		</tbody>
	</table>
	
	
</div>

<jsp:include page="../footer.jsp"/>