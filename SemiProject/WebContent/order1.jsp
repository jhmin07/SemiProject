<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%	String ctxPath = request.getContextPath(); %>  


<jsp:include page="header4.jsp" />

<style type="text/css">

.container {
	/* margin: 100px 100px !important; */
	border: solid 1px blue;
	width: 80%;
}

div.odr_container {
	padding-top: 100px;
}

table.ord_list, table.odr_info {
	border-bottom: solid 1px #ddd !important;
	border: solid 1px red;
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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		$("span.error").hide();
		
		// == 체크박스 전체선택/전체해제 == //
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
		
		
		// == 우편번호 찾기 == // 
		$("img#zipcodeSearch").click(function(){
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if (data.userSelectedType === 'R') {
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("extraAddress").value = extraAddr;

					} else {
						document.getElementById("extraAddress").value = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("address").value = addr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("detailAddress").focus();
				}
			}).open();
		});
	});


	
</script>

<div class="container odr_container">
	<h2 style="width: 80%; margin-bottom: 50px; color: gray;">- Order</h2>
	
	<table class="table ord_list">
		<thead>
			<tr>
				<th><input type="checkbox" name="checkall"/></th>
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
					<td><input type="checkbox" name="product" /></td>
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
						<input type="text" name="email1" id="email1" class="requiredInfo"/>@
						<input type="text" name="email2" id="email2" class="requiredInfo"/>
						<select id="emailSelect" style="padding: 8px 10px; border: solid 1px #ddd;">
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
						<input type="radio" value="1" name="reveiceRadio" id="orderlist_same" />
						<label for="same">주문자 정보와 동일</label>&nbsp;
						<input type="radio" value="0" name="reveiceRadio" id="orderlist_new" checked/>
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