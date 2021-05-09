<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
	String ctxPath = request.getContextPath();
	//    /SemiProject
%>

<jsp:include page="menuHeader.jsp"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>이불커버</title> -->
<style type="text/css">
img.prodImg{
	width: 350px;
	height: 350px;
	/* display: inline-block; */
	margin-left: 10px;	
	border: 1px solid #eee9dd;
}
div#product{
	text-align: center;
	/* margin-bottom: 30px; */
}
a{
	color: black;
}
.detailbody{
	margin-left: 50px;
}
#name{
	margin-top: 5px;
	margin-bottom: 40px;
}
a.pagebar{
	display: inline-block;
	margin-bottom: 10px;
	color: black;
	
}
div#pagebar{
	text-align: center;
}
#specName{
	padding: 5px;
	text-align: center;
	background-color: #eee9dd;	
	color: #666666;  
	font-style: bold;
}
hr{
	border: 5px solid #eee9dd;	
}
div#specNamecss{
	margin-bottom: 80px;
}
</style>
</head>
<body>
<%-- <div>${requestScope.newHitList.spvo} item</div> --%>

<div id="specNamecss">
	<c:if test="${fk_snum == 1}">
		<hr>
		<h2 id="specName"> - Hit item - </h2>
		<hr>
	</c:if>
	<c:if test="${fk_snum == 2}">
		<hr>
		<h2 id="specName"> - New item - </h2>
		<hr>
	</c:if>
</div>
<!-- 전체 세부카테고리 보이기 -->

<!-- 전체 카테고리의 HIT 상품 보여주기 -->
<div id="product">
 <c:set var="i" value="0" />
	<c:set var="j" value="4" />
	<table class="detailbody">
	  <c:forEach var="pvo" items="${requestScope.newHitList}" varStatus="status">
	    <c:if test="${i%j == 0}">
	    <tr>
	    </c:if>
	      <td style="position: relative;">
			<a href="<%=ctxPath%>/detailMenu/productDetailPage.up?pnum=${pvo.pnum}">
				<img src="<%=ctxPath%>/image/product/${pvo.fk_decode}/${pvo.pimage1}" class="prodImg" "/>
				<div id="name">
				<a href="<%=ctxPath%>/detailMenu/productDetailPage.up?pnum=${pvo.pnum}">	
				<span>${pvo.pname}</span><br>
				<c:if test="${fk_snum == 2}">
					<span style="text-decoration:line-through; text-decoration-color: red;"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원&nbsp;&nbsp;</span>
					<br>
					<span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span>
				</c:if>	
				<c:if test="${fk_snum == 1}">			
					<span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span>
				</c:if>
				</a>
				</div>
			</a>			
		  </td>
	    <c:if test="${i%j == j-1}">
	    </tr>
	    </c:if>
	    <c:set var="i" value="${i+1}" />
	  </c:forEach>
	</table>
</div> 	

<jsp:include page="../footer.jsp"/>  