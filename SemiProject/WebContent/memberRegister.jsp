<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	table#tblMemberRegister {
		width: 93%;
		border: hidden;
          
		margin: 10px;
	}  
	
	table#tblMemberRegister #th {
		height: 40px;
		text-align: center;
		font-size: 14pt;
	}
	
	table#tblMemberRegister td {
		line-height: 30px;
		padding-top: 8px;
		padding-bottom: 8px;
	}
	
	.star {
		color: red;
		font-weight: bold;
		font-size: 13pt;
	}
	
	span.info {
		color: gray;
		font-size: 9.5pt;
	}
</style>
</head>
<body>
<div class="row" id="divRegisterFrm">
	<div class="col-md-12" align="center">
	<form name="registerFrm">
	
	<table id="tblMemberRegister">
		<thead>
		<tr>
			<th colspan="2" id="th" style="font-size: 30pt; font-family: 'Papyrus', Fantasy; font-weight: bold;">Members</th>
		</tr>
		<tr>
			<td colspan="2" align="center" style="font-size: 13pt; color: #666;">RHOME 멤버에 가입하시면 더욱 다양한 혜택을 받으실 수 있습니다.</td>
		</tr>
		</thead>
		
		<tbody>
		<tr>			
			<td colspan="2" align="right"><span class="star">*</span>&nbsp;<span class="info" style="margin-right: 8%">필수입력사항</span></td>			
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
				<input type="text" name="name" id="name" class="requiredInfo" />				
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
				<input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;
				<!-- 아이디중복체크 -->
				<img id="idcheck" src="image/아이디중복확인.png" style="vertical-align: middle; width: 90px;" />				
				<span class="info">영문소문자/숫자, 5~15자</span>
			</td> 
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />&nbsp;
			<span class="info">영문 대소문자/숫자/특수문자, 8자~15자</span>
			</td>			
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /></td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" />&nbsp;
				<!-- 이메일중복체크 -->
				<img id="emailcheck" src="image/이메일중복확인.png" style="vertical-align: middle; width: 90px;" />
			</td>
			
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">연락처</td>
			<td style="width: 80%; text-align: left;">
				<input type="text" id="hp1" name="hp1" size="6" maxlength="3" />&nbsp;-&nbsp;
				<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
				<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />				
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">우편번호</td>
			<td style="width: 80%; text-align: left;">
				<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;
				
				<img id="zipcodeSearch" src="image/우편번호찾기.png" style="vertical-align: middle;" width="90px;"/>		
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">주소</td>
			<td style="width: 80%; text-align: left;">
				<input type="text" id="address" name="address" size="40" placeholder="주소" />
				<span class="info">기본주소</span><br>
				<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /><br>
				<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" /> 
				<span class="info">상세주소</span>
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">성별</td>
			<td style="width: 80%; text-align: left;">
				<input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
				<input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">생년월일</td>
			<td style="width: 80%; text-align: left;">
				<input type="number" id="birthyyyy" name="birthyyyy" style="width: 100px;"/>&nbsp;년&nbsp;&nbsp;
				<input type="number" id="birthmm" name="birthmm" style="width: 60px;"/>&nbsp;월&nbsp;&nbsp;
				<input type="number" id="birthdd" name="birthdd" style="width: 60px;"/>&nbsp;일&nbsp;&nbsp;
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
				<iframe src="iframeAgree/agree.html" width="93%" height="200px" class="box" style="border: solid 1px #ccc;"></iframe>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="line-height: 90px;">
				<img src="image/가입하기.png" style="vertical-align: middle; width: 150px; margin-left: 40%" />				 
			</td>
		</tr>
		</tbody>
	</table>
	</form>
	</div>
</div>
</body>
</html>