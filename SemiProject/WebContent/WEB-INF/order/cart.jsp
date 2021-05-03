<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    
%>   

<jsp:include page="../header4.jsp" /> 


<style type="text/css">

div.container{
	margin: 0 50px;
}

 div#cart_content {
   /* border: solid 1px red; */
   display: inline-block;
   float: left;
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

img.cart_image {
    width: 200px;
    height: 240px;
}


tr.odr_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

tr.odr_total_price > td {
	text-align: right;
}

img#delete_cart{
	cursor: pointer;
}

 th#cart_th_3{
 	font-size:15pt; 
 	text-align:center;
 	width: 350px; 
 	padding-bottom: 30px;
 }


div#cart_side{
	float: left;
	display: inline-block;
	width: 350px; 
	left: 70%;
	position: fixed;
	/* box-shadow: 0 4px 4px gray;
	background-color: #f2f2f2;
	padding: 15px; */
	/* border: solid 1px red; */
}


 tr.side_cart {
 	width: 100%; 
	height: 20px;
	/* line-height:40px; */
	

 }
 tr.side_cart > td:nth-child(2){
 	text-align:right;
 }
 tr#total_price_in_cart > td{
 	font-size:12pt;
 	font-weight: bold;
 	padding-bottom: 30px;
 }
 tr#discount_price_in_cart > td{
 	font-weight: bold;
 	color: red;
 
 }
 tr#side_cart_totalPrice > td{
 	vertical-align: middle !important;
 	font-size:14pt;
 	font-weight: bold;
 	padding-top: 20px;
 	
 }

  tr#side_hr > td{
  	padding-bottom:10px;
 	border-bottom: solid 1px #ddd !important;
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
 	font-size:10pt;
 	padding:5px;
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

 td#td_plusminus> img{
	width:15px;
	height:15px;
	cursor: pointer;
 	
 }
 span#productName_cart{
 	font-weight: bold;
 	font-size: 12pt;
 }

/*   ------checkbox 디자인 변경-------- */
/* 
input[type="checkbox"] {
    display:none;
} 

input[type="checkbox"] + span#check {
    display: inline-block;
    width: 24px;
    height: 24px;
    margin: -2px 10px 0 0;
    vertical-align: middle;
    background: url("image/cart/checkbox.svg") left top no-repeat;
    cursor: pointer;
    background-size: cover;

}


input[type="checkbox"]:checked + span#check {

    background-img:url("image/cart/checkbox.svg") -26px top no-repeat;
    background-size: cover;

}
 */
 
 /*--------------------*/
/* button#btnDelete {

    width:100px;
    background-color: #f8585b;
    border: none;
    color:#fff;
    padding: 15px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin: 10px;
    cursor: pointer;
    border-radius:10px;

} */

button{
	width:120px;
	height: 30px;
	color: #f8585b;
	background: #fff;
	font-size: 10pt;
	border: solid 1px #f8585b;
	border-radius: 20px;
	transition:0.3s;
	position: absolute;
	left:63%;
	top: 20%;
	transform: translate(-50%,-50%);
}
button:focus {
	outline:0;
}
button:hover{
	background: #f8585b;
	cursor: pointer;
	color: #fff;
	box-shadow: 0 2px 4px #f8585b;
}
</style>

<script type="text/javascript" src="<%= ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	
	//== 체크박스 전체선택/전체해제 == //
	$("input:checkbox[name=checkall]").click(function(){
		var bool = $(this).prop("checked");
		// 체크되어있으면 true, 해제되어있으면 false
		
		$("input:checkbox[name=product]").prop("checked", bool);
		// product 의 체크박스 상태를 checkall 의 체크상태와 동일하게 적용
	});

	// == 상품의 체크박스 클릭시 == //
	$("input:checkbox[name=product]").click(function(){
		var bool = $(this).prop("checked");
		
		if (bool) { // 현재 상품의 체크박스에 체크했을 때
			var bFlag = false;
			
			$("input:checkbox[name=product]").each(function(index, item){ // 다른 모든 상품의 체크박스 상태 확인
				var bChecked = $(item).prop("checked");
				if (!bChecked) {	// 체크표시가 안되어있는 상품일 경우 반복문 종료
					bFlag = true;
					return false;
				}
			});
			
			if(!bFlag) {	// 모든 체크박스가 체크되어있을 경우
				$("input:checkbox[name=checkall]").prop("checked", true);			
			}
		}
		else {	// 현재 상품의 체크박스에 체크 해제했을 때
			$("input:checkbox[name=checkall]").prop("checked", false);
		}
	});
	
	
	
	/* 
	//== 장바구니 물건 삭제하기 ==//
	$("img#delete_cart").click(function(){
		

		
	}); */
	
	//== 장바구니 물건 전체 삭제하기 ==//
    $("#btnDelete").click(function(){
        if(confirm("장바구니를 비우시겠습니까?")){
            location.href="<%= ctxPath %>/order/cart_deleteAll.up";
        }
    });
	
});

// function declation

	function count_plus() {
		
		var n = Number($("input#count").val());
		
		 if(n>100){
			alert("주문가능한 수량을 초과하였습니다.");
			return;
		}
		else{
			$("input#count").val(n + 1);
		}
		
		
	}
	
	function count_minus() {
		
		var n = Number($("input#count").val());
		
		if(n == 1){
			alert("최소수량은 1개 이상입니다.");
		}
		else{
			$("input#count").val(n - 1);
		}
		
		
	}



</script>


<div class="container">

 <h2 style="width: 80%; margin-top: 100px; margin-bottom: 50px; color: gray;">- Cart</h2>

<div id="cart_content">
	<button type="button" id="btnDelete">장바구니 비우기</button>
	<form name='form'>  
	<table class="table odr_list table-hover">
	  
	  	<thead>
			<tr>
				<th><input type="checkbox" name="checkall"/><span id="check"></span></th>
				<th>이미지</th>
				<th>상품정보(option)</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립금</th>
				<th>합계</th>
				<th></th>
				
			</tr>
		</thead>
		
		<tbody>
		
			<c:forEach var="var" begin="1" end="8">
				<%-- test value 값 --%>
				<c:set var="product_price" value="10000"/>
				<c:set var="order_cnt" value="1"/>
				
				<tr class="odr_tr">
					<td ><input type="checkbox" name="product" id="product${var}"/><span id="check"></span></td>
					<td><label for="product${var}"><img class="cart_image" src="<%=ctxPath%>/image/cart/sample_cart${var}.jpg" ></label></td>
					<td><span id="productName_cart">XXL 사이즈 린넨커버</span><br>제품번호 <span id="cart_productNumber">4212900825070</span><br><span id="cart_productOption">70 x 90 cm</span></td>
					<td><fmt:formatNumber value="${product_price}" pattern="#,###" /> 원</td>
					<td id="td_plusminus"><img id="minus_cart" src="../image/cart/minus.png" onclick="count_minus()"/>&nbsp;<input class="count" type='text' name='count' value='${order_cnt}' size='1' readonly />&nbsp;<img id="Plus_cart" onclick="count_plus()" src="../image/cart/plus.png" /></td>
					<td><fmt:formatNumber value="${product_price*0.01}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${product_price*order_cnt}" pattern="#,###" /> 원</td>
					<!-- 삭제 버튼을 누르면 delete.do로 장바구니 개별 id (삭제하길원하는 장바구니 id)를 보내서 삭제한다. -->
					<td><a href="<%= ctxPath %>/order/cart_delete.up?cart_id=<%-- ${id} --%>"><img id="delete_cart" src="../image/cart/delete.png" style="width: 10px; height: 10px;"/></a></td> <!-- 변함없을 예정 -->
					

				</tr>
				
				<c:set var="total_price" value="${total_price + product_price * order_cnt}"/>	
			</c:forEach>
		
		</tbody>
		
      </table>
       </form> 
</div>


<div id="cart_side">

	<table>

		<tr>
			<th class="side_cart" id="cart_th_3" colspan="2" >주문요약<br>(<span id="count_product_cart"></span>제품)</th>
		</tr>

		<tr class="side_cart" id="total_price_in_cart">
            <td>총 제품 : </td>
            <td><span><fmt:formatNumber value="${total_price}" pattern="#,###" /></span>원</td>
         </tr>
         <tr class="side_cart" id="discount_price_in_cart">
         	<td > - 상품할인금액 : </td>
         	<td><fmt:formatNumber value="${discount_price}" pattern="#,###" />원</td>
         </tr>
         <tr class="side_cart" id="side_hr">
         	<td > + 배송비 : </td>
         	<td><fmt:formatNumber value="${delivery_price}" pattern="#,###" />원</td>
         </tr>

         <tr class="side_cart" id="side_cart_totalPrice">
            <td>합계 : </td>
            <td><fmt:formatNumber value="${total_price+delivery_price-discount_price}" pattern="#,###" />원</td>
         </tr>

	</table>
	<br><br>
	
	<div id="cart_promo">
		POINT를 합산하여 할인된 금액은 <br>
		주문페이지에서 확인 가능합니다.
	</div>
	<br>

	<div id="order_button_cart" >
		주문하기
	</div>
</div>

</div>



<jsp:include page="../footer.jsp" />  

