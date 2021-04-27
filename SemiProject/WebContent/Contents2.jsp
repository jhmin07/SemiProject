<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="contents1.jsp" />   
<style type="text/css">
   
   div#contents2{      
      display: inline-block;
      background-color: #d9d9d9;
      text-align: center;
      padding-bottom: 50px;
           
   }
   div.subcontainer{
      text-align: center;
      background-color: white;   
      width: 100%;
   }
   div#newItem{
      font-weight: bold;
      text-align: center;
      margin-top: 30px;
      font-size: 18pt;
      padding: 20px 0px;
      background-color: #d9d9d9;
   }
   table#content2MidBox{
      overflow:hidden;
      height: 390px;
      width: 100%;
		/* border: solid 1px green; */
      text-align: center;
   }
   td.content2SQ{
  	/*  border: solid 1px yellow; */
      display: inline-block;
      text-align: center;
      margin-left: 20px;
      margin-right: 20px;
      width: 560px;
      height: 420px;
      padding-top: 30px;
   }
    img.content2Img{
      width: 480px;
      height: 360px;
      /* border: solid 1px red; */
    }
    div.subcarousel img{
      width: 560px;
      height: 420px;
    
    }
    div.subcarouselDiv{ 
      width: 560px;
      height: 420px;
     /*  border: solid 1px blue; */
    }
    .content2HoverGray{
       background-color: #333333;

    }
    .content2Hover{
       opacity: 0.7;
    }
    td.content2SQ:hover{
       cursor: pointer;
      padding-top: 0px;
    }
</style>

<script type="text/javascript">
   /* $(".subcarousel").carousel({
       interval: 10
   }); */
   
   $(document).ready(function(){
       $("div.subcarouselDiv").hide();
       $("img.content2Img").removeClass("content2Hover");
       $("table#content2MidBox").removeClass("content2HoverGray");
       
       
      $("td.content2SQ").hover(function(){
          $("img.content2Img").addClass("content2Hover");
          $(this).children("img.content2Img").removeClass("content2Hover");
          $("table#content2MidBox").addClass("content2HoverGray");
          $(this).children("img.content2Img").hide();
          $(this).children("div.subcarouselDiv").show();
      }, function(){
         $("img.content2Img").removeClass("content2Hover");
          $("table#content2MidBox").removeClass("content2HoverGray");
         $(this).children("img.content2Img").show();
         $(this).children("div.subcarouselDiv").hide();
      });
      
      
      $("td.content2SQ").click(function(){

         location.href="<%=request.getContextPath()%>/main/content2.up";
      });
   });
</script>


   
<div id="contents2" class="subcontainer">

   <div id="newItem">NEW ITEM</div>
   <table id="content2MidBox" class="content2HoverGray">
      <td class="content2SQ">
         <img class="content2Img content2Hover" id="content2Img1" src="imagesContents2/sofa01.jpeg" alt="소파1">    
           <div class="subcarouselDiv">
             <div id="myCarousel" class="carousel slide" data-ride="carousel">
             <!-- Wrapper for slides -->
             <div class="carousel-inner">
               <div class="item active">
                 <img src="imagesContents2/sofa01.jpeg" alt="소파1" style="width:100%;">
               </div>
               <div class="item">
                 <img src="imagesContents2/sofa02.jpeg" alt="소파2" style="width:100%;">
               </div>
               <div class="item">
                 <img src="imagesContents2/sofa03.jpg" alt="소파3" style="width:100%;">
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
         </td>
         
         
         
         
        
      <td class="content2SQ">
         <img class="content2Img content2Hover" id="content2Img2" src="imagesContents2/table01.jpg" alt="테이블1">    
           <div class="subcarouselDiv">
           <div id="myCarousel2" class="subcarousel" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img src="imagesContents2/table01.jpg" alt="테이블2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img src="imagesContents2/table02.jpg" alt="테이블1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img src="imagesContents2/table03.JPG" alt="테이블3" style="width:100%;">
                  </div>
                </div>
      
               
                <a class="left carousel-control" href="#myCarousel2" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel2" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right"></span>
                  <span class="sr-only">Next</span>
                </a>
            </div>
            </div>
         </td>
         
         
         
         
         
      <td class="content2SQ">
         <img class="content2Img content2Hover" id="content2Img1" src="imagesContents2/closet01.JPG" alt="옷장1">    
           <div class="subcarouselDiv">
           <div id="myCarousel3" class="subcarousel" data-ride="carousel">
               <div class="carousel-inner">
                  <div class="item active">
                    <img src="imagesContents2/closet01.JPG" alt="옷장2" style="width:100%;">
                  </div>
      
                  <div class="item">
                    <img src="imagesContents2/closet02.JPG" alt="옷장1" style="width:100%;">
                  </div>
                
                  <div class="item">
                    <img src="imagesContents2/closet03.JPG" alt="옷장3" style="width:100%;">
                  </div>
                </div>
      
               
                <a class="left carousel-control" href="#myCarousel3" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel3" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right"></span>
                  <span class="sr-only">Next</span>
                </a>
            </div>
            </div>
         </td>
    </table>
</div>



<jsp:include page="footer.jsp" />  