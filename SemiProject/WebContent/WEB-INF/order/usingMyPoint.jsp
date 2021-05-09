<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 사용하기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style type="text/css">
div {
	margin: 20px 50px;
	width: 0 auto;
}

table {
	vertical-align: middle;
	/* width: 100%; */
	padding-right: 40px;
	/* border: solid 1px red; */
}

tr {
	height: 30px;	
	margin: 10px;
	/* border: solid 1px gray; */
}

td, th {
	padding: 10px 5px;
	/* border: solid 1px blue; */
}

button.mybtn {
	width: 80px;
	margin: 5px;
}

span.p {
	font-weight: bold;
	color: red;
}


</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		var userPoint = ${sessionScope.loginuser.point};
		
		$("button.useallbtn").click(function() { // 전액 사용
			$("input:text[name=usingPoint]").val(userPoint);
		});
		
		$("button.cancel").click(function(){ // 취소버튼
			self.close();
		});
		
		$("input:text[name=usingPoint]").blur(function(){ // 입력한 포인트 점검
			var inputVal = $("input:text[name=usingPoint]").val();
			
			if (userPoint < inputVal) {
				alert("사용가능한 포인트를 확인해주세요.");
				$(this).focus().val(0);
			}
		});
		
		$("button.ok").click(function(){ // 사용할 point 값 전달
			var inputVal = $("input:text[name=usingPoint]").val();
			opener.location.href = "javascript:setPoint("+ inputVal +");";
			
			self.close();
		});
	});
</script>
</head>

<body>
<div>
	<form name="usingPointFrm">
		<table>
			<thead>
				<tr><th style="padding-left: 10px;"><h3 style="margin-bottom: 10px;">포인트 사용</h3></th></tr>
			</thead>
			<tbody>
				<tr>
					<td style="text-align: right; width: 60%;"><input type="text" name="usingPoint" value="0" style="text-align: right; padding: 3px;"/></td>
					<td style="text-align: left; width: 40%;"><button type="button" class="btn btn-default useallbtn">전액사용</button></td>
				</tr>
				<tr>
					<td style="text-align: right;">사용 가능 포인트 <span class="p">${sessionScope.loginuser.point} P</span></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center; padding: 40px;">
						<button type="button" class="btn mybtn btn-info ok">확인</button>
						<button type="button" class="btn mybtn btn-info cancel" >취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
</body>
</html>