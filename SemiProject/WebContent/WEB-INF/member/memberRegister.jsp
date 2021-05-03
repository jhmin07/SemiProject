<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header4.jsp"/>

<title>회원가입</title>
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
	select {
		padding: 7px 0;
	}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	var b_flagIdDuplicateClick = false;
	// 가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도
	var b_flagEmailDuplicateClick = false;
	// 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도
	
	$(document).ready(function(){
		
		$("span.error").hide();	
		$("input#name").focus();
		
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우				
				$(this).parent().find(".error").show();		
				$(this).focus();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우				
				$(this).parent().find(".error").hide();
			}			
		}); // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#userid").blur(function(){
			
			var userid = $(this).val().trim();
			if(userid == ""){
				// 입력하지 않거나 공백만 입력했을 경우				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(this).parent().find(".error").hide();
			}			
		}); // 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
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
		
		////////////////////////////////////////////////////////////
		
		var yyhtml = "";
		yyhtml += "<option value = ''>선택</option>";
		for(var i=1950; i<=2050; i++){			
			yyhtml += "<option value = '"+i+"'>"+i+"</option>";						
		}
		$("select#birthyyyy").html(yyhtml);
		
		var mmhtml = "";
		mmhtml += "<option value = ''>선택</option>";
		for(var i=1; i<=12; i++){
			if(i<10){
				mmhtml += "<option value = '0"+i+"'>0"+i+"</option>";
			}
			else{
				mmhtml += "<option value = '"+i+"'>"+i+"</option>";
			}			
		}
		$("select#birthmm").html(mmhtml);
		
		var ddhtml = "";
		ddhtml += "<option value = ''>선택</option>";
		for(var i=1; i<=31; i++){
			if(i<10){
				ddhtml += "<option value = '0"+i+"'>0"+i+"</option>";
			}
			else{
				ddhtml += "<option value = '"+i+"'>"+i+"</option>";
			}			
		}
		$("select#birthdd").html(ddhtml);
					
		// === 아이디중복검사하기 ===
		$("img#idcheck").click(function(){
			b_flagIdDuplicateClick = true;
			// "아이디중복확인" 을 클릭했다라고 표기
			
			// === jQuery 를 이용한 Ajax (JSON 을 사용함) 두번째 방법 === //
			$.ajax({
				url:"<%= ctxPath%>/member/idDuplicateCheck.up",
				type:"post",
				data:{"userid":$("input#userid").val()},			
				dataType:"json", 
				success:function(json){
									
					if(json.isExists){
						// 입력한 userid 가 이미 사용중이라면
						$("span#idCheckResult").html($("input#userid").val() + " 은 중복된 ID 이므로 사용불가 합니다.").css({"color":"#ff6666", "font-weight":"bold", "font-size":"9.5pt", "margin-left":"10px"});
						$("input#userid").val("");
					}
					else{
						// 입력한 userid 가 DB 테이블에 존재하지 않는 경우라면
						$("span#idCheckResult").html("사용가능합니다").css({"color":"#4d79ff", "font-weight":"bold", "font-size":"9.5pt", "margin-left":"10px"});
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax({})--------------------
			
		});
	});
	
	// Function Declaration
	function goRegister(){
		
		var radioCheckedLength = $("input:radio[name=gender]:checked").length
		
		if(radioCheckedLength == 0){
			alert("성별을 선택하셔야 합니다.");
			return; // 종료
		}
		
		var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length
		
		if(checkboxCheckedLength == 0){
			alert("이용약관에 동의하셔야 합니다다.");
			return; // 종료
		}
		
		// 최종적으로 필수입력사항에 모두 입력이 되었는지 검사한다. //
		var bFlagRequiredInfo = false;
		
		$(".requiredInfo").each(function(index, item){
			var data = $(item).val();
			if(data == ""){
				bFlagRequiredInfo = true;
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				return false; // break 라는 뜻이다
			}
		});
		
		if(!b_flagIdDuplicateClick){
			// "아이디중복확인" 을 클릭을 안했을 경우
			alert("아이디중복확인 클릭하여 ID중복검사를 하세요!!");
			return; // 종료
		}
		
		if(!bFlagRequiredInfo){
			var frm = document.registerFrm;
			frm.action = "memberRegister.up";
			frm.method = "post";
			frm.submit();
		}
		
	}// end of function goRegister(){}--------------------
	
	
	function isExistEmailCheck(){
		b_flagEmailDuplicateClick = true;
		// "이메일중복확인" 을 클릭했다라고 표기를 해주는 것이다.
		
		$.ajax({
			url:"<%= ctxPath%>/member/emailDuplicateCheck.up",			
			data:{"email":$("input#email").val()}, 
			type:"post",
			dataType:"json", 
			success:function(json){	
				console.log(json);
				if(json.isExists){
					// 입력한 email 이 이미 사용중이라면
					$("span#emailCheckResult").html($("input#email").val() + " 은 중복된 email 이므로 사용불가 합니다.").css({"color":"#ff6666", "font-weight":"bold", "font-size":"9.5pt", "margin-left":"10px"});
					$("input#email").val("");					
				}
				else{
					// 입력한 email 이 DB 테이블에 존재하지 않는 경우라면
					$("span#emailCheckResult").html("사용가능합니다").css({"color":"#4d79ff", "font-weight":"bold", "font-size":"9.5pt", "margin-left":"10px"});
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}			
		});
		
	}// end of function isExistEmailCheck(){}--------------------
</script>

<div class="container">	
<form name="registerFrm">
	
	<table id="tblMemberRegister">
		<thead>
			<tr>
				<th colspan="2" id="th">Members</th>
			</tr>
			<tr>
				<td colspan="2" align="center" style="font-size: 13pt; color: #666;">RHOME 멤버에 가입하시면 더욱 다양한 혜택을 받으실 수 있습니다.</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>			
				<td colspan="2" align="right"><span class="star">*</span>&nbsp;<span class="info">필수입력사항</span></td>			
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;">
					<input type="text" name="name" id="name" class="requiredInfo" />
					<span class="error">성명은 필수입력 사항입니다.</span>	
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
				<td style="text-align: left;">
					<input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;
					<!-- 아이디중복체크 -->
					<img id="idcheck" src="../image/아이디중복확인.png" style="vertical-align: middle; width: 90px;" />				
					<span class="info">영문소문자/숫자, 5~15자</span>
					<span id="idCheckResult"></span>
					<span class="error">아이디는 필수입력 사항입니다.</span>
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
				<td style="text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" />&nbsp;					
					<!-- 이메일중복체크 -->
					<img id="emailcheck" src="../image/이메일중복확인.png" style="vertical-align: middle; width: 90px;" onclick="isExistEmailCheck();"/>
					<span class="error">이메일 형식에 맞지 않습니다.</span>
					<span id="emailCheckResult"></span>
				</td>
				
			</tr>
			<tr>
				<td style="font-weight: bold;">연락처</td>
				<td style="text-align: left;">
					<input type="text" id="hp1" name="hp1" size="6" maxlength="3" />&nbsp;-&nbsp;
					<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
					<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />								
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">우편번호</td>
				<td style="text-align: left;">
					<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;
					
					<img id="zipcodeSearch" src="../image/우편번호찾기.png" style="vertical-align: middle;" width="90px;"/>
					<span class="error">우편번호 형식이 아닙니다.</span>	
				</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">주소</td>
				<td style="text-align: left;">
					<input type="text" id="address" name="address" size="40" placeholder="주소" />
					<span class="error">주소를 입력하세요</span><br>
					<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /><br>
					<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />					
					
				</td>
			</tr>
			
			<tr>
				<td style="font-weight: bold;">성별</td>
				<td style="text-align: left;">
					<input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
					<input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
				</td>
			</tr>
			
			<tr>
				<td style="font-weight: bold;">생년월일</td>
				<td style="text-align: left;">
					<select id="birthyyyy" name="birthyyyy" style="width: 100px;"></select>&nbsp;년&nbsp;&nbsp;
					<select id="birthmm" name="birthmm" style="width: 60px;"></select>&nbsp;월&nbsp;&nbsp;
					<select id="birthdd" name="birthdd" style="width: 60px;"></select>&nbsp;일&nbsp;&nbsp;
				</td>
			</tr>
					
			<tr>			
				<td colspan="2">
				<br><br>
					<label for="agree" style="font-size: 11pt;">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="vertical-align: middle;">
					<iframe src="../iframeAgree/agree.html" width="100%" height="200px" class="box" style="border: solid 1px #ccc;"></iframe>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="line-height: 90px;">
					<img src="../image/가입하기.png" style="vertical-align: middle; width: 150px; margin-left: 42%" onclick="goRegister();"/>				 
				</td>
			</tr>
		</tbody>
	</table>
</form>	
</div>

<jsp:include page="../footer.jsp"/>