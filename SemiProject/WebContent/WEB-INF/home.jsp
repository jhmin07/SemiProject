<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="header4.jsp" />

<style type="text/css">
      div.contents1 {
      	 margin-top: 70px;
         width: 100%;
           z-index: -1;
      }
      
      div.contents1 ol.carousel-indicators {
         text-align: right;
         width: 75%;
      }
      div.contents23{      
      display: inline-block;
      text-align: center;
      padding-bottom: 50px;
	  /* border: solid 1px red; */ 
      text-align: center;  
      width: 100%;
   }
   div#newItem{
      font-weight: bold;
      text-align: center;
      margin-top: 30px;
      font-size: 25pt;
      padding-top: 20px;
   }
   table#content2MidBox{
      display: inline-block;
      overflow:hidden;
      height: 700px;
      width: 100%;
      text-align: center;
     /* border: solid 1px green; */
   }
   table.content3MidBox{
      display: inline-block;
      height: 700px;
      width: 100%;
      text-align: center;
   /*  border: solid 1px green; */
   }
   table.content3MidBox td.content3SQ{
      overflow:hidden;
   }
   td.contentSQ{
     /* border: solid 1px yellow; */
      display: inline-block;
      text-align: center;
      width: 506px;
      height: 700px;
      overflow: hidden;
   }
    img.content2Img{
      width: 506px;
      height: 700px;
      /* border: solid 1px red;  */
    }
    img.content3Img{
      width: 506px;
      height: 700px;
      /* border: solid 1px red; */
    }
    div.subcarouselDiv{ 
      width: 506px;
      height: 700px;
     /*  border: solid 1px blue; */
    }
    .contentHover{
       opacity: 0.3;
    }
    td.contentSQ:hover{
       cursor: pointer;
       padding: 0px;
       margin: 0px;
    }
</style>


<script type="text/javascript">
function getCookie( cookieName ) { var search = cookieName + "="; var cookie = document.cookie; /* 현재 쿠키가 존재할 경우 */ if( cookie.length > 0 ) { /* 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴. */ startIndex = cookie.indexOf( cookieName ); /* 만약 존재한다면 */ if( startIndex != -1 ) { /* 값을 얻어내기 위해 시작 인덱스 조절 */ startIndex += cookieName.length; /* 값을 얻어내기 위해 종료 인덱스 추출 */ endIndex = cookie.indexOf( ";", startIndex ); /* 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정 */ if( endIndex == -1) endIndex = cookie.length; /* 쿠키값을 추출하여 리턴 */ return unescape( cookie.substring( startIndex + 1, endIndex ) ); } else { /* 쿠키 내에 해당 쿠키가 존재하지 않을 경우 */ return false; } } else { /* 쿠키 자체가 없을 경우 */ return false; } } if( !getCookie("close20090524") ){ window.open("popup.html","타이틀","left=40,top=40,width=405,height=402,resizable=no, scrollbar=no, status=no,menubar=no,toolbar=no,location=no"); }
   $(document).ready(function(){
	   $('div.subcarousel').carousel({
  		    interval: 1600,
  		    pause: false,
  		    wrap: true
  		});
       $("img.content2Img").removeClass("contentHover");
       $('img.imgPre').show();
      $('div.subcarouselDiv').hide();
       $("td.content2SQ").hover(function(){
    	   $(this).children('img.imgPre').hide();
           $(this).children('div.subcarouselDiv').show();
		   $(this).siblings().children('img.imgPre').addClass("contentHover");
       }, function(){
    	   $(this).children('img.imgPre').show();
           $(this).children('div.subcarouselDiv').hide();
    	   $(this).siblings().children('img.imgPre').removeClass("contentHover");
		}); 
       
       $("img.content3Img").removeClass("contentHover");
       $('img.imgPre').show();
      $('div.subcarouselDiv').hide();
       $("td.content3SQ").hover(function(){
    	   $(this).children('img.imgPre').hide();
           $(this).children('div.subcarouselDiv').show();
		   $(this).siblings().children('img.imgPre').addClass("contentHover");
       }, function(){
    	   $(this).children('img.imgPre').show();
           $(this).children('div.subcarouselDiv').hide();
    	   $(this).siblings().children('img.imgPre').removeClass("contentHover");
		}); 
       
       
      
      
   });
   
   // Function Declaration
   function HITNEWclick(pnum){
	   location.href="<%=request.getContextPath()%>/detailMenu/productDetailPage.up?pnum="+pnum;
   }
   function BigCarclick(decode){
	   location.href="<%=request.getContextPath()%>/detailMenu/menu.up?cnum=1&decode="+decode;
   }
</script>


<div class="container contents1" style="width: 100%; padding: 0;"> 
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img onClick="BigCarclick(10001);" src="image/banner1.jpg" alt="banner1" style="width:100%;">
      </div>

      <div class="item">
        <img onClick="BigCarclick(10002);" src="image/banner2.jpg" alt="banner2" style="width:100%;">
      </div>
    
      <div class="item">
        <img onClick="BigCarclick(10003);" src="image/banner3.jpg" alt="banner3" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>


            
           

<div id="contents2" class="contents23 subcontainer">

   
   <div id="newItem"><br>Hit Item</div>
   <br><br>
   <table id="content2MidBox" class="contentHoverGray">


	<td class="content2SQ contentSQ">
		  <img class="imgPre" onClick="HITNEWclick(16);" src="image/product/10004/FloralCurtain.jpg" alt="툴1_1" style="width:100%;">
           <div class="subcarouselDiv">
		  <div id="myCarousel1" class="subcarousel carousel slide" data-ride="carousel" >
   			<!-- Wrapper for slides -->
             <div class="carousel-inner">
               <div class="item active">
                 <img onClick="HITNEWclick(16);" src="image/product/10004/FloralCurtain_text.jpg" alt="툴1_1" style="width:100%;">
               </div>
               <div class="item">
                 <img onClick="HITNEWclick(16);" src="image/product/10004/FloralCurtain.jpg" alt="툴1_2" style="width:100%;">
               </div>
               <div class="item">
                 <img onClick="HITNEWclick(16);" src="image/product/10004/FloralCurtain_detail01.jpg" alt="툴1_1" style="width:100%;">
               </div>
             </div>
           </div>
           </div>
    </td>
         
        
      <td class="content2SQ contentSQ">
         <img class="imgPre" onClick="HITNEWclick(13);" src="image/product/10004/CheckCurtain.jpg" alt="툴1_1" style="width:100%;">
            <div class="subcarouselDiv">
          <div id="myCarousel2" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img onClick="HITNEWclick(13);" src="image/product/10004/CheckCurtain_text.jpg" alt="저장2_1" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img onClick="HITNEWclick(13);" src="image/product/10004/CheckCurtain.jpg" alt="저장2_2" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img onClick="HITNEWclick(13);" src="image/product/10004/CheckCurtain_detail01.jpg" alt="저장2_3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content2SQ contentSQ">
         <img class="imgPre" onClick="HITNEWclick(11);" src="image/product/10001/BlackCover.jpg" alt="툴1_1" style="width:100%;">
           <div class="subcarouselDiv">
           <div id="myCarousel3" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img onClick="HITNEWclick(11);" src="image/product/10001/BlackCover_text.jpg" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img onClick="HITNEWclick(11);" src="image/product/10001/BlackCover.jpg" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img onClick="HITNEWclick(11);" src="image/product/10001/BlackCover_detail.jpg" alt="옷장3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
    </table>
</div>



   <br><br>
   
   <div id="contents3" class="contents23 subcontainer">
   <div id="newItem"><br><br>New Item</div>
   <br><br>
   <table class="contentHoverGray content3MidBox">

	<tr>
	<td class="content3SQ contentSQ">
			<img class="imgPre" onClick="HITNEWclick(1);" src="image/product/10001/BlueCover.jpg" alt="툴1_1" style="width:100%;">
           <div class="subcarouselDiv">
             <div id="myCarousel4" class="subcarousel carousel slide" data-ride="carousel">

             <div class="carousel-inner">
               <div class="item active">
                 <img onClick="HITNEWclick(1);" src="image/product/10001/BlueCover_text.jpg" alt="소파1" style="width:100%;">
               </div>
               <div class="item">
                 <img onClick="HITNEWclick(1);" src="image/product/10001/BlueCover.jpg" alt="소파2" style="width:100%;">
               </div>
               <div class="item">
                 <img onClick="HITNEWclick(1);" src="image/product/10001/BlueCover_detail.jpg" alt="소파3" style="width:100%;">
               </div>
             </div>
           </div>
            </div>
   	  </td>
      <td class="content3SQ contentSQ">
		<img class="imgPre" onClick="HITNEWclick(15);" src="image/product/10004/EmbroideredCurtain.jpg" alt="툴1_1" style="width:100%;">
            <div class="subcarouselDiv">
           <div id="myCarousel5" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img onClick="HITNEWclick(15);" src="image/product/10004/EmbroideredCurtain_text.jpg" alt="테이블2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img onClick="HITNEWclick(15);" src="image/product/10004/EmbroideredCurtain.jpg" alt="테이블1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img onClick="HITNEWclick(15);" src="image/product/10004/EmbroideredCurtain_detail01.jpg" alt="테이블3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content3SQ contentSQ">
         <img class="imgPre" onClick="HITNEWclick(9);" src="image/product/10001/CheckCover.jpg"" alt="툴1_1" style="width:100%;">
        <div class="subcarouselDiv">
           <div id="myCarousel6" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img onClick="HITNEWclick(9);" src="image/product/10001/CheckCover_text.jpg" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img onClick="HITNEWclick(9);" src="image/product/10001/CheckCover.jpg" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img onClick="HITNEWclick(9);" src="image/product/10001/CheckCover_detail.jpg" alt="옷장3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
      </tr> 
    
    </table>
</div>
 <jsp:include page="footer.jsp" /> 