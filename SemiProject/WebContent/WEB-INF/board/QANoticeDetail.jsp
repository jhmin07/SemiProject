<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<jsp:include page="../header4.jsp" />

<style type="text/css">
	
   table.NoticeDetail tr{
      border: solid 2px #999999;
      border-left: none;
      border-right: none;
   }
   table.NoticeDetail th{
   		height: 40px;
   }
   table.NoticeDetail td{
      padding-left: 10px;
   }
   td.NoticeDate{
   
   		height: 100px;
   }
   div.NoticeDetailDiv{
   		margin-top: 200px;
   		margin-bottom: 100px;
   }
    table.NoticeDetail{
    	width: 100%;
    	text-align: center;
    }s
    div#tableContainer{
    	width: 100%;
    	border: solid 1px hidden;
    	text-align: center;
    }
   td.NoticeContent{
   
   		height: 300px;
   }
   button#comment{
   	width: 150px; 
   	height: 100px; 
	color: white; 
	background-color: #bfbfbf;
   	font-size: 22px; 
   	font-weight: bold; 
   	border: none;
   }
    button#comment:hover{
   	font-size: 22px; 
   	font-weight: bold; 
   	color: #bfbfbf; 
	background-color: white;
   	border: solid 2px #bfbfbf;
   }
    button#QAList{
   	width: 150px; 
   	height: 40px; 
	color: white; 
	background-color: #bfbfbf;
   	font-size: 22px; 
   	font-weight: bold; 
   	border: none;
   }
    button#noticeList:hover{
   	font-size: 22px; 
   	font-weight: bold; 
   	color: #bfbfbf; 
	background-color: white;
   	border: solid 2px #bfbfbf;
   }
   table#QACommentTable th{
   	background-color: #bfbfbf;
   	color : black;
   	font-size: 15px;
   	font-weight: bold;
   	text-align: center;
   }
   table#QACommentTable td{
   	background-color: #e6e6e6;
   	color : black;
   	font-size: 15px;
   	text-align: center;
   }
   table#QACommentTable tr{
   	height: 50px;
   }
   button.QAmodiDel{
   		display: inline-block;
   		text-align: center;
   		font-size: 15pt;
   		border: solid 1px #bfbfbf;
   }
   a:hover{
   		cursor: pointer;
   }
</style>

<script type="text/javascript">

	var goBackURL = "";
	
	$(document).ready(function(){
		
		CommentView();
		
		goBackURL = "${requestScope.goBackURL}";
		// ???????????????????????????  replaceall ??? ?????? replace ?????? ??????.
	    // !!! ???????????????????????? replace??? replaceall ?????? ???????????? !!! //
	      
	    // "korea kena" ==> "korea kena".replace("k","y") ==> "yorea kena"
	    // "korea kena".replace(/k/gi, "y") ==> "yorea yena"
	      
	    // ?????? goBackURL ??? ?????? " " ??? ?????? "&" ??? ??????????????? ??????.
	    
	    goBackURL = goBackURL.replace(/ /gi, "&");	// ????????? &??? ???????????? ??????????????? ?????? &??? ????????????. / / ????????? ???????????? ????????? ????????????.
		
	}); // end of $(document).ready(function(){})----------------------------------------------

	
	// Function Declaration
	function goQAList(){
		location.href = "<%=request.getContextPath()%>/board/boardQA.up";
	}
	function goQAComment(){
		var frm = document.QACommentFrm;
		frm.action = "QAComment.up?"; 
		frm.method = "GET";	// ???????????? ?????? ???????????? ?????????????????? get ??????
		frm.submit();
	}
	function commentDel(addno){
		location.href = "<%=request.getContextPath()%>/board/commentDel.up?addno="+addno;
		
	}
	function commentModi(addno1){
		$("td.addno").each(function(index,item){
			$.ajax({	// ????????? ????????? ?????? DB??? ?????????????????? ajax??? ??????
				   url:"<%=request.getContextPath()%>/board/commentView.up",
				   type:"post",
				   data:{"qaNo":"${requestScope.qvo.qaNo}"},
				   dataType:"json",
				   success:function(json){
					   var html = "";
					   if(json.length != 0) {
						   html += '<table id="QACommentTable"><thead><tr>'+
				   		   		   '<th style="width: 50px;">NO.</th>'+
						   		   '<th style="width: 500px;">??????</th>'+
						   		   '<th style="width: 100px;">?????????</th>'+
						   		   '<th style="width: 200px;">????????????</th>'+
						   		   '<th style="width: 90px;"></th>'+
						   		   '</tr></thead>'+
										'<tbody>';
						   $.each(json, function(index,item){
							   var addno = item.addno;
							   var addSubject = item.addSubject;
							   var fk_qaNo = item.fk_qaNo;
							   var writer = item.writer;
							   var addRegisterday = item.addRegisterday;
								html += '<tr>'+
									   '<td class="addno">'+addno+'</td>';
									   console.log(addno+ "," +addno1);
									   if(addno == addno1){
										 html+='<td class="addSubject">'+
										   		 '<form name="modiFrm">'+
										   		  '<input style="height: 100px; width:250px;" value="'+addSubject+'" name="modiContent"/>'+
										   		 	'<input name="addno" type="hidden" value="'+addno1+'" />&nbsp;'+
										   		 	  '<button onClick="commentModiSubmit()">????????????</button></form></td>';
									   }
									   else{
										   html+='<td class="addSubject">'+addSubject+'</td>';
									   }
								html += '<td>'+writer+'</td>'+
									   '<td>'+addRegisterday+'</td>';

							   
								   html+='<td></td></tr>'; 
							  
								   
							});
						   
							html +=	 '</tbody>'+
										'</table>';
							$("div#commentList").html(html);
					   } else{
			                 // ???????????? ???????????? ???????????? ?????? ??????
			                // !!! ?????? !!!
			                // if(json == null) ??? ??????!!!
			                // if(json.length == 0) ?????? ?????????!!
			                html += "????????? ????????? ????????????.....";
			                
							$("div#commentList").html(html);;
			              } 
					   
				   },
				   error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			         }
			   });
			
		});
		CommentView();
		/* var html = "<input />"; */
		<%-- location.href = "<%=request.getContextPath()%>/board/commentModi.up?addno="+addno;
		 --%>
	}
	function commentModiSubmit(){
		var frm = document.modiFrm;
		frm.action = "commentModiSubmit.up?"; 
		frm.method = "GET";	// ???????????? ?????? ???????????? ?????????????????? get ??????
		frm.submit();
		
	}
	function CommentView(){
		$.ajax({	// ????????? ????????? ?????? DB??? ?????????????????? ajax??? ??????
			   url:"<%=request.getContextPath()%>/board/commentView.up",
			   type:"post",
			   data:{"qaNo":"${requestScope.qvo.qaNo}"},
			   dataType:"json",
			   success:function(json){
				   var html = "";
				   if(json.length != 0) {
					   html += '<table id="QACommentTable"><thead><tr>'+
			   		   		   '<th style="width: 50px;">NO.</th>'+
					   		   '<th style="width: 500px;">??????</th>'+
					   		   '<th style="width: 100px;">?????????</th>'+
					   		   '<th style="width: 200px;">????????????</th>'+
					   		   '<th style="width: 90px;"></th>'+
					   		   '</tr></thead>'+
									'<tbody>';
					   $.each(json, function(index,item){
						   var addno = item.addno;
						   var addSubject = item.addSubject;
						   var fk_qaNo = item.fk_qaNo;
						   var writer = item.writer;
						   var addRegisterday = item.addRegisterday;
							html += '<tr>'+
								   '<td class="addno">'+addno+'</td>'+
								   '<td class="addSubject">'+addSubject+'</td>'+
								   '<td>'+writer+'</td>'+
								   '<td>'+addRegisterday+'</td>';

						   if( "${sessionScope.loginadmin.adId}" == writer ){
							   html+='<td><a style="color: green;" onClick="commentModi('+addno+')">??????</a>&nbsp;&nbsp;<a style="color: red;" onClick="commentDel('+addno+')">??????</a></td></tr>';
						   }
						   else{
							   html+='<td></td></tr>'; 
						   }
						});
					   
						html +=	 '</tbody>'+
									'</table>';
						$("div#commentList").html(html);
				   } else{
		                 // ???????????? ???????????? ???????????? ?????? ??????
		                // !!! ?????? !!!
		                // if(json == null) ??? ??????!!!
		                // if(json.length == 0) ?????? ?????????!!
		                html += "????????? ????????? ????????????.....";
		                
						$("div#commentList").html(html);;
		              } 
				   
			   },
			   error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
		   });
	}
	function goQADel(){
		location.href = "<%=request.getContextPath()%>/board/QADel.up?qaNo="+${requestScope.qvo.qaNo};
		
	}
	function goQAModi(){
		location.href = "<%=request.getContextPath()%>/board/QAModi.up?qaNo="+${requestScope.qvo.qaNo};
			   
	}
</script>
<div class="container NoticeDetailDiv">
	<c:if test="${empty requestScope.qvo}">
		???????????? ?????? ????????????.
	</c:if>
	<c:if test="${not empty requestScope.qvo}">
	<div id="tableContainer">
		<table class="NoticeDetail">
			<thead>
				<tr>
					<th style="text-align: center; color:#737373; font-size: 18px; font-weight: bold;">${requestScope.qvo.qaTitle}</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="NoticeDate" style="text-align: left; color:#737373; font-size: 15px;">Date : ${requestScope.qvo.qaRegisterday}
						<br>
						Name : ${requestScope.qvo.fk_userid}
					</td>
				</tr>
			</tbody>   
			
			<tbody>
				<tr>
					<td class="NoticeContent" style="text-align: left; font-size: 15px;"><br><br>${requestScope.qvo.qaContent}<br><br><br><br></td>
				</tr>
			</tbody> 
		</table>
		</div>
		 <c:if test="${requestScope.qvo.fk_userid eq sessionScope.loginuser.userid}">   
		   <div style="text-align: center;">	
		   	<br>
		 	<button class="QAmodiDel" onClick="goQAModi()">????????????</button>
		 	<a>&nbsp;&nbsp;&nbsp;</a>
		 	<button class="QAmodiDel" onClick="goQADel()">????????????</button>
		   </div>
		 </c:if>     
		<br><br>
		<div id="commentList">
			
		</div>
		<c:if test="${sessionScope.loginadmin.adId != null}">
			<br><br><br>
			<form name="QACommentFrm">
				<a><input name="QAComment" style="width: 700px; height: 200px; border: solid 2px #bfbfbf" type="text"/>&nbsp;&nbsp;<button id="comment" onclick="goQAComment()">????????????</button></a>
				<input name="qaNo" type="hidden" value="${requestScope.qvo.qaNo}"/>
			</form>
		</c:if>    
		</c:if>    
		
		<div>
			<button id="QAList" style="margin-top: 50px;" type="button" onclick="goQAList()">Q&A??????</button>
		   &nbsp;&nbsp;
		</div>
	  
	

</div>


<jsp:include page="../footer.jsp" />