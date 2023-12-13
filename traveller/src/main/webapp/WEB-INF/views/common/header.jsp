<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="global_menu">
	<div class="fr">
		<ul>
			<c:if test="${!empty user_num && user_auth == 9}"> <%-- 관리자만 진입 가능 --%>
			<li>
				<a href="${pageContext.request.contextPath}/admin/main.do">관리자 페이지</a>
			</li>
			</c:if>		
			<c:if test="${empty user_num}">
			<li><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
			<li><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li>
			</c:if>
			<c:if test="${!empty user_num}">
			<li><a href="${pageContext.request.contextPath}/member/logout.do"> <span>${user_id}</span>  로그아웃</a></li>
			</c:if>
			<li><a href="${pageContext.request.contextPath}">고객센터</a></li><!-- 자주찾는 질문 페이지로 연결 > 1:1문의로 연-->
		</ul>
	</div>
</div>

<c:if test="${!empty user_num}">

</c:if>
	

<div id="main-title">
	<div class="fl">
		<a href="${pageContext.request.contextPath}/main/main.do"><img src="../upload/logo.png" width="250px"></a>
	</div>
	<ul>
	<c:if test="${!empty user_num}">
	<div class="fr">
		<div class="private_menu">
			<ul>	
				<li>
					
					<img alt="마이페이지" src="../upload/icon_mypage.svg">
					<a href="${pageContext.request.contextPath}/member/myPage.do">마이메뉴</a>
					
 				</li> 
 				<li>
 					<img alt="예약내역" src="../upload/icon_reservation.svg">
 					<a href="${pageContext.request.contextPath}">예약내역</a>
 				</li>
 				<li>
 					<img alt="예약내역" src="../upload/icon_reservationhistory.png">
 					<a href="${pageContext.request.contextPath}">장바구니</a>
 				</li>
 			</ul>
 		</div>
	 </div>
	</c:if>
	</ul>
	
</div>

<!-- header 끝 -->
<nav>
 <ul class="list-wrap" style="border-bottom: 1px solid #ddd;">
   <li class="dropdown-wrap">
   		<button onclick="location.href='#'" class="dropdown-btn">여행상품</button>
   </li>
    <li class="dropdown-wrap"><button class="dropdown-btn">트래블러PICK</button>
      <ul class="dropdown">
        <li><a href="#" class="dropdown-item">트래블러추천</a></li>
        <li><a href="#" class="dropdown-item">사용자맞춤추천</a></li>
      </ul>
   </li>
      <li class="dropdown-wrap"><button class="dropdown-btn">트래블러클럽</button>
      <ul class="dropdown">
        <li><a href="${pageContext.request.contextPath}/accom/list.do" class="dropdown-item">동행구하기</a></li>
        <li><a href="${pageContext.request.contextPath}/comm/list.do" class="dropdown-item">커뮤니티</a></li>
      </ul>
   </li>
      <li class="dropdown-wrap">
      	<button onclick="location.href='${pageContext.request.contextPath}/event/eventList.do'" class="dropdown-btn">이달의 혜택</button>
  	 </li>
 </ul>
</nav>