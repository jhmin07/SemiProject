<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../../header4.jsp"/>

<title>회원정보 수정</title>
<style type="text/css">
	div.container {		
		margin: 80px auto;
	}

	table#tblMemberRegister {		
		width: 98%;          
		margin: 10px;			
	}  
	
	th#th {				
		text-align: center;		
		font-size: 30pt; 
		font-family: 'Papyrus', Fantasy; 
		font-weight: bold;
	}	
	
	td {
		line-height: 30px;
		padding-top: 8px;
		padding-bottom: 8px;
	}
	
	span.star {
		color: red;
		font-weight: bold;
		font-size: 13pt;
	}
	
	span.info {
		color: gray;
		font-size: 9.5pt;
	}
	
	span.error {
		color: red;
		margin-left: 10px;
		font-size: 9.5pt;
		font-weight: bold;
	}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("span.error").hide();	
				
		$("input#pwd").blur(function(){
			
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var bool = regExp.test($(this).val());
						
			if(!bool){
				// 암호가 정규표현식에 위배된 경우				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 암호가 정규표현식에 맞는 경우
				$(this).parent().find(".error").hide();
			}
		}); // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#pwdcheck").blur(function(){
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $(this).val(); 
			
			if(pwd != pwdcheck){
				// 암호와 암호확인값이 틀린 경우				
				$(this).parent().find(".error").show();
				$("input#pwd").focus();				
			}
			else{
				// 암호와 암호확인값이 같은 경우
				$(this).parent().find(".error").hide();
			}
		}); // 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#email").blur(function(){
			
			var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			var bool = regExp.test($(this).val());
			
			if(!bool){
				// 이메일이 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
				$(this).focus();				
			}
			else{
				// 이메일이 정규표현식에 맞는 경우								
				$(this).parent().find(".error").hide();				
			}
		}); // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("img#zipcodeSearch").click(function(){			
			new daum.Postcode({
				oncomplete: function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
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
	});// end of $(document).ready()--------------------
	
	
	// Function Declaration
	function goEdit(){		
		
		var flagBool = false;
		
		$(".requiredInfo").each(function(index, item){
			
			var data = $(item).val().trim();
			if(data == ""){
				flagBool = true;
				return false;
			}
			
			if(flagBool){
				alert("*표시된 필수입력란은 모두 입력하셔야 합니다.");
				return;
			}
			else{
				var frm = document.editFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/member/memberEditEnd.up";
				frm.submit();
			}
		});
		
	}// end of function goEdit(){}--------------------
	
</script>

<div class="container">	
<form name="editFrm">
	
	<table id="tblMemberRegister">
		<thead>
			<tr>
				<th colspan="2" id="th">Members Update</th>
			</tr>
			<tr>
				<td colspan="2" align="center" style="font-size: 13pt; color: #666;">회원 정보를 수정할 수 있습니다.</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>			
				<td colspan="2" align="right"><span class="star">*</span>&nbsp;<span class="info">필수입력사항</span></td>			
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;">
					<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/>
					<input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" readonly/>
					<span class="error">성명은 필수입력 사항입니다.</span>	
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
				<td style="text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />&nbsp;
					<span class="info">영문 대소문자/숫자/특수문자, 8자~15자</span>
					<span class="error">비밀번호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
				</td>			
			</tr>
			<tr>
				<td style="font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
				<td style="text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" />
					<span class="error">비밀번호가 일치하지 않습니다.</span>
				</td>				
			</tr>
			<tr>
				<td style="font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
				<td style="text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" readonly/>&nbsp;					
					<span class="error">이메일 형식에 맞지 않습니다.</span>					
				</td>
				
			</tr>
			<tr>
				<td style="font-weight: bold;">연락처</td>
				<td style="text-align: left;">
					<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly/>&nbsp;-&nbsp;
					<input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile, 3, 7)}"/>&nbsp;-&nbsp;
					<input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile, 7, 11)}"/>								
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">우편번호</td>
				<td style="text-align: left;">
					<input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" />&nbsp;
					
					<img id="zipcodeSearch" src="../image/우편번호찾기.png" style="vertical-align: middle;" width="90px;"/>
					<span class="error">우편번호 형식이 아닙니다.</span>	
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">주소</td>
				<td style="text-align: left;">
					<input type="text" id="address" name="address" size="40" placeholder="주소" value="${sessionScope.loginuser.address}"/>
					<span class="error">주소를 입력하세요</span><br>
					<input type="text" id="extraAddress" name="extraAddress" size="40" value="${sessionScope.loginuser.extraaddress}"/><br>
					<input type="text" id="detailAddress" name="detailAddress" size="40" value="${sessionScope.loginuser.detailaddress}"/>					
					
				</td>
			</tr>			
			<tr>
				<td colspan="2" style="line-height: 90px;">
					<img src="../image/회원정보수정.png" style="vertical-align: middle; width: 150px; margin-left: 42%" onclick="goEdit();"/>				 
				</td>
			</tr>
		</tbody>
	</table>
</form>	
</div>

<jsp:include page="../../footer.jsp"/>