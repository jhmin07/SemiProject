<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  --%>

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC 
%>   

<jsp:include page="header4.jsp" /> 



<style type="text/css">

/* div.cart_container{
	padding-top: 100px;
	
	border: solid 1px red;
	
} */
div.container{

	margin: 0 50px;
}

div.odr_container {
	padding-top: 100px;
}

table.table{
	width: 1000px;
}

table.odr_list, table.odr_info {
	border-bottom: solid 1px #ddd !important;
	/* border: solid 1px red; */
}

table.odr_list > thead {
	background-color: #f2f2f2;
}

img.odr_img {
	width: 100px;
	height: 100px;
}

img#zipcodeSearch1, img#zipcodeSearch2 {
	width: 95px;
	height: 30px;
}

tr.odr_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

tr.odr_total_price > td {
	text-align: right;
}

table.odr_info tr {
	height: 50px;
}

table.odr_info > tbody td:nth-child(1){
	width: 20%; 
	font-weight: bold;
	background-color: #f2f2f2;
}

table.odr_info td:nth-child(2){
	/* width: 80%; */
	text-align: left;
}

table.odr_info input[type=text]{
	padding: 10px 15px;
	margin: 4px 0;
	box-sizing: border-box;
	border: none;
	background-color: #f2f2f2;
}

.star{
	color: red;
}

 th#cart_th_3{
 	font-size:14pt; 
 	text-align:center;
 	width: 350px; 
 }


div#cart_side{
	margin-top: 0;
	display: inline-block;
	position: fixed;
	width: 350px; 
	left: 70%;
    
}

 tr.side_cart {
 	width: 100%; 
	height: 100px;
	line-height:60px;

 }
 tr#side_cart_totalPrice{
 	vertical-align: middle !important;
 	font-size:14pt;
 	font-weight: bold;
 }
  tr#side_cart_totalProduct{
 	border-bottom: solid 1px #5D5D5D;
 	width: 350px; 
 }
 div#order_button_cart{
 	line-height:40px;
 	background-color:black; 
 	color:white; 
 	text-align:center;
 	height: 40px;
 	weight:100%;
 	
 }

 div#cart_promo{
 	background-color:#FCF8E3; 
 	color:#A38C60; 
 	text-align:center; 
 	height: 80px; 
 	line-height:80px; 
 	font-size:9pt;
 }
 td#cart_productNumber{
	font-size:11pt;
	color:#3A464D;
	padding-top:20px;
 }
 td#productPrice_cart{
	font-weight: bold; 
	text-align:right;
	padding-top:20px;
 }
 td#td_plusminus{
 	text-align:right;
 	padding-top:20px;
 }
 
 td#td_plusminus>img{
	width:15px;
	height:15px;
 	
 }

  

</style>




<div class="container">
 <h2 style="width: 80%; margin-bottom: 50px; color: gray;">- Cart</h2>
  <br>

<div id="cart_content">
	  
	<table class="table odr_list">
	  
	  	<thead>
			<tr>
				<th><input type="checkbox" name="checkall"/></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립금</th>
				<th>합계</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="var" begin="1" end="2">
				<%-- test value 값 --%>
				<c:set var="product_price" value="10000"/>
				<c:set var="order_cnt" value="1"/>
				
				<tr class="odr_tr">
					<td><input type="checkbox" name="product" id="product${var}"/></td>
					<td><img class="odr_img" src="<%=ctxPath%>/image/cart/table0${var}.jpg" ></td>
					<td>책상</td>
					<td><fmt:formatNumber value="${product_price}" pattern="#,###" /> 원</td>
					<td><fmt:formatNumber value="${order_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${product_price*0.01}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${product_price*order_cnt}" pattern="#,###" /> 원</td>
				</tr>
				
				<c:set var="total_price" value="${total_price + product_price * order_cnt}"/>	
			</c:forEach>
			
			<tr class="odr_total_price">
				<td colspan="9">
					[기본배송] 상품구매금액 <span><fmt:formatNumber value="${total_price}" pattern="#,###" /></span>
					<c:if test="${total_price >= 30000}"><c:set var="delivery_price" value="0"/></c:if>
					+ 배송비 <span><fmt:formatNumber value="${delivery_price}" pattern="#,###" /></span>
					- 상품할인금액 <span><fmt:formatNumber value="${sail_price}" pattern="#,###" /></span>
					= 합계 : <span style="font-size: 15pt; font-weight: bold;"><fmt:formatNumber value="${total_price+delivery_price-sail_price}" pattern="#,###" /></span>원
				</td>
			</tr>
		</tbody>

         </table>
         
 
         
         
</div>
</div>


<div id="cart_side">

	<table>

		<tr>
			<th class="side_cart" id="cart_th_3" colspan="2" >주문요약<br>(<span id="count_product_cart">2</span>제품)</th>
		</tr>

		<tr class="side_cart" id="side_cart_totalProduct">
            <td >총 제품 : </td>
            <td  style="text-align:right;"><span id="total_price_in_cart">66,000</span>원</td>
         </tr>

         <tr class="side_cart" id="side_cart_totalPrice">
            <td>합계 : </td>
            <td style="text-align:right;"><span id="total_price_in_cart">66,000</span>원</td>
         </tr>

	</table>
	
	<div id="cart_promo">
		프로모션 코드가 있으신가요? 나중에 결제페이지에서 입력하십시오
	</div>
	<br>

	<div id="order_button_cart" >
		주문하기
	</div>
</div>

<%-- <jsp:include page="footer.jsp" />  --%>