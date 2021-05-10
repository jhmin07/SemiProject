<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctxPath = request.getContextPath();
%>     

<style type="text/css">
/* 쇼핑몰 구매 동의 css */
table.payAgree_table td:nth-child(1) {
	width: 30%; 
}	

table.payAgree_table th {
	background-color: #f2f2f2;
}

table.payAgree_table td {
	background-color: #fff;
	border-bottom: solid 1px #f2f2f2;
}

/* 결제예정금액 css */
table.payment_table tr {
	height: 50px;
}

table.payment_table td,
table.payment_table th {
	border: none !important;
}

table.payment_table tbody > tr:nth-child(1) {
	font-size: 17px;
} 

tr.payment_thead > th {
	text-align: center;
	background-color: #f2f2f2;
}

tr.payment_thead_result > td {
	text-align: center;
	background-color: white !important;
}

tr.payment_tbody > td {
	border: none;
	text-align: right;
}

tr.payment_tbody td:nth-child(1) {
	width: 30%; 
	font-weight: bold;
	background-color: #f2f2f2;
	text-align: center;
}

button#paymentGo{
	width: 100%;
	height: 50px;
	background-color: #cc6666;
	color: white;
	text-align: center;
	border: none;
	font-size: 17;
}

button.payment_button{
	border: solid 1px black;
	background-color:white;
	font-size: 15;
}

ul.payment_last {
	text-align: right;
	list-style-type: none;
	background-color: #f2f2f2;
	padding: 10px 10px;
	width: 600px;
}

ul.payment_last > li {
	margin: 10px 10px;
}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		setAddPrice();
		
		<%-- 쇼핑몰 모두 동의 --%>
		// == 쇼핑몰 동의 체크박스 전체선택/전체해제 == //
		$("input:checkbox[name=shoppingAllAgree]").click(function(){
			var bool = $(this).prop("checked");
			// 체크되어있으면 true, 해제되어있으면 false
			
			$("input:checkbox[name=shoppingAgree]").prop("checked", bool);
			// product 의 체크박스 상태를 checkall 의 체크상태와 동일하게 적용
		});
		
		// == 쇼핑몰 동의 체크박스 클릭시 == //
		$("input:checkbox[name=shoppingAgree]").click(function(){
			var bool = $(this).prop("checked");
			
			if (bool) { // 현재 체크박스에 체크했을 때
				var bFlag = false;
				
				$("input:checkbox[name=shoppingAgree]").each(function(index, item){ // 다른 모든 상품의 체크박스 상태 확인
					var bChecked = $(item).prop("checked");
					if (!bChecked) {	// 체크표시가 안되어있는 체크박스 경우 반복문 종료
						bFlag = true;
						return false;
					}
				});
				
				if(!bFlag) {	// 모든 체크박스가 체크되어있을 경우
					$("input:checkbox[name=shoppingAllAgree]").prop("checked", true);			
				}
			}
			else {	// 현재 상품의 체크박스에 체크 해제했을 때
				$("input:checkbox[name=shoppingAllAgree]").prop("checked", false);
			}
		});
		
	});

	// == Function Declaration == //
	function payAgreeCheck() {
		var payCheckLen = $("input:checkbox[class=payAgreeAll]:checked").length
		// console.log(payCheckLen);
		
		if (payCheckLen == 3)
			return true;
		else 
			return false;
	}
	
	function usePoint() {
		var url = "<%=request.getContextPath()%>/order/usingMyPoint.up";
		window.open(url, "usingMyPoint", 
					"left=100px, top=100px, width=555px, height=355px");
	}
	
	function setPoint(pt) {
		pt = Number(pt).toLocaleString('en');
		$("span#point").html(pt);
		
		setAddPrice();
	}
	
	function setAddPrice() {
		var sum = 0;
		var $addPrice = $("span.addPrice");
		
		sum -= Number($($addPrice[0]).html().split(",").join(""));
		sum -= Number($($addPrice[1]).html().split(",").join(""));
		sum += Number($($addPrice[2]).html().split(",").join(""));
		
		sum = Number(sum).toLocaleString('en');
		
		$("span#addPriceResult").html(sum);
		getSumtotalPriceLast();
	}
	
	function getSumtotalPriceLast() {
		var sumtotalPrice = ${requestScope.sumtotalPrice + sumSalePrice};
		var addPrice = Number($("span#addPriceResult").html().split(",").join(""));
		console.log(addPrice);
		
		var sumtotalPriceLast = sumtotalPrice + addPrice;
		sumtotalPriceLast = Number(sumtotalPriceLast).toLocaleString('en');
		
		$("span.sumtotalPriceLast").html(sumtotalPriceLast);
		
		console.log(sumtotalPriceLast);
	}
	

</script>


	<%-- 쇼핑몰 구매 이용약관 --%>
	<br><hr color="#a6a6a6;"><br>
	<table class="table payAgree_table">
		<thead style="background-color: #f2f2f2;">
			<tr>
				<th colspan="2">
					<input type="checkbox" id="shoppingAllAgree" name="shoppingAllAgree"/>
					<label for="shoppingAllAgree">쇼핑몰 이용약관 상품 구매시 개인정보수집이용 동의에 모두 동의합니다.</label>
				</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td>쇼핑몰 이용약관</td>
				<td>
					<iframe src="<%=ctxPath%>/iframeAgree/agree.html" width="100%" height="150px" class="box" style="border: solid 1px #ccc;"></iframe>
					<input type="checkbox" id="shoppingAgree1" name="shoppingAgree"  class="payAgreeAll"/>
					<label for="shoppingAgree1">&nbsp;동의</label>
				</td>
			</tr>
			<tr>
				<td>상품 구매시 개인정보 수집이용동의</td>
				<td>
					<iframe src="<%=ctxPath%>/iframeAgree/agree.html" width="100%" height="150px" class="box" style="border: solid 1px #ccc;"></iframe>
					<input type="checkbox" id="shoppingAgree2" name="shoppingAgree"  class="payAgreeAll"/>
					<label for="shoppingAgree2">&nbsp;동의</label>
				</td>
			</tr>
		</tbody>
	</table>	
	
	<%-- 결제 예정 금액 --%>
	<h2 style="font-size: 13pt; color: #a6a6a6;">결제 예정 금액</h2>
	<table class="table payment_table">
		<thead>
			<tr class="payment_thead">
				<th>총 주문 금액</th>
				<th></th>
				<th>총 할인 + 부가결제 금액</th>
				<th></th>
				<th>총 결제예정 금액</th>
			</tr>
		</thead>
		
		<c:set var="addsale_price" value="-100"/>
		<tbody>
			<tr class="payment_thead_result">
				<td><fmt:formatNumber value="${sumtotalPrice + sumSalePrice}" pattern="#,###" />원</td>
				<td style="text-align: left; width: 20px;"><span style="font-weight: bold; font-size: 20px;">+</span>
				<td><span id="addPriceResult">0</span>원</td>
				
				<td style="text-align: left;"><span style="font-weight: bold; font-size: 20px;">=</span>		
				<td><span class="sumtotalPriceLast"></span>원</td>
			</tr>
			<tr class="payment_tbody">
				<td>총 할인금액</td>
				<td></td>
				<td><span class="addPrice"><fmt:formatNumber value="${sumSalePrice}" pattern="#,###" /></span>원</td>
			</tr>
			<tr class="payment_tbody">
				<td>추가할인 금액</td>
				<td></td>
				<td><span class="addPrice" id="point">0</span>원</td>
				<td style="text-align: left; width: 90px; padding: 0;"><button class="payment_button" onclick="usePoint();"">포인트 사용</button></td>
			</tr>
			<tr class="payment_tbody">
				<td>배송비</td>
				<td></td>
				<td><span class="addPrice"><fmt:formatNumber value="${deliveryPrice}" pattern="#,###" /></span>원</td>
			</tr>
		</tbody>
	</table>
	
	<%-- 최종 결제 예정 금액 --%>
	<div align="right">
		<ul class="payment_last">
			<li style="font-size: 15px;">최종결제 금액</li>
			<li style="font-size: 22px; font-weight: bold;"><span class="sumtotalPriceLast" id="sumtotalPriceLast"></span>원</li>
			<li>
				<input type="checkbox" id="paymentagree"  class="payAgreeAll" />
				<label for="paymentagree" >&nbsp;결제정보를 확인하였으며, 구매진행에 동의합니다.</label>
			</li>
			<li><button id="paymentGo" onclick="paymentGoFunc()">결제하기</button></li>
		</ul>
	</div>
	
