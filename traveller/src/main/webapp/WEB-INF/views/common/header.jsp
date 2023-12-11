<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<div id="main_logo">
	<h1 class="align-center"><a href="${pageContext.request.contextPath}/main/main.do">트래블러</a></h1>
	<ul>
		<c:if test="${!empty user_num}">
		<li><a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a></li>
		<li><a href="${pageContext.request.contextPath}">장바구니</a></li>
		<li class="menu-logout">
			[<span>${user_id}</span>]
			<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
		</c:if>
		<c:if test="${empty user_num}">
		<li><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li>
		<li><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
		</c:if>
	</ul>
</div>
<div id="main_nav">
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}">여행목록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}">자주 찾는 질문</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}">동행구하기</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/event/eventList.do">이벤트</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}">일대일문의</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}">트래블러 추천</a>
		</li>
				
		<li>
			<a href="${pageContext.request.contextPath}">사용자 맞춤 추천</a>
		</li>
		<c:if test="${!empty user_num && user_auth == 9}"> <%-- 관리자만 진입 가능 --%>
			<li>
				<a href="${pageContext.request.contextPath}">관리자 페이지</a>
			</li>
		</c:if>		
	</ul>
</div>
<!-- header 끝 -->



