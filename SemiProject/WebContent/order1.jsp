<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%	String ctxPath = request.getContextPath(); %>  


<jsp:include page="header4.jsp" />

<style type="text/css">
div.odr_container {
	padding-top: 100px;
}

table.ord_list, table.odr_info {
	border-bottom: solid 1px #ddd !important;
}

table.ord_list > thead {
	background-color: #f2f2f2;
}

img.ord_img {
	width: 100px;
	height: 100px;
}

img#zipcodeSearch {
	width: 95px;
	height: 30px;
}

tr.ord_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

tr.ord_total_price > td {
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
	width: 80%; 
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
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("span.error").hide();
		

	});
	
</script>

<div class="container odr_container">
	<h2 style="width: 80%; margin-bottom: 50px; color: gray;">- Order</h2>
	
	<table class="table ord_list">
		<thead>
			<tr>
				<th><input type="checkbox" /></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립금</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>합계</th>
			</tr>
		</thead>
		
		<tbody>
			<c:set var="total_price" value="0"/>
			<c:set var="sail_price" value="0"/>
			<c:set var="delivery_price" value="3000"/>
			
			<c:forEach var="var" begin="1" end="2">
				<%-- test value 값 --%>
				<c:set var="product_price" value="10000"/>
				<c:set var="order_cnt" value="1"/>
				
				<tr class="ord_tr">
					<td><input type="checkbox" /></td>
					<td><img class="ord_img" src="<%=ctxPath%>/imagesContents2/table0${var}.jpg" ></td>
					<td>책상</td>
					<td><fmt:formatNumber value="${product_price}" pattern="#,###" /> 원</td>
					<td><fmt:formatNumber value="${order_cnt}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${product_price*0.01}" pattern="#,###" /></td>
					<td>기본배송</td>
					<td>[조건]</td>
					<td><fmt:formatNumber value="${product_price*order_cnt}" pattern="#,###" /> 원</td>
				</tr>
				
				<c:set var="total_price" value="${total_price + product_price * order_cnt}"/>	
			</c:forEach>
			
			<tr class="ord_total_price">
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
	
	<!-- <h4 style="width: 80%; margin-bottom: 50px; color: gray;"><br>주문정보</h4> -->
	
	<form action="">
		<table class="table odr_info">
			<thead>
				<tr>
					<td>주문 정보</td>
					<td style="text-align: right; vertical-align: bottom;"><span class="star">*</span>필수입력사항</td>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>주문하시는 분&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" name="name" id="name" class="requiredInfo" /> 
						<span class="error">성명은 필수입력 사항입니다.</span>
					</td>
				</tr>
				<tr>
					<td>주소&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
						<%-- 우편번호 찾기 --%> 
						<img id="zipcodeSearch" src="<%=ctxPath%>/image/우편번호찾기.png" style="vertical-align: middle;" /><br />
						<span class="error">우편번호 형식이 아닙니다.</span>
						<input type="text" id="address" name="address" size="40" placeholder="주소" /><br /> 
						<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;
						<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
						<span class="error">주소를 입력하세요</span>
					</td>
				</tr>
				<tr>
					<td>휴대전화&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
						<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
						<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
						<span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
				</tr>
				<tr>
					<td>이메일&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" name="email1" id="email" class="requiredInfo"/>@
						<input type="text" name="email2" id="email" class="requiredInfo"/>
						<select style="padding: 8px 10px; border: solid 1px #ddd;">
							<option value="">직접입력</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.com">daum.com</option>
							<option value="hanmail.com">hanmail.com</option>
						</select> 
						<ul>
							<li>이메일을 통해 주문처리과정을 보내드립니다.</li>
							<li>이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해주세요.</li>
						</ul>
						<span class="error">이메일 형식에 맞지 않습니다.</span> 
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="table odr_info">
			<thead>
				<tr>
					<td>배송 정보</td>
					<td style="text-align: right; vertical-align: bottom;"><span class="star">*</span>필수입력사항</td>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>배송지 선택</td>
					<td>
						<input type="radio" value="1" name="reveiceRadio" id="same" />
						<label for="same">주문자 정보와 동일</label>&nbsp;
						<input type="radio" value="0" name="reveiceRadio" id="new" checked/>
						<label for="new">새로운 배송지</label>
					</td>
				</tr>
				<tr>
					<td>받으시는 분&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" name="name" id="name" class="requiredInfo" /> 
						<span class="error">성명은 필수입력 사항입니다.</span>
					</td>
				</tr>
				<tr>
					<td>주소&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
						<%-- 우편번호 찾기 --%> 
						<img id="zipcodeSearch" src="<%=ctxPath%>/image/우편번호찾기.png" style="vertical-align: middle;" /><br />
						<span class="error">우편번호 형식이 아닙니다.</span>
						<input type="text" id="address" name="address" size="40" placeholder="주소" /><br /> 
						<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;
						<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
						<span class="error">주소를 입력하세요</span>
					</td>
				</tr>
				<tr>
					<td>연락처&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
						<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
						<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
						<span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
				</tr>
				<tr>
					<td>배송메시지</td>
					<td>
						<textarea rows="4" cols="100" name="deliveryMsg"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<jsp:include page="footer.jsp" />