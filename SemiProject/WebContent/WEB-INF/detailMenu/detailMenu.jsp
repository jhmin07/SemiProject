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
</style>
</head>
<body>

<!-- <h5 style="text-align: center; border: solid 1px gray;">이불커버 메뉴 클릭</h5> -->
  <%-- === 특정 카테고리에 속하는 제품들을 일반적인 페이징 처리하여 조회(select)해온 결과 === --%>
<div id="product">
 <c:set var="i" value="0" />
	<c:set var="j" value="4" />
	<table class="detailbody">
	  <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
	    <c:if test="${i%j == 0}">
	    <tr>
	    </c:if>
	      <td style="position: relative;">
			<a href="<%=ctxPath%>/detailMenu/productDetailPage.up?pnum=${pvo.pnum}">
				<img src="<%=ctxPath%>/image/product/${pvo.fk_decode}/${pvo.pimage1}" class="prodImg" "/>
				<div id="name">
				<a href="<%=ctxPath%>/detailMenu/productDetailPage.up?pnum=${pvo.pnum}">
				<c:if test="${pvo.spvo.snum == 2}">
					<span style="color: red; font-size: 8px;">${pvo.spvo.sname}&nbsp;</span>
				</c:if>	
				<span>${pvo.pname}</span><br>	
				<c:if test="${pvo.spvo.snum == 2}">
					<span style="text-decoration:line-through; text-decoration-color: red;"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원&nbsp;&nbsp;</span>
					
					<span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span>
				</c:if>	
				<c:if test="${pvo.spvo.snum == 1 || pvo.spvo.snum == 3 || pvo.spvo.snum == 4}">			
					<span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span>
					<br>
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
		
	 <c:if test="${empty requestScope.productList}"> 
    	제품진열 준비중입니다.
   	 </c:if> 
   	  <c:if test="${not empty requestScope.productList}"> 
    	<div id="pagebar">${requestScope.pageBar}</div>
    	<br>
   	 </c:if> 
   	 
   </div>	
</div> 	
<%-- <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
	<div class="product" >
		<ul style='list-style-type: none; border: solid 0px red; padding :0px; width :200px;'> 
		<li><a href="#" ><img src="<%=ctxPath%>/image/product/${pvo.fk_decode}/${pvo.pimage1}" class="prodImg" "/></a></li>
		<li>
		<div class="name">
			<a href="#">	
				<span>${pvo.pname}</span>
			</a>
			<span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span>
		</div>
		</li>
		</ul>
	</div>
</c:forEach>
		
		  
	<div>${requestScope.pageBar}</div>
	 <c:if test="${empty requestScope.productList}"> 
    	제품진열 준비중입니다.
   	 </c:if> 
   </div>	
</div> 	 --%>
   <%-- <div>
   <c:if test="${not empty requestScope.productList}">
      
      <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
         <div class='moreProdInfo'>
            <ul style='list-style-type: none; border: solid 0px red; padding :0px; width :200px;'> 
                 <li style='border: solid 0px red; padding-bottom: 10px;'><a href='/MyMVC/shop/prodView.up?pnum=${pvo.pnum}'><img width='300px;' height='350px' src='<%=ctxPath%>/image/${pvo.pimage1}'/></a></li> 
                 <li><label class='prodInfo'></label>${pvo.pname}</li> 
                 <li><label class='prodInfo'></label><span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></li> 

              </ul>
           </div>
           <c:if test="${status.count%5 == 0}">
           <br>
           </c:if>
        </c:forEach>
        
        <div>${requestScope.pageBar}</div>
   </c:if>    
   
   <c:if test="${empty requestScope.productList}"> 
    	제품진열 준비중입니다.
   </c:if> 	
   </div> --%>

<jsp:include page="../footer.jsp"/>  