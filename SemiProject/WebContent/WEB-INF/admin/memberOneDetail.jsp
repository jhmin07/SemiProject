<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header4.jsp"/>

<style type="text/css">
	div.container {		
		margin: 80px auto;		
	}
	
	h2 {				
		text-align: center;		
		font-size: 30pt; 
		font-family: 'Papyrus'; 		
		margin: 20px auto;
		font-weight: bold;
	}	
	
	table#tblMemberOneDetail {
		width: 500px;
		margin: 30px auto;
	}
	
	td {
		line-height: 30px;		
		font-size: 14px;
		padding: 8px 0;
	}
	
	td.td1 {
		font-weight: bold;
	}
	
	td.td2 {
		border-bottom: solid 1px #669999;
		padding-left: 20px;
		width: 400px;
	}
	
	/* ============================================= */
	div#sms {
		margin: 0 auto; 
	/*	border: solid 1px red; */ 
		overflow: hidden; 
		width: 50%;
		padding: 10px 0 10px 80px;
	}
	
	span#smsTitle {
		display: block;
		font-size: 13pt;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	textarea#smsContent {
		float: left;
		height: 100px;
	}
	
	button#btnSend {
		float: left;
		border: none;
		width: 50px;
		height: 100px;
		background-color: #476b6b;
		color: white;
	}
	
	div#smsResult {
		clear: both;
		color: #ff8533;
		padding-top: 20px;
		font-weight: bold;
	}  
	
	div#button {
		border: solid 2px #c2d6d6;
		display: table-cell;
		width: 150px;
		height: 45px;
		text-align: center;
		background-color: #ffffff;
		vertical-align: middle;
		color: #9FA7B6;
		border-radius: 20px;
		font-size: 12pt;
	}
	
	div#button:hover {
	    color: #ffffff;
	    background-color: #c2d6d6;
	}
	ul {
		list-style: none;
	}
</style>
<script type="text/javascript">

	var goBackURL = "";
	
	$(document).ready(function(){
		
		$("div#smsResult").hide();
		
		$("button#btnSend").click(function(){		
	         
			var reservedate = $("input#reservedate").val();
			reservedate = reservedate.split("-").join("");
			
			var reservetime = $("input#reservetime").val();
			reservetime = reservetime.split(":").join("");
			
			var datetime = reservedate+reservetime;
	        
			var dataObj;
			
			if(reservedate == "" || reservetime == "" ) {
				dataObj = {"mobile":"${requestScope.mvo.mobile}",
						   "smsContent": $("textarea#smsContent").val()};
			}
			else {
				dataObj = {"mobile":"${requestScope.mvo.mobile}",
						   "smsContent": $("textarea#smsContent").val(),
						   "datetime":datetime};
			}
			
			$.ajax({ // ????????? ?????? ?????? ??????
				url:"<%= request.getContextPath()%>/admin/smsSend.up",
				type:"POST",
				data:dataObj,
				dataType:"json",
				success:function(json){					
					
					if(json.success_count == 1){
						$("div#smsResult").html("??? ??????????????? ?????????????????????");
					}
					else if(json.error_count != 0){
						$("div#smsResult").html("??? ??????????????? ?????????????????????");
					}
					
					$("div#smsResult").show();
					$("textarea#smsContent").val("");
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});			
		});
		
		////////////////////////////////////////////////////////////
		goBackURL = "${requestScope.goBackURL}";	
		
		goBackURL = goBackURL.replace(/ /gi, "&");
		
	});// end of $(document).ready(function(){});--------------------
	
	
	// Function Declaration
	function goMemberList(){
		location.href = "/SemiProject/"+goBackURL;
	}
</script>

<div class="container">
<c:if test="${empty requestScope.mvo}">
	???????????? ?????? ???????????????.<br>
</c:if>

<c:if test="${not empty requestScope.mvo}">
	<c:set var="mobile" value="${requestScope.mvo.mobile}"/> <%-- ???????????? --%>
	<c:set var="birthday" value="${requestScope.mvo.birthday}"/>
	
	<h2>Membership Information</h2>
	
	<div id="mvoInfo">
		<table id="tblMemberOneDetail">
			<tr>
				<td class="td1" width="100px">?????????</td>
				<td class="td2">${requestScope.mvo.userid}</td>
			</tr>  
			<tr>
				<td class="td1">?????????</td>
				<td class="td2">${requestScope.mvo.name}</td>
			</tr>  
			<tr>
				<td class="td1">?????????</td>
				<td class="td2">${requestScope.mvo.email}</td>
			</tr>  
			<tr>
				<td class="td1">?????????</td>
				<td class="td2">
					<c:choose>
						<c:when test="${empty fn:substring(mobile, 0, 3)}"></c:when>
						<c:otherwise>						
							${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}
						</c:otherwise>
					</c:choose>
				</td>				
			</tr>  
			<tr>
				<td class="td1">????????????</td>
				<td class="td2">${requestScope.mvo.postcode}</td>
			</tr>  
			<tr>
				<td class="td1">??????</td>
				<td class="td2">${requestScope.mvo.address}&nbsp;${requestScope.mvo.detailaddress}&nbsp;${requestScope.mvo.extraaddress}</td>
			</tr>  
			<tr>
				<td class="td1">??????</td>
				<td class="td2"><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">???</c:when><c:otherwise>???</c:otherwise></c:choose></td>
			</tr>  
			<tr>
				<td class="td1">????????????</td>
				<td class="td2">
					<c:choose>
						<c:when test="${fn:substring(birthday, 0, 2) eq '--'}"></c:when>
						<c:otherwise>						
							${fn:substring(birthday, 0, 4)}-${fn:substring(birthday, 4, 6)}-${fn:substring(birthday, 6, 8)}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>  
			<tr>
				<td class="td1">??????</td>
				<td class="td2">
					<c:choose>
						<c:when test="${fn:substring(birthday, 0, 2) eq '--'}"></c:when>
						<c:otherwise>						
							${requestScope.mvo.age}???
						</c:otherwise>
					</c:choose>
				</td>				
			</tr>  
			<tr>
				<td class="td1">?????????</td>
				<td class="td2"><fmt:formatNumber value="${requestScope.mvo.point}" pattern="#,###"/> POINT</td>
			</tr>  
			<tr>
				<td class="td1">????????????</td>
				<td class="td2">${requestScope.mvo.registerday}</td>
			</tr> 	
		</table>
	</div>
	
	<%-- ==== ????????? SMS(??????) ????????? ==== --%>
	<div id="sms" align="left">
		<span id="smsTitle">SMS(??????) ?????????</span>
		<div style="margin: 10px 0 20px 0">
			???????????????&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
		</div>		
		<textarea rows="4" cols="40" id="smsContent"></textarea>
		<button id="btnSend">??????</button>
		<div id="smsResult"></div>
	</div>
	
</c:if>

<div align="center" style="margin-top: 30px;">	
	<div id="button" onclick="goMemberList()">????????????</div>
</div>

</div>
<jsp:include page="../footer.jsp"/>