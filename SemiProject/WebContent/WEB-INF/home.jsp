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
      height: 600px;
      width: 100%;
      text-align: center;
     /* border: solid 1px green; */
   }
   table.content3MidBox{
      display: inline-block;
      height: 600px;
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
      height: 600px;
      overflow: hidden;
   }
    img.content2Img{
      width: 506px;
      height: 600px;
      /* border: solid 1px red;  */
    }
    img.content3Img{
      width: 506px;
      height: 600px;
      /* border: solid 1px red; */
    }
    img.bigImg{
      overflow: hidden;
      display: inline-block;
      height: 600px !important;
    
    }
    div.subcarouselDiv{ 
      width: 506px;
      height: 600px;
     /*  border: solid 1px blue; */
    }
    .contentHoverGray{
       background-color: #333333;

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
   
   $(document).ready(function(){

		$('div.subcarousel').carousel({
		    interval: 1600,
		    pause: false,
		    wrap: true
		});
		
		
       $("div.subcarouselDiv").hide();
       $("img.content2Img").removeClass("contentHover");
       $("table#content2MidBox").removeClass("contentHoverGray");

       $("div.subcarouselDiv").hide();
       $("img.content3Img").removeClass("contentHover");
       $("table.content3MidBox").removeClass("contentHoverGray");
       
       
      $("td.content2SQ").hover(function(){
          $("img.content2Img").addClass("contentHover");
          $(this).children("img.content2Img").removeClass("contentHover");
          $("table#content2MidBox").addClass("contentHoverGray");
          $(this).children("img.content2Img").hide();
          $(this).children("div.subcarouselDiv").show();
      }, function(){
         $("img.content2Img").removeClass("contentHover");
          $("table#content2MidBox").removeClass("contentHoverGray");
         $(this).children("img.content2Img").show();
         $(this).children("div.subcarouselDiv").hide();
      });   
         
         $("td.content3SQ").hover(function(){
             $("img.content3Img").addClass("contentHover");
             $(this).children("img.content3Img").removeClass("contentHover");
             $("table.content3MidBox").addClass("contentHoverGray");
             $(this).children("img.content3Img").hide();
             $(this).children("div.subcarouselDiv").show();
         }, function(){
            $("img.content3Img").removeClass("contentHover");
             $("table.content3MidBox").removeClass("contentHoverGray");
            $(this).children("img.content3Img").show();
            $(this).children("div.subcarouselDiv").hide();       
         
         
         
      });
      
      
      $("td.content2SQ").click(function(){

         location.href="<%=request.getContextPath()%>/main/content2.up";
      });
   });
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
        <img src="image/banner1.jpg" alt="banner1" style="width:100%;">
      </div>

      <div class="item">
        <img src="image/banner2.jpg" alt="banner2" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="image/banner3.jpg" alt="banner3" style="width:100%;">
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

   
   <div id="newItem"><br>HIT ITEM</div>
   <br><br>
   <table id="content2MidBox" class="contentHoverGray">


	<td class="content2SQ contentSQ">

         <img class="content2Img content2Hover" id="content2Img1" src="image/product/30003/tool_01_01.jpg" alt="툴1">    

           <div class="subcarouselDiv">
           <div id="myCarousel1" class="subcarousel carousel slide" data-ride="carousel" >
   			<!-- Wrapper for slides -->
             <div class="carousel-inner">
               <div class="item active">
                 <img class="bigImg" src="image/product/30003/tool_01_02.jpg" alt="툴1_1" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/30003/tool_01_03.jpg" alt="툴1_2" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/30003/tool_01_04.jpg" alt="툴1_1" style="width:100%;">
               </div>
             </div>
           </div>
           </div>
   </td>
         
        
      <td class="content2SQ contentSQ">
         <img class="content2Img content2Hover" id="content2Img2" src="image/product/30002/storage_02_01.jpg" alt="저장2">    
           <div class="subcarouselDiv">
           <div id="myCarousel2" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/30002/storage_02_02.jpg" alt="저장2_1" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/30002/storage_02_03.jpg" alt="저장2_2" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/30002/storage_02_04.jpg" alt="저장2_3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content2SQ contentSQ">
         <img class="content2Img content2Hover" id="content2Img1" src="image/product/30001/furniture_09_02.jpg" alt="옷장1">    
           <div class="subcarouselDiv">
           <div id="myCarousel3" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/30001/furniture_09_01.jpg" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_09_03.jpg" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_09_04.jpg" alt="옷장3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
    </table>
</div>



   <br><br>
<div id="contents3" class="contents23 subcontainer">
   <div id="newItem"><br><br>NEW ITEM</div>
   <br><br>
   <table class="contentHoverGray content3MidBox">

	<tr>
	<td class="content3SQ contentSQ">

         <img class="content3Img contentHover" id="content3Img1" src="image/product/20004/carpet_01_01.JPG" alt="소파1">    
           <div class="subcarouselDiv">
             <div id="myCarousel4" class="subcarousel carousel slide" data-ride="carousel">

             <!-- Wrapper for slides -->
             <div class="carousel-inner">
               <div class="item active">
                 <img class="bigImg" src="image/product/20004/carpet_01_02.JPG" alt="소파1" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/20004/carpet_02_01.JPG" alt="소파2" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/20004/carpet_02_02.JPG" alt="소파3" style="width:100%;">
               </div>
             </div>
           </div>
            </div>
   	  </td>
      <td class="content3SQ contentSQ">
         <img class="content3Img contentHover" id="content3Img2" src="image/product/20003/cabinet_01_01.JPG" alt="테이블1">    
           <div class="subcarouselDiv">
           <div id="myCarousel5" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/20003/cabinet_01_02.JPG" alt="테이블2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/20003/cabinet_02_01.JPG" alt="테이블1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/20003/cabinet_02_02.JPG" alt="테이블3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content3SQ contentSQ">
         <img class="content3Img contentHover" id="content3Img3" src="image/product/30001/furniture_05_02.jpg" alt="옷장1">    
           <div class="subcarouselDiv">
           <div id="myCarousel6" class="subcarousel carousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/30001/furniture_05_01.jpg" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_05_03.jpg" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_05_04.jpg" alt="옷장3" style="width:100%;">
                  </div>
                </div>
            </div>
            </div>
         </td>
      </tr> 
    
    <!-- <tr>
		<td class="content3SQ contentSQ">

         <img class="content3Img contentHover" id="content3Img1" src="image/product/30003/tool_04_01.jpg" alt="소파1">    
           <div class="subcarouselDiv">
             <div id="myCarousel4" class="carousel slide" data-ride="carousel">

             Wrapper for slides
             <div class="carousel-inner">
               <div class="item active">
                 <img class="bigImg" src="image/product/30003/tool_04_02.jpg" alt="소파1" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/30003/tool_04_03.jpg" alt="소파2" style="width:100%;">
               </div>
               <div class="item">
                 <img class="bigImg" src="image/product/30003/tool_04_04.jpg" alt="소파3" style="width:100%;">
               </div>
             </div>
         
             Left and right controls
             <a class="left carousel-control" href="#myCarousel4" data-slide="prev">
               <span class="sr-only">Previous</span>
             </a>
             <a class="right carousel-control" href="#myCarousel4" data-slide="next">
               <span class="sr-only">Next</span>
             </a>
           </div>
            </div>
   </td>
         
        
      <td class="content3SQ contentSQ">
         <img class="content3Img contentHover" id="content3Img2" src="image/product/30002/storage_13_01.jpg" alt="테이블1">    
           <div class="subcarouselDiv">
           <div id="myCarousel5" class="subcarousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/30002/storage_13_03.jpg" alt="테이블2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/30002/storage_13_05.jpg" alt="테이블1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/30002/storage_13_04.jpg" alt="테이블3" style="width:100%;">
                  </div>
                </div>
      
               
                <a class="left carousel-control" href="#myCarousel5" data-slide="prev">
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel5" data-slide="next">
                  <span class="sr-only">Next</span>
                </a>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content3SQ contentSQ">
         <img class="content3Img contentHover" id="content3Img3" src="image/product/30001/furniture_21_02.jpg" alt="옷장1">    
           <div class="subcarouselDiv">
           <div id="myCarousel6" class="subcarousel slide" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img class="bigImg" src="image/product/30001/furniture_21_01.jpg" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_22_01.jpg" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img class="bigImg" src="image/product/30001/furniture_22_02.jpg" alt="옷장3" style="width:100%;">
                  </div>
                </div>
      
               
                <a class="left carousel-control" href="#myCarousel6" data-slide="prev">
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel6" data-slide="next">
                  <span class="sr-only">Next</span>
                </a>
            </div>
            </div>
         </td>
      </tr>  -->
    </table>
</div>






 <jsp:include page="footer.jsp" /> 