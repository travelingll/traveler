<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 게시판</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/itemMenu.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/itemSlide.css">


<script type="text/javascript">


</script>
<style type="text/css">
td{
	text-align:center;
}
a {
    color: #333;
    text-decoration: none; 
}
#lnb.lnb ul.list_lnb > li {
    border-bottom: 1px solid #ddd;
    line-height: 50px;
}
.list_lnb li{
	font-size:14px;
}

.card {
            width: 200px; /* 카드의 너비 조정 */
            margin: 200px 100px 200px 0px; /* 카드를 가운데로 정렬 */
        }
 p{
	font-size:10px;
}
</style>
</head>
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
					<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- 여기서 부터 사이드바 입니다.-->
					<div id="container">
						<div class="premium_mov">
							<video autoplay="" loop="" muted="">
								<source src="../upload/bg_pre.mp4" type="video/mp4">
							</video>
							<div class="mos_block">
								<span class="txt_p0"><img src="../upload/ico_prelogo.jpeg" alt="premium" class="ani_1"></span>
								<span class="txt_p1 ani_2">Raise your VALUE</span>
								<span class="txt_p2 ani_3">당신의 가치를 올리는 품격있는 여행이 시작됩니다.</span>	
							</div>
						</div>
						<div class="premium_area">
							<h2 class="tit_premium">The Premium</h2>
							<p class="stit_premium">품격에 프리미엄을 더하다</p>
					<!-- 배너 리스트 -->
						<div class="premium_box">
						  <ul class="premium_bnr_list bnr2">
							<li>
							    <a href="#" onclick="">
								<img src="../upload/itemMain_photo1.jpeg" alt="" >
							    </a>
							</li>
							<li>
							    <a href="#" onclick="">
								<img src="../upload/itemMain_photo2.jpeg" alt="" >
							    </a>
							</li>
						  </ul>
						</div>
					<!-- //배너 리스트 -->
					</div>
					<div id="container">
						<div class="inr">
							<div id="contents" class="contents" style="min-height:50px;">
								<div class="js_tabs type1 v-tabs">
									<ul class="tabs">
									<c:if test="${list_num == 1 }">
										<li class="selected fx-cobrand-pkg" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
										</li> 
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
										</li> 
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
										</li>
										<li class="fx-cobrand-fnd" style="width:20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
										</li>
									</c:if>
										<c:if test="${list_num == 2 }">
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
										</li> 
										<li class="selected fx-cobrand-pkg" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
										</li>
										<li class="fx-cobrand-fnd" style="width:20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
										</li>
									</c:if>
									<c:if test="${list_num == 3 }">
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
										</li> 
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
										</li>
										<li class="selected fx-cobrand-pkg" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
										</li>
										<li class="fx-cobrand-fnd" style="width:20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
										</li>
									</c:if>
									<c:if test="${list_num == 4 }">
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
										</li> 
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
										</li>
										<li class="selected fx-cobrand-pkg" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
										</li>
										<li class="fx-cobrand-fnd" style="width:20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
										</li>
									</c:if>
									<c:if test="${list_num ==5}">
										<li class="fx-cobrand-htl" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
										</li> 
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
										</li>
										<li class="fx-cobrand-fnd" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
										</li>
										<li class="selected fx-cobrand-pkg" style="width: 20%;">
											<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
										</li>
									</c:if>
									</ul>
								</div>
							</div>
						</div>
						
						
						
						
						<div class="premium_area">
							<div class="premium_slide">
								<div class="psl_title">
									<div class="slide_title">
										<h2 class="tit">Something just <br> for You</h2>
										<p class="stit">오직 당신만을 위한 <br> 특별한 프리미엄 추천 여행!</p>
									</div>
								</div>
								
						<!-- 상품리스트 -->
						
						 		 <div class="psl_area">
						 		 	
						 		 
									<div class="bx-wrapper" style="max-width: 100%;">
									
										<div class="bx-viewport" aria-live="polite" style="width: 115%; overflow: hidden; position: relative; height: 410px;">
											<ul class="psl_catalog main_slides" style="width: 6215%; position: relative; transition-duration: 0.5s; transform: translate3d(0px, 0px, 0px);">
												<c:forEach var="item" items="${sampleList}" varStatus="status">
												 <c:if test="${status.index < 3 && item.item_st1==list_num}">
												<li style="float: left; list-style: none; position: relative; width: 875px;" class="bx-clone" aria-hidden="true">
						       						<a href="${pageContext.request.contextPath}/item/itemMiddle.do?item_case=${item.item_case}&list_num=${item.item_st1}">
						            					<span class="thumb_pic">
						            						<span class="tag">
						            							<span class="tag_square pkg">  
						            								<span>해외 패키지</span>
						            							</span>
						            							<span class="tag_square pre">
						            								<span>프리미엄</span>
						            							</span>
						            						</span>
						                					<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" alt="상품이미지" onerror="YBUtil.noImage(this)">
						          							
						            					</span>
						            					<span class="premium_pdt">	  
						            						<span class="pdt_tit ellipsis2">${item.item_name}</span>                      		
							      	    					<span class="pdt_num">${item.item_content}</span>
							            					
						            					</span>
						       						</a>
						      					</li>
						      					</c:if>
												</c:forEach>
											</ul>	
										</div>
							
									<div class="bx-controls bx-has-controls-direction"><div class="bx-controls-direction"><a class="bx-prev" href="">Prev</a><a class="bx-next" href="">Next</a>
									</div>
								</div>
							</div>
						<!-- //상품리스트 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
					

</body>






 
</html> 