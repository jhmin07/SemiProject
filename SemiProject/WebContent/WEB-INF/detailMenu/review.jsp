<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>


<style type="text/css">
.star_rating {font-size:0; letter-spacing:-4px; background-color:white;}
.star_rating a {
    font-size:20px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
    background-color:white;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:red; background-color:white;}

 div.star{
 
 	/* border: solid 1px gray; */
 	width: 200px;
 	margin-bottom: 10px
 }
div.star>span{
	font-size:12px;
	margin:0;
	/* border: solid 1px gray; */
}
  /* ---------------------- */
.btn10{
  
   background:#3E505E;
  color:#fff;
  border:none;
  position:relative;
  height: 40px;
  font-size:14px;
  padding:0 40px;;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  margin-left: 500px;
  margin-top: 5px;
}
.btn10:hover{
  background:#fff;
  color:#3E505E;
}
.btn10:before,.btn10:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #3E505E;
  transition:400ms ease all;
}
.btn10:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
.btn10:hover:before,.btn10:hover:after{
  width:100%;
  transition:800ms ease all;
}

  
  
  
  hr.first{
  	border-top: 3px double #bbb;
	width: 300px;
	margin-top: 10px ;
	margin-bottom: 10px ;
  }
  
  div.review{
		width: 1000px; 
  	 	/* border: solid 1px red; */
  	 	margin-left: 100px;
  	 	padding-left:150px;
  }
  
.customHeight {height: 70px;}
   
   
   textarea#commentContents {font-size: 12pt;}
   
   div#viewComments {
   					display: inline-block;
   					float:left;
   					width: 80%;
                     text-align: left;
                     max-height: 300px;
                     overflow: auto;
                     float: left;
                     /* border: solid 1px red; */
   }
   
   span.markColor {color: #ff0000; }
   
   div.customDisplay {display: inline-block;
                      margin: 1% 3% 0 0;
   }
                   
   div.spacediv {margin-bottom: 5%;}
   
   div.commentDel {font-size: 8pt;
                   font-style: italic;
                   cursor: pointer; }
   
   div.commentDel:hover {background-color: navy;
                         color: white;   }
                         
          div.star_list{
          background-color:#E7E6E6;
          font-size: 13px;
          width: 100px;
          text-align: center;
          }  
          span.star_list{
          color:#fff;
          }    
               
  
</style>


<script src="<%= ctxPath %>/js/jquery.number.min.js"></script>

<script type="text/javascript">

$(function() {
	
	goCommentListView(); // 제품 구매후기를 보여주는 것.
	
	$( ".star_rating a" ).click(function() {
	     $(this).parent().children("a").removeClass("on");
	     $(this).addClass("on").prevAll("a").addClass("on");
	     return false;
	});



	
	
    // **** 제품후기 쓰기 (로그인/ 상품을 산 사람만 후기작성가능)****// 
    $("button.btnCommentOK").click(function(){
	  
	   if(${empty sessionScope.loginuser}){
		   alert("상품후기를 작성하시려면 먼저 로그인 하셔야 합니다!!");
		   return;
	   }
	   
	   var commentContents = $("textarea#commentContents").val().trim();
	   
	   if(commentContents == ""){
		   alert("상품후기 내용을 입력하세요!!");
		   return;
	   }
	 
	   /* var queryString = {"fk_userid":"${sessionScope.loginuser.userid}",
		  "fk_pnum":"${requestScope.pvo.pnum}",
		  "contents":$("textarea#commentContents").val()}; */
		// 보내야할 데이터를 선정하는 두번째 방법
		// jQuery에서 사용하는 것으로써,
		// form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
		var queryString = $("form[name=commentFrm]").serialize();
		//console.log(queryString);
		
		$.ajax({
		url:"<%= request.getContextPath()%>/shop/reviewRegister.up",
		type:"post",
		data: queryString,
		dataType:"json",
		success:function(json){
		if(json.n == 1) {
		   // 제품후기 등록(insert)이 성공했으므로 제품후기글을 새로이 보여줘야(select) 한다.
		   goCommentListView(); // 제품후기글을 보여주는 함수 호출하기 
		}
		else if(json.n == -1)  {
		 // 동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓰려고 경우 unique 제약에 위배됨 
		// alert("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
		 swal("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
			}
		else  {
		   // 제품후기 등록(insert)이 실패한 경우 
		   alert("제품후기 글쓰기가 실패했습니다.");
		}
		
		$("textarea#commentContents").val("").focus();
		},
		error: function(request, status, error){
		 alert("상품을 구매하신고객님께서만 후기작성이 가능합니다!!");
		}
		
		}); 
				
	  
	   
	   
	   
 });// end of $("button.btnCommentOK").click(function(){}-----------------------------

 // **** 제품후기 쓰기(로그인하여 실제 해당 제품을 구매했을 때만 딱 1번만 작성할 수 있는 것. 제품후기를 삭제했을 경우에는 다시 작성할 수 있는 것임.) ****// 
	
	
	
 });

//특정 제품의 제품후기글들을 보여주는 함수
 function goCommentListView() {
    
   $.ajax({
      url:"<%= request.getContextPath()%>/shop/reviewList.up",
      type:"GET",
      data:{"fk_pnum":"${requestScope.pvo.pnum}"},
      dataType:"json",
      success:function(json){
        /*
           [{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}
           ,{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호} 
           ]  
        */ 
        var html = "";
        
        if(json.length > 0) {
           $.each(json, function(index, item){
              var writeuserid = item.fk_userid;
              var loginuserid = "${sessionScope.loginuser.userid}";
              
              html += "<hr id='reviewhr'>"
              
              if(item.star == 1){
            	  html += "<div class='star_list'> 별점 : <span class='markColor'>★</span><span class='star_list'>★★★★</span> </div>"
              }
              else if(item.star == 2){
            	  html += "<div class='star_list'> 별점 : <span class='markColor'>★★</span><span class='star_list'>★★★ </span></div>"
              }
			  else if(item.star == 3){
				  html += "<div class='star_list'> 별점 : <span class='markColor'>★★★</span><span class='star_list'>★★</span> </div>"        	  
			  }
			  else if(item.star == 4){
				  html += "<div class='star_list'> 별점 : <span class='markColor'>★★★★</span><span class='star_list'>★ </span></div>"  
			  }
			  else if(item.star ==5){
				  html += "<div class='star_list'> 별점 :  <span class='markColor'>★★★★★</span> </div>"  
			  }
              
              html +=  "<div> <span class='markColor'>▶</span> "+item.contents+"</div>"
                      +  "<div class='customDisplay'>"+item.name+"</div>"      
                      +  "<div class='customDisplay'>"+item.writeDate+"</div>";
                      
                if( loginuserid == "" ) {
                   html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                   
                }     
                else if( loginuserid != "" && writeuserid != loginuserid ) {
                   html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                }
                else if( loginuserid != "" && writeuserid == loginuserid ) {
                   html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.review_seq+")'>후기삭제</div>"; 
                }
                
                html += "<hr id='reviewhr' style='margin-top: 0;'>"
              
           });
        } // end of if ----------------------------------------
        
        else {
           html += "<div>등록된 상품후기가 없습니다.</div>";
        }// end of else ---------------------------------------
        
        $("div#viewComments").html(html);
        
       // == "div#sideinfo" 의 height 값 설정해주기 == 
       var contentHeight =   $("div#content").height();
       //   alert(contentHeight);
       $("div#sideinfo").height(contentHeight);
        
      },
      error: function(request, status, error){
          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
      }
   });
    
 }// end of function goCommentListView() {}------------------------------
 
//특정 제품의 제품후기를 삭제하는 함수
 function delMyReview(review_seq){
	   var bool = confirm("정말로 삭제하시겠습니까?");
	   if(bool){
		   $.ajax({
			   url:"<%= request.getContextPath()%>/shop/reviewDel.up",
	         type:"post",
	         data:{"review_seq":review_seq},
	         dataType:"json",
	         success:function(json){
	         	if(json.n == 1){
	         		alert("제품후기 삭제가 성공되었습니다.");
	         		goCommentListView();
	         	}
	         	else{
	         		alert("제품후기 삭제가 실패했습니다.");
	         	}
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
		   });
	   }
	   
}  
 
 

 function star_1(){
	 $('input#star_val').val("");
     $('input#star_val').val("1");
 }
 function star_2(){
	 $('input#star_val').val("");
     $('input#star_val').val("2");
 }
 function star_3(){
	 $('input#star_val').val("");
     $('input#star_val').val("3");
 }
 function star_4(){
	 $('input#star_val').val("");
     $('input#star_val').val("4");
 }
 function star_5(){
	 $('input#star_val').val("");
     $('input#star_val').val("5");
 }
</script>



<div class="container" style="padding: 100px 0;">



	<div id ="title_review">
	<hr class="first"><span style="font-size: 15pt; color: #3E505E; font-weight: bold; margin-left: 550px; " >Reviews</span><hr class="first">
	</div>
 
<div class="review"> 
 
    
    <div id="viewComments" style="margin-bottom:50px;">
       <%-- 여기가 제품사용 후기 내용이 들어오는 곳이다. --%>
    </div> 
    
    
<form name="commentFrm">
    
<div class="star" >
<span  >[별점주기]</span>

<p class="star_rating">
    <input type="hidden" name="star" id="star_val" value="" />
    <a href="#" onclick="star_1(1)">★</a>
    <a href="#" onclick="star_2(2)">★</a>
    <a href="#" onclick="star_3(3)">★</a>
    <a href="#" onclick="star_4(4)">★</a>
    <a href="#" onclick="star_5(5)">★</a>
</p>


</div>
    



       <div>
          <textarea cols="85" class="customHeight" name="contents" id="commentContents"></textarea>
          <button type="button" class="btnCommentOK btn10" >후기등록</button>
       </div>
       <input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
       <input type="hidden" name="fk_pnum" value="${requestScope.pvo.pnum}" />
    </form>
   
</div>

</div>