<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/totalMenu.css">
<!-- jQuery 라이브러리를 불러옵니다. -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- 스크립트 시작 -->
<script>
  $(document).ready(function(){
    // 초기에 드롭다운을 닫힌 상태로 설정
    $('.list_total_menu').removeClass('on');

    // "전체메뉴"를 클릭했을 때 이벤트 처리
    $('.btn_menu_all.js_act.on').on('click', function(){
      // 드롭다운을 토글 (열린 경우 닫히고, 닫힌 경우 열리도록)
      $('.list_total_menu').toggleClass('on');
    });

    // "닫기"를 클릭했을 때 이벤트 처리
    $('.btn_cls.js_act').on('click', function(){
      // 드롭다운을 닫기
      $('.list_total_menu').removeClass('on');
    });
  });
</script>
<!-- 스크립트 끝 -->

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/totalMenu.css">


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
												<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 페이지</a></li>
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
												<li><a href="${pageContext.request.contextPath}/member/myPage.do" class="link_my">마이메뉴</a></li> 
												<li><a href="${pageContext.request.contextPath}/order/myOrderList.do" class="link_reservation">예약내역</a></li>
												<li><a href="${pageContext.request.contextPath}/cart/list.do" class="link_choice">장바구니</a></li>
											</ul>
										</div>
									</div>
								</c:if>
								<c:if test="${empty user_num}">
									<div class="fr">
										<div class="private_menu">
											<ul>
												<li><a href="${pageContext.request.contextPath}/member/loginForm.do" class="link_my">마이메뉴</a></li> 
												<li><a href="${pageContext.request.contextPath}/member/loginForm.do" class="link_reservation">예약내역</a></li>
												<li><a href="${pageContext.request.contextPath}/member/loginForm.do" class="link_choice">장바구니</a></li>
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
												<a href="#none" class="btn_menu_all js_act on" >전체메뉴</a>
													<div class="list_total_menu n_total on">
														<div class="inr">
															<a href="#" class="btn_cls js_act">닫기</a>
												<div class="ly_wrap">
													<div class="inr bundle">
														<div class="group_list">
																	<dl>
																		<dt>
																			<a href="${pageContext.request.contextPath}/item/itemMain.do" onclick="">여행상품</a>
																		</dt>
																		<dd>
																			<ul>
																				<li>
																					<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
																				</li>
															
																			</ul>
																		</dd>
																	</dl>
																</div>
																<div class="group_list">
																	<dl>
																		<dt>
																			<a href="${pageContext.request.contextPath}/recommend/adminRecommend.do" onclick="">트래블러PICK</a>
																		</dt>
																		<dd>
																			<ul>
																				<li>
																					<a href="${pageContext.request.contextPath}/recommend/adminRecommend.do" onclick="">트래블러추천</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/recommend/userRecommend.do">사용자맞춤추천</a>
																				</li>
																				<li>
																				<a href="#none"></a>
																				</li>
																				<li>
																				<a href="#none"></a>
																				</li>
																				<li>
																				<a href="#none"></a>
																				</li>
																			</ul>
																		</dd>
																	</dl>
																	
																</div>
																<div class="group_list">
																	<dl>
																		<dt>
																			<a href="${pageContext.request.contextPath}/comm/list.do" onclick="">트래블러클럽</a>
																		</dt>
																		<dd>
																			<ul>
																				<li>
																					<a href="${pageContext.request.contextPath}/accom/list.do" onclick="">동행구하기</a>
																				</li>
																				<li>
																					<a href="${pageContext.request.contextPath}/comm/list.do" onclick="">커뮤니티</a>
																				</li>
																				<li>
																					<a href="#none"></a>
																				</li>
																				<li>
																					<a href="#none"></a>
																				</li>
																				<li>
																					<a href="#none"></a>
																				</li>
																			</ul>
																		</dd>
																	</dl>
																</div>
															<div>
														</div>
													</div>
												</div>
											</div>
										</div> 
										<div>
											<ul id="main-menu" class="list_gnb_menu">
											<li >
												<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1" class="dropdown-btn">여행상품</a>
												<div>
												</div>
											</li>
											<li>
												<a href="${pageContext.request.contextPath}/recommend/userRecommend.do" class="dropdown-btn" style="pointer-events : auto;">트래블러PICK</a>
												
												<div>
												</div>
											</li>
											<li>
												<a href="${pageContext.request.contextPath}/comm/list.do" class="dropdown-btn">트래블러클럽</a>
												
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
		</div>
	</div>





