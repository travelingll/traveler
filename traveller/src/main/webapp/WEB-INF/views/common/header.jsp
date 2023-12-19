<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header 끝 -->
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
					<div id="wrap">
						<div><!----> 
							<div id="gnb_wrap" class="gnb_wrap">
								<div class="inr">
									<div class="global_menu_wrap">
										<div class="fl"></div> 
										<div class="fr">
											<ul>
												<c:if test="${empty user_num}">
												<li><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
												<li><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li> 
												</c:if>
												<c:if test="${!empty user_num && user_auth == 9}">
												<li><a href="${pageContext.request.contextPath}/admin/main.do">관리자 페이지</a></li>
												</c:if>
												<c:if test="${!empty user_num}">
												<li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
												</c:if>
												<li><a href="${pageContext.request.contextPath}/faq/list.do" class="">고객센터</a></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="inr">
									<div class="local_menu_wrap">
										<div class="fl">
											<h1 class="logo">
												<a href="${pageContext.request.contextPath}/main/main.do">
													<img src="../upload/logo.png" width="250px" style="margin-bottom:21px;">
												</a>
											</h1>
										</div> 
									<c:if test="${!empty user_num}">
									<div class="fr">
										<div class="private_menu">
											<ul>
												<li>
												<a href="${pageContext.request.contextPath}/member/myPage.do" class="link_my">

													마이메뉴
												</a>
													<div class="my_menu_wrap">
														<div class="inr">
															<p class="tit"> 마이메뉴는 <br> <strong>회원 전용</strong> 메뉴 입니다.</p> 
															<a href="#" class="btn em">로그인</a> 
															<a href="#" class="btn em">회원가입</a>
														</div> <!---->
													</div>
												</li> 
												<li><a href="${pageContext.request.contextPath}" class="link_reservation">예약내역</a></li>
												<li><a href="${pageContext.request.contextPath}/cart/list.do" class="link_choice">장바구니</a></li>
											</ul>
										</div>
									</div>
									</c:if>
							</div>
						</div> 
						<div class="inr">
							<div class="gnb_menu_wrap">
								<div class="cont_left">
									<div>
										<div class="cont_left"> 
										</div>
									</div> 
									<div>
										<ul id="main-menu" class="list_gnb_menu">
											<li>
												<a href="${pageContext.request.contextPath}/item/itemMain.do" class="dropdown-btn">여행상품</a>
												<div>
												</div>
											</li>
											<li>
												<a href="">트래블러PICK</a>
													<ul id="sub-menu">
														
														<li ><a href="${pageContext.request.contextPath}" >트래블러추천</a></li>
														<li style="margin-left:20px;"><a href="${pageContext.request.contextPath}/recommend/userRecommend.do">사용자맞춤추천</a></li>
													</ul>
												<div>
												</div>
											</li>
											<li>
												<a href="${pageContext.request.contextPath}/comm/list.do">트래블러클럽</a>
													<ul id="sub-menu">
														
														<li ><a href="${pageContext.request.contextPath}/accom/list.do" >동행구하기</a></li>
														<li style="margin-left:20px;"><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
													</ul>
												<div>
												</div>
											</li>
										</ul>
									</div>
								</div> 
								<div class="cont_right">
									<ul class="list_special">
										<li><a href="${pageContext.request.contextPath}/event/eventList.do">이달의 혜택</a></li> 
									</ul> 
								</div>
							</div>
						</div> 
					</div>
				</div> 
			</div>
		</div> <!----> 
		<div id="printArea">
		</div> 
		<div class="dialog-wrapper">
	</div>
</div>
</div>
</div>
</body>

