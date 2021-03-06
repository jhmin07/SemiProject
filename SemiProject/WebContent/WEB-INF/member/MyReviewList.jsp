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


dfn {
 /*  background: rgba(0,0,0,0.2); */
  border-bottom: dashed 1px rgba(0,0,0,0.8);
  padding: 0 0.4em;
  /* cursor: help; */
  position: relative;
  
}
dfn::after {
  content: attr(data-info);
  display: inline;
  position: absolute;
  top: 22px; left: 0;
  opacity: 0;
  width: 230px;
  font-size: 13px;
  font-weight: 700;
  line-height: 1.5em;
  padding: 0.5em 0.8em;
  background: rgba(0,0,0,0.8);
  color: #fff;
  pointer-events: none; /* This prevents the box from apearing when hovered. */
  transition: opacity 250ms, top 250ms;
}
dfn::before {
  content: '';
  display: block;
  position: absolute;
  top: 12px; left: 20px;
  opacity: 0;
  width: 0; height: 0;
  border: solid transparent 5px;
  border-bottom-color: rgba(0,0,0,0.8);
  transition: opacity 250ms, top 250ms;
}
dfn:hover {z-index: 2;} /* Keeps the info boxes on top of other elements */
dfn:hover::after,
dfn:hover::before {opacity: 1;}
dfn:hover::after {top: 30px;}
dfn:hover::before {top: 20px;}



</style>

<script type="text/javascript">
$(document).ready(function(){
	
	
	

	
});
	
	// Function Declaration
	
//?????? ????????? ??????????????? ???????????? ??????
 function goReviewDel(review_seq){
	   var bool = confirm("????????? ?????????????????????????");
	   if(bool){
		   $.ajax({
			   url:"<%= request.getContextPath()%>/shop/reviewDel.up",
	         type:"post",
	         data:{"review_seq":review_seq},
	         dataType:"json",
	         success:function(json){
	         	if(json.n == 1){
	         		alert("???????????? ????????? ?????????????????????.");
	         		location.href="showMyReview.up";
	         	}
	         	else{
	         		alert("???????????? ????????? ??????????????????.");
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
	
	
	<%-- ?????? ?????? ???????????? --%>
	<table class="table odr_list">
		<thead>
			<tr>
				<th>????????????</th>
				<th>????????????</th>
				<th>??????????????????</th>
				<th>??????????????????</th>
				<th>??????</th>
				<th>????????????</th>
				<th>????????????</th>				
			</tr>
		</thead>
		
		<tbody>		
			<c:if test="${empty requestScope.review}">
				<tr>
					<td colspan="7" align="center" class="ordertext">
						??????????????? ???????????? ????????? ????????????.
					</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty requestScope.review}">
			
				<c:forEach var="review" items="${requestScope.review}" varStatus="status">
				<tr>
					<td> <%-- ???????????? --%>
						<span>${review.ovo.orderDate}</span>
					</td>
					<td> <%-- ???????????? --%>
					<a href="<%= ctxPath%>/detailMenu/productDetailPage.up?pnum=${review.fk_pnum}">
						<img src="<%= ctxPath%>/image/product/${review.pvo.fk_decode}/${review.pvo.pimage1}" width="130px"/>
					</a><br>
					<dfn data-info="?????? ???????????? ??????????????? ???????????????????????? ???????????????.">	<span>${review.pvo.pname}</span></dfn>
					</td>
					<td> <%-- ?????????????????? --%>
						<span id="totalprice">
							<fmt:formatNumber value="${review.ovo.totalPrice}" pattern="###,###" />
						</span> ???
					</td>
					<td> <%-- ?????????????????? --%>
						<span>${review.reviewRegisterday}</span>
					</td>
					<td> <%-- ?????? --%>
						
						<c:if test="${review.review_like == 1}"> 
							<div> <span style="color:red;">???</span><span style="color:gray;">????????????</span> </div>
						</c:if>
						<c:if test="${review.review_like == 2}"> 
							<div> <span style="color:red;">??????</span><span style="color:gray;">?????????</span> </div>
						</c:if>
						<c:if test="${review.review_like == 3}"> 
							<div> <span style="color:red;">?????????</span><span style="color:gray;">??????</span> </div>
						</c:if>
						<c:if test="${review.review_like == 4}"> 
							<div> <span style="color:red;">????????????</span><span style="color:gray;">???</span> </div>
						</c:if>
						<c:if test="${review.review_like == 5}"> 
							<div> <span style="color:red;">???????????????</span></div>
						</c:if>
					</td>
					<td> <%-- ???????????? --%>
						<span>${review.reviewSubject}</span>
					</td>
					<td> <%-- ???????????? --%>
						<span class="del" style="cursor: pointer;" onClick="goReviewDel('${review.reviewNo}');"><img id="delete_cart" src="../image/cart/delete.png" style="width: 11px; height: 11px;"/></span>
					</td>
				</tr>				
				</c:forEach>
							
			</c:if>
		</tbody>
	</table>
	
	
</div>

<jsp:include page="../footer.jsp"/>