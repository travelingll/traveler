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

<div>
<ul class="menu">
      <li>
        <a href="#">여행목록</a>
      </li>
      <li>
        <a href="#">트래블러PICK</a>
        <ul class="submenu">
          <li><a href="#">트래블러 추천</a></li>
          <li><a href="#">사용자 맞춤 추천</a></li>

        </ul>
      </li>
      <li>
        <a href="#">트래블러클럽</a>
        <ul class="submenu">
          <li><a href="${pageContext.request.contextPath}/accom/list.do">동행구하기</a></li>
          <li><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
  
        </ul>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/event/eventList.do">이달의혜택</a>
      </li>
    </ul>
</div>

<!-- header 끝 -->