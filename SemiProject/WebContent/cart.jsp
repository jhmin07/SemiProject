<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC 
%>   

<jsp:include page="header4.jsp" /> 



<style type="text/css">

div.cart_container{
	margin: 50px 100px;
}
div#cart_title{
	font-size: 20px;
	font-weight: bold;
	text-align: left;
	width: 830pt
}
table {
	
  	text-align: left;
  	width:100%;
    border-collapse: collapse;
 }
td{
	vertical-align : top;
}

td#td_count>img{
	width:15px;
	height:15px;
}
   

 
th#cart_product_image > img{
 	width: 240px;
 	height: 280px;
 }
 
 th.content_tr_cart{
 	width: 60%;
 	border-bottom: solid 1px #D1D1D1;
 }

div#cart_side_order{

	position:fixed; 
	width:23%; 
	height:100%; 
	left: 75%;
    
}

div#cart_content {
	/* border: solid 1px red; */
	margin-left: 55px;
	width: 60%;
	height:2000px; 
	position: absolute;
	
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
 tr#tbody_cart > td{
 	padding-top:20px;
 }
 div#cart_title{
 	
 	font-size:14pt; 
 	padding-top: 80px;
 	padding-left:80px;
 }
  

</style>




<div class="cart_container">
  <div id="cart_title" >장바구니 (<span id="count_product_cart">2</span>)</div>
  <hr style="border: solid 1.5px #101010;  width: 830pt; background-color: black;" align="left">
  <br>

<div id="cart_content">
	  <table class="table table-hover">

         <tr>
            <th rowspan="2" id="cart_product_image"><img src="image/cart/sample_cart.jpg" /></th>
            <th  class="content_tr_cart" colspan="3" style="vertical-align : bottom; height:30pt; font-size:13pt; "><span id="productName_cart">XXL 사이즈 린넨커버</span></th>
            <th class="content_tr_cart" style="text-align:right; width: 150px; "><img src="image/cart/delete.png" style="width: 10px; height: 10px;"/></th>
         </tr>

         <tr id="tbody_cart">
            <td style="font-size:10.5pt; color:#3A464D;">제품번호 <span id="productNumber_cart">4212900825070</span><br><span id="productOption_cart">70 x 90 cm</span></td>
            <td style="font-weight: bold; text-align:right;"><span id="productPrice_cart">20,000</span>원</td>
            <td id="td_count" style="text-align:right;"><img id="minus_cart" src="image/cart/minus.png" />&nbsp;<span id="count_cart" style="padding:4px;">1</span>&nbsp;<img id="Plus_cart" src="image/cart/plus.png" /></td>
            <td style="text-align:right; font-weight: bold;  "><span id="totalPrice_cart">40,000</span>원</td>
         </tr>
            

         </table>
         <br><br>
         <table class="table table-hover">

         <tr>
            <th rowspan="2" id="cart_product_image"><img src="image/cart/sample_cart.jpg" /></th>
            <th  class="content_tr_cart" colspan="3" style="vertical-align : bottom; height:30pt; font-size:13pt; "><span id="productName_cart">XXL 사이즈 린넨커버</span></th>
            <th class="content_tr_cart" style="text-align:right; width: 150px; "><img src="image/cart/delete.png" style="width: 10px; height: 10px;"/></th>
         </tr>

         <tr id="tbody_cart">
            <td style="font-size:10.5pt; color:#3A464D;">제품번호 <span id="productNumber_cart">4212900825070</span><br><span id="productOption_cart">70 x 90 cm</span></td>
            <td style="font-weight: bold; text-align:right;"><span id="productPrice_cart">20,000</span>원</td>
            <td id="td_count" style="text-align:right;"><img id="minus_cart" src="image/cart/minus.png" />&nbsp;<span id="count_cart" style="padding:4px;">1</span>&nbsp;<img id="Plus_cart" src="image/cart/plus.png" /></td>
            <td style="text-align:right; font-weight: bold;  "><span id="totalPrice_cart">40,000</span>원</td>
         </tr>
            

         </table>
         <br><br>
         <table class="table table-hover">

         <tr>
            <th rowspan="2" id="cart_product_image"><img src="image/cart/sample_cart.jpg" /></th>
            <th  class="content_tr_cart" colspan="3" style="vertical-align : bottom; height:30pt; font-size:13pt; "><span id="productName_cart">XXL 사이즈 린넨커버</span></th>
            <th class="content_tr_cart" style="text-align:right; width: 150px; "><img src="image/cart/delete.png" style="width: 10px; height: 10px;"/></th>
         </tr>

         <tr id="tbody_cart">
            <td style="font-size:10.5pt; color:#3A464D;">제품번호 <span id="productNumber_cart">4212900825070</span><br><span id="productOption_cart">70 x 90 cm</span></td>
            <td style="font-weight: bold; text-align:right;"><span id="productPrice_cart">20,000</span>원</td>
            <td id="td_count" style="text-align:right;"><img id="minus_cart" src="image/cart/minus.png" />&nbsp;<span id="count_cart" style="padding:4px;">1</span>&nbsp;<img id="Plus_cart" src="image/cart/plus.png" /></td>
            <td style="text-align:right; font-weight: bold;  "><span id="totalPrice_cart">40,000</span>원</td>
         </tr>
            

         </table>
         <br><br>
         
         
         
         
</div>
</div>


<div id="cart_side_order">

	<table>

		<tr>
			<th colspan="2" style="font-size:14pt; text-align:center;">주문요약<br>(<span id="count_product_cart">2</span>제품)</th>
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
	
	<div style="background-color:#FCF8E3; color:#A38C60; text-align:center; height: 80px; line-height:80px; font-size:9pt;">
		프로모션 코드가 있으신가요? 나중에 결제페이지에서 입력하십시오
	</div>
	<br>

	<div id="order_button_cart" >
		주문하기
	</div>
</div>

<jsp:include page="footer.jsp" /> 