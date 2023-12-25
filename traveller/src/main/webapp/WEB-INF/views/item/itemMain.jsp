<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/itemMenu.css">
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
							    <a href="#" onclick="goMainBannerDetailLink('https://www.ybtour.co.kr/promotion/promotionDetail.yb?mstNo=20000016471&amp;subDspMenu=YBP','_self');">
								<img src="//cimgcdn.ybtour.co.kr/attachHome/HF/PR/202204/202204191140216641704002001025.jpg" alt="좋은날 좋은곳으로의 초대... SINGAPORE" onerror="YBUtil.noImage(this)">
							    </a>
							</li>
						    
							<li>
							    <a href="#" onclick="goMainBannerDetailLink('https://www.ybtour.co.kr/promotion/promotionDetail.yb?mstNo=20000015893&amp;subDspMenu=YBP','_self');">
								<img src="//cimgcdn.ybtour.co.kr/attachHome/HF/PR/202204/202204191140358431704002001036.jpg" alt="유니크하고 우아한 여행, 타이페이 스테이&amp;힐링" onerror="YBUtil.noImage(this)">
							    </a>
							</li>
						    
						  </ul>
						</div>
					<!-- //배너 리스트 -->
						
					
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>


