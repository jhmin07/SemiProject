<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../../header4.jsp"/>
<style type="text/css">
	div.container {		
		margin: 80px auto;		
	}

	table#tblMemberRegister {		
		width: 70%;
		margin: 50px auto;
		border: solid 1px #b3cccc;				
	}  
	
	th#th {				
		text-align: center;		
		font-size: 30pt; 
		font-family: 'Papyrus', Fantasy; 
		font-weight: bold;
		padding-top: 50px;
		color: #264d00;
	}	
	
	td {		
		line-height: 30px;
		padding-top: 8px;
		padding-bottom: 8px;
		width: 50%;
		font-size: 12pt;
	}
	
	td.td_title {
		text-align: right;
		padding-right: 20px;
		font-weight: bold;		
	}
	
	td.td_content{
		padding-left: 20px;
	}
	
	span#goHome {		
		border: solid 2px #3d5c5c;
		border-radius: 40px;		
		font-size: 15pt;
		cursor: pointer;
		padding: 5px;		
	}
</style>

<script type="text/javascript">
function goHome(){
	location.href = "<%=request.getContextPath()%>/home.up";
}
</script>

<div class="container">	
	<table id="tblMemberRegister">
		<thead>
			<tr>
				<th colspan="2" id="th">Welcome</th>
			</tr>
			<tr>
				<td colspan="2" align="center" style="font-size: 12pt; color: #666;">RHOME 회원가입이 완료되었습니다<br><br></td>
			</tr>			
		</thead>
		<tbody>
			<tr>			
				<td class="td_title">아이디</td>
				<td class="td_content">${sessionScope.loginuser.userid}</td>			
			</tr>
			<tr>			
				<td class="td_title">이름</td>
				<td class="td_content">${sessionScope.loginuser.name}</td>			
			</tr>
			<tr>			
				<td class="td_title">이메일</td>
				<td class="td_content">${sessionScope.loginuser.email}</td>			
			</tr>
			<tr>
				<td colspan="2" align="center"><br><br><span id="goHome" onclick="goHome()">&nbsp;메인페이지로 가기&nbsp;</span><br><br></td>
			</tr>
		</tbody>
	</table>	
</div>

<jsp:include page="../../footer.jsp"/>