<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%	String ctxPath = request.getContextPath(); %>  

<jsp:include page="../header4.jsp" />

<style type="text/css">
div.odr_container {
	padding-top: 100px;
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

tr.odr_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

tr.odr_total_price > td {
	text-align: right;
}

/* 주문정보 & 배송정보 css */
img#zipcodeSearch1, img#zipcodeSearch2 {
	width: 95px;
	height: 30px;
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
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	var prodmsg = "";
	
	$(document).ready(function(){
		$("span.error").hide();
		autoOdrInfoInput();
		
		// 주문 결제창에 제품 정보 넘기기 위해 
		var cnt = 0;
		$("input.pinfo").each(function(index, item, array){
			if (index == 0) prodmsg += $("input.pinfo").val();		
			else cnt++; 
		});
		
		if (cnt > 0) {
			prodmsg += " 외 "+cnt+"개";
		}
		console.log(prodmsg);
		
		// == 라디오(주문자 정보와 동일, 새로운 배송지) 선택 사항 구현 == //
		$("input:radio[name=reveiceRadio]").click(function() {
			var checkVal = $("input:radio[name=reveiceRadio]").prop("checked");
			// console.log(checkVal);
			
			if (checkVal) {
				$("input#name2").val($("input#name1").val());
				$("input#postcode2").val($("input#postcode1").val());
				$("input#address2").val($("input#address1").val());
				$("input#detailAddress2").val($("input#detailAddress1").val());
				$("input#extraAddress2").val($("input#extraAddress1").val());
				
				$("input#hp2_2").val($("input#hp1_2").val());
				$("input#hp2_3").val($("input#hp1_3").val());
			}
			else {
				$("input#name2").val("");
				$("input#postcode2").val("");
				$("input#address2").val("");
				$("input#detailAddress2").val("");
				$("input#extraAddress2").val("");
				
				$("input#hp2_2").val("");
				$("input#hp2_3").val("");
			}
		});
		
		// == 이메일 닷컴 select 선택시 자동 입력 == //
		$("select#emailSelect").change(function(){
			// console.log($(this).val());
			
			$("input#emaildotcom").val($(this).val());
		});
	});

	
	// ======= Function Declaration ====== //
	
	function autoOdrInfoInput() {
		$("input#name1").val("${sessionScope.loginuser.name}");
		$("input#postcode1").val("${sessionScope.loginuser.postcode}");
		$("input#address1").val("${sessionScope.loginuser.address}");
		$("input#detailAddress1").val("${sessionScope.loginuser.detailaddress}");
		$("input#extraAddress1").val("${sessionScope.loginuser.extraaddress}");
		
		var mobile = "${sessionScope.loginuser.mobile}";
		$("input#hp1_1").val(mobile.substr(0,3));
		$("input#hp1_2").val(mobile.substr(3,4));
		$("input#hp1_3").val(mobile.substr(7,4));
		
		var email = "${sessionScope.loginuser.email}".split("@");
		$("input#emailid").val(email[0]);
		$("input#emaildotcom").val(email[1]);
	}
	
	function postSearch1() {
		// == 우편번호 찾기 == // 
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
					document.getElementById("extraAddress1").value = extraAddr;

				} else {
					document.getElementById("extraAddress1").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode1').value = data.zonecode;
				document.getElementById("address1").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress1").focus();
			}
		}).open();
	}
	
	function postSearch2() {
		// == 우편번호 찾기 == // 
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
					document.getElementById("extraAddress2").value = extraAddr;

				} else {
					document.getElementById("extraAddress2").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode2').value = data.zonecode;
				document.getElementById("address2").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress2").focus();
			}
		}).open();
	}
	
	function requiredInfoCheck() {
		<%-- 주문자 정보입력 체크 --%>
		var name1 = $("input#name1").val().trim();
		if (name1 == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#name1").focus();
			return false;
		}
		
		var postcode1 = $("input#postcode1").val().trim();
		if (postcode1  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#postcode1").focus();
			return false;
		}
		
		var address1 = $("input#address1").val().trim();
		if (address1  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#address1").focus();
			return false;
		}
		
		var detailAddress1 = $("input#detailAddress1").val().trim();
		if (detailAddress1  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#detailAddress1").focus();
			return false;
		}
				
		var regExp = /^[1-9][0-9]{3}$/i;
		var bool = regExp.test($("input#hp1_2").val());
		if (!bool) {
			alert("핸드폰 정보를 다시 확인해주세요");
			$("input#hp1_2").focus();
			$("input#hp1_2").empty();
			return false;
		}
		
		regExp = /^\d{4}$/i;
		bool = regExp.test($("input#hp1_3").val());
		if (!bool) {
			alert("핸드폰 정보를 다시 확인해주세요");
			$("input#hp1_3").focus();
			$("input#hp1_3").empty();
			return false;
		}
		$("input#hp1").val($("input#hp1_1").val() + $("input#hp1_2").val() + $("input#hp1_3").val());
		
		$("input#email").val($("input#emailid").val() + "@" + $("input#emaildotcom").val());
		regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		bool = regExp.test($("input#email").val());
		if (!bool) {
			alert("이메일 정보를 다시 확인해주세요");
			$("input#emailid").focus();
			return false;
		}
		
		
		<%-- 수취인 정보입력 체크 --%>
		var name2 = $("input#name2").val().trim();
		if (name2 == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#name2").focus();
			return false;
		}
		
		var postcode2 = $("input#postcode2").val().trim();
		if (postcode2  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#postcode2").focus();
			return false;
		}
		
		var address2 = $("input#address2").val().trim();
		if (address2  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#address2").focus();
			return false;
		}
		
		var detailAddress2 = $("input#detailAddress2").val().trim();
		if (detailAddress2  == "") {
			alert("필수 입력사항을 확인해주세요.");
			$("input#detailAddress2").focus();
			return false;
		}
		
		regExp = /^[1-9][0-9]{3}$/i;
		bool = regExp.test($("input#hp2_2").val());
		if (!bool) {
			alert("핸드폰 정보를 다시 확인해주세요");
			$("input#hp2_2").focus();
			$("input#hp2_2").empty();
			return false;
		}
		
		regExp = /^\d{4}$/i;
		bool = regExp.test($("input#hp2_3").val());
		if (!bool) {
			alert("핸드폰 정보를 다시 확인해주세요");
			$("input#hp2_3").focus();
			$("input#hp2_3").empty();
			return false;
		}
		$("input#hp2").val($("input#hp2_1").val() + $("input#hp2_2").val() + $("input#hp2_3").val());
		console.log($("input#hp2"));
	}
	
	
	// == 결제하기 버튼 클릭 시 결제창 띄우기 == // 
	function paymentGoFunc() {
		// paymentComplete();
		
		
		var sumtotalPriceLast = Number($("span#sumtotalPriceLast").html().split(",").join(""));
		console.log(sumtotalPriceLast);
		
		// 필수 입력 사항 모두 입력되었는지 검사
		var requiredInfoFlag = requiredInfoCheck();
		if (requiredInfoFlag == false) {
			return ;
		}

		// 동의 체크박스를 모두 체크했는지 검사
		var agreeFlag = payAgreeCheck();
		if (agreeFlag == false) {
			alert("이용약관에 동의해주세요.");
			return ;
		}
		
		
		
		// 결제창으로 결제하는 부분 => 결제하고 싶으면 주석문 지우고 실행하면 됩니다.
		// paymentComplete(); // <- 결제창으로 결제한다면 이부분은 주석문 처리 해주세요!!!!!
		
		var url = "<%=request.getContextPath()%>/order/goPayment.up?name="+prodmsg+"&sumtotalPrice="+sumtotalPriceLast;
		window.open(url, "goPayment", 
					"left=350px, top=100px, width=820px, height=600px");
		
	}
	
	function paymentComplete() {
		
		var sumtotalPriceLast = Number($("span#sumtotalPriceLast").html().split(",").join(""));
		var usePoint = Number($("span#point").html().split(",").join(""));
		
		$.ajax({
			url:"<%=request.getContextPath()%>/order/orderProcess.up",
			type:"post",
			data:{"pnum_es":"${requestScope.pnum_es}",
				"oqty_es":"${requestScope.oqty_es}",
				"cartno_es":"${requestScope.cartno_es}",
				"option_es":"${requestScope.option_es}",
				"totalPrice_es":"${requestScope.totalPrice_es}",
				"sumtotalPrice":sumtotalPriceLast,
				"sumtotalPoint":"${requestScope.sumtotalPoint}",
				"usePoint":usePoint},
			dataType:"json",
			success:function(json){
				if (json.isSuccess == 1) {
					alert("주문이 완료되었습니다.");
					submitOrderFrm(json.ordercode); // 배송지 입력 정보 저장하러 가기 -> 원래는 ajax 로 한번에 보내야하는데 어쩌다보니 따로 처리하게 되었습니다..
				}
			},
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		// console.log("결제 성공");
	}
	
	function submitOrderFrm(ordercode) {		
		var sumtotalPriceLast = $("span#sumtotalPriceLast").html();
		
		// 주문메세지 보내기 
		var odrmsg = "";
		var cnt = 0;
		
		$("input.pinfo").each(function(index, item, array){
			if (index == 0) odrmsg += $("input.pinfo").val();		
			else cnt++; 
		});
		
		if (cnt > 0) {
			odrmsg += " 외 "+cnt+"개 ";
		}
		odrmsg += "상품 결제가 완료되었습니다.";
		
		//console.log(odrmsg);
		$("input[name=odrmsg]").val(odrmsg);
		$("input[name=sumtotalPrice]").val(sumtotalPriceLast);
		$("input#ordercode").val(ordercode);

		var frm = document.deliverInfoFrm;
		frm.action = "<%=request.getContextPath()%>/order/orderSuccess.up";
		frm.method = "post";
		frm.submit();
	}
	

	
</script>

<div class="container odr_container">
	<h2 style="width: 80%; margin-bottom: 50px; color: gray;">- Order</h2>
	
	
	<c:set var="sumtotalPrice" value="${requestScope.sumtotalPrice}" scope="request"/>
	<c:set var="sumtotalPoint" value="${requestScope.sumtotalPoint}" scope="request"/>
	<c:set var="sumSalePrice" value="0" scope="request"/>
	<c:set var="deliveryPrice" value="3000" scope="request"/>
	
	
	<table class="table odr_list">
		<thead>
			<tr>
				<!-- <th><input type="checkbox" name="checkall"/></th> -->
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립금</th>
				<!-- <th>배송구분</th>
				<th>배송비</th> -->
				<th>합계</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="map" items="${requestScope.mapList}" >
				<tr class="odr_tr">
					<td><img class="odr_img" src="<%=ctxPath%>/image/product/${map.fk_decode}/${map.pimage1}" alt="<%=ctxPath%>/image/product/${map.fk_decode}/${map.pimage1}" ></td>
					<td>${map.pname}<br><span style="font-size: 10pt; color: #999;">${map.option}</span></td>
					<input name="pinfo" class="pinfo" value="${map.pname}" hidden/>
					<td>
						<c:if test="${map.price != map.saleprice}">
							<span style="text-decoration: line-through; text-decoration-color: red;"><fmt:formatNumber value="${map.price}" pattern="#,###" /></span> 원<br>
							<span><fmt:formatNumber value="${map.saleprice}" pattern="#,###" /></span> 원
						</c:if>
						<c:if test="${map.price == map.saleprice}">
							<span><fmt:formatNumber value="${map.saleprice}" pattern="#,###" /></span> 원
						</c:if>
					</td>
					<td><fmt:formatNumber value="${map.oqty}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${map.point}" pattern="#,###" /></td>
					<%-- <td>${prod.delivtype}</td>
					<td>${prod.delivprice}</td> --%>
					<td><fmt:formatNumber value="${map.totalPrice}" pattern="#,###" /> 원</td>
				</tr>

				<c:set var="sumSalePrice" value="${sumSalePrice + (map.price - map.saleprice)*map.oqty}" scope="request"/>
			</c:forEach>
			
			<tr class="odr_total_price">
				<td colspan="9">
					[기본배송] 상품구매금액 <span><fmt:formatNumber value="${requestScope.sumtotalPrice + sumSalePrice}" pattern="#,###" /></span>
					<c:if test="${sumtotalPrice >= 30000}"><c:set var="deliveryPrice" value="0" scope="request"/></c:if>
					
					+ 배송비 <span><fmt:formatNumber value="${deliveryPrice}" pattern="#,###" /></span>&nbsp;
					- 상품할인금액 <span><fmt:formatNumber value="${sumSalePrice}" pattern="#,###" /></span>&nbsp;
					
					<c:set var="sumtotalPriceLast" value="${sumtotalPrice + deliveryPrice}" scope="request"/>
					= 합계 : <span style="font-size: 15pt; font-weight: bold;"><fmt:formatNumber value="${sumtotalPriceLast}" pattern="#,###" /></span>원 
				</td>
			</tr>
		</tbody>
	</table>
	
	<%-- 주문자 정보 입력폼 --%>
	<form name="deliverInfoFrm">
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
						<input type="text" name="name1" id="name1" class="requiredInfo" /> 
						<span class="error">성명은 필수입력 사항입니다.</span>
					</td>
				</tr>
				<tr>
					<td>주소&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="postcode1" name="postcode1" size="6" maxlength="5" />&nbsp;&nbsp;
						<%-- 우편번호 찾기 --%> 
						<img id="zipcodeSearch1" src="<%=ctxPath%>/image/우편번호찾기.png" onclick="postSearch1()" style="vertical-align: middle;" /><br />
						<span class="error">우편번호 형식이 아닙니다.</span>
						<input type="text" id="address1" name="address1" size="40" placeholder="주소" /><br /> 
						<input type="text" id="detailAddress1" name="detailAddress1" size="40" placeholder="상세주소" />&nbsp;
						<input type="text" id="extraAddress1" name="extraAddress1" size="40" placeholder="참고항목" /> 
						<span class="error">주소를 입력하세요</span>
					</td>
				</tr>
				<tr>
					<td>휴대전화&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="hp1_1" name="hp1_1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
						<input type="text" id="hp1_2" name="hp1_2" size="6" maxlength="4" />&nbsp;-&nbsp;
						<input type="text" id="hp1_3" name="hp1_3" size="6" maxlength="4" />
						<input type="text" id="hp1" name="hp1" hidden />
						<span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
				</tr>
				<tr>
					<td>이메일&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="emailid" class="requiredInfo"/>@
						<input type="text" id="emaildotcom" class="requiredInfo"/>
						<input type="text" id="email" name="email" hidden />
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
		
		<%-- 수취인 정보 폼 --%>
		<table class="table odr_info">
			<thead>
				<tr>
					<td>배송 정보</td>
					<input type="hidden" name="ordercode" id="ordercode"/>
					<input type="hidden" name="odrmsg" />
					<input type="hidden" name="sumtotalPrice" />
					<td style="text-align: right; vertical-align: bottom;"><span class="star">*</span>필수입력사항</td>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>배송지 선택</td>
					<td>
						<input type="radio" value="1" name="reveiceRadio" id="orderlist_same" />
						<label for="orderlist_same">주문자 정보와 동일</label>&nbsp;
						<input type="radio" value="0" name="reveiceRadio" id="orderlist_new" checked/>
						<label for="orderlist_new">새로운 배송지</label>
					</td>
				</tr>
				<tr>
					<td>받으시는 분&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" name="recName" id="name2" class="requiredInfo" /> 
						<span class="error">성명은 필수입력 사항입니다.</span>
					</td>
				</tr>
				<tr>
					<td>주소&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="postcode2" name="recPostcode" size="6" maxlength="5" />&nbsp;&nbsp;
						<%-- 우편번호 찾기 --%> 
						<img id="zipcodeSearch2" src="<%=ctxPath%>/image/우편번호찾기.png" onclick="postSearch2()" style="vertical-align: middle;" /><br />
						<span class="error">우편번호 형식이 아닙니다.</span>
						<input type="text" id="address2" name="recAddress" size="40" placeholder="주소" /><br /> 
						<input type="text" id="detailAddress2" name="recDetailAddress" size="40" placeholder="상세주소" />&nbsp;
						<input type="text" id="extraAddress2" name="recExtraAddress" size="40" placeholder="참고항목" /> 
						<span class="error">주소를 입력하세요</span>
					</td>
				</tr>
				<tr>
					<td>연락처&nbsp;<span class="star">*</span></td>
					<td>
						<input type="text" id="hp2_1" name="hp2_1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
						<input type="text" id="hp2_2" name="hp2_2" size="6" maxlength="4" />&nbsp;-&nbsp;
						<input type="text" id="hp2_3" name="hp2_3" size="6" maxlength="4" />
						<input type="hidden" id="hp2" name="recMobile"  />
						<span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
				</tr>
				<tr>
					<td>배송메시지</td>
					<td>
						<textarea rows="4" cols="100" name="dvMessage" placeholder="요청사항을 입력해주세요."></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<jsp:include page="payment.jsp" />
	
</div>	

<jsp:include page="../footer.jsp" />		
