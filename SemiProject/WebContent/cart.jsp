<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  --%>

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC 
%>   

<jsp:include page="header4.jsp" /> 



<style type="text/css">

div#cart_title{

	font-size: 20px;
	font-weight: bold;
	text-align: left;
	width: 830pt;
	padding-top: 100px;
 	padding-left:80px;
}

table {
	
  	text-align: left;
  	width:100%;
    border-collapse: collapse;
 }

td#td_count>img{
	width:15px;
	height:15px;
}
   

th#cart_product_image > img{
 	width: 240px;
 	height: 280px;
 }
 
 th#cart_th_1{
	vertical-align : bottom; 
	height:30pt; 
	font-size:13pt; 
	width: 60%;
 	border-bottom: solid 1px #D1D1D1;
 }
 th#cart_th_2{
 	text-align:right; 
 	width: 150px; 
 	width: 60%;
 	border-bottom: solid 1px #D1D1D1;
 }
 th#cart_th_3{
 	font-size:14pt; 
 	text-align:center;
 }
 
 div#cart_content {
	/* border: solid 1px red; */
	margin-left: 55px;
	width: 60%;
	height:2000px; 
	position: absolute;
	
 }

div#cart_side_order{

	position:fixed; 
	width:23%; 
	height:100%; 
	left: 75%;
    
}

 tr.side_cart {
	 height: 100px;
	 line-height:60px;

 }
 tr#side_cart_totalPrice{
 	vertical-align : middle;
 	font-size:14pt;
 	font-weight: bold;
 }
  tr#side_cart_totalProduct{
 	border-bottom: solid 1px #5D5D5D;
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
  <div id="cart_title" > - 장바구니 (<span id="count_product_cart">2</span>)</div>
  <br>

<div id="cart_content">
	  <table class="table table-hover">

         <tr>
            <th rowspan="2" id="cart_product_image"><img src="image/cart/sample_cart.jpg" /></th>
            <th  id="cart_th_1"colspan="3"><span id="productName_cart">XXL 사이즈 린넨커버</span></th>
            <th  id="cart_th_2"><img src="image/cart/delete.png" style="width: 10px; height: 10px;"/></th> <!-- 변함없을 예정 -->
         </tr>

         <tr id="tbody_cart">
            <td id="cart_productNumber" >제품번호 <span id="cart_productNumber">4212900825070</span><br><span id="cart_productOption">70 x 90 cm</span></td>
            <td id="productPrice_cart"><span id="productPrice_cart">20,000</span>원</td>
            <td id="td_plusminus"><img id="minus_cart" src="image/cart/minus.png" />&nbsp;<span id="count_cart" style="padding:4px;">1</span>&nbsp;<img id="Plus_cart" src="image/cart/plus.png" /></td>
            <td id="productPrice_cart"><span id="totalPrice_cart">40,000</span>원</td>
         </tr>
            

         </table>
         <br><br>
 
         
         
</div>
</div>


<div id="cart_side_order">

	<table>

		<tr>
			<th id="cart_th_3" colspan="2" >주문요약<br>(<span id="count_product_cart">2</span>제품)</th>
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

<jsp:include page="footer.jsp" /> 