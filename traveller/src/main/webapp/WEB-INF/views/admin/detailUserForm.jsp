<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정(관리자 전용)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="side-menu">
		<ul>
	 		<li><a href="${pageContext.request.contextPath}/admin/main.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">관리자 페이지</a></li>
	  		<li><a href="${pageContext.request.contextPath}/admin/itemList.do">관리자 상품 게시판</a></li>
	 		<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
	 		<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
		</ul>
	</div>
	<div class="content-main">
		<h2>${member.id}의 회원정보 (관리자 전용)</h2>
		<hr size="2" color="black">
		<form action="detailUser.do" method="post" id="detail_form">
			<input type="hidden" name="mem_num" value="${member.mem_num}">
			<ul>
				<li>
					<label>등급</label>
					<c:if test="${member.auth != 9}">
					<input type="radio" name="auth" value="0" id="auth1"<c:if test="${member.auth == 0}">checked</c:if>>탈퇴
					<input type="radio" name="auth" value="1" id="auth2"<c:if test="${member.auth == 1}">checked</c:if>>VVIP
					<input type="radio" name="auth" value="2" id="auth3"<c:if test="${member.auth == 2}">checked</c:if>>VIP
					<input type="radio" name="auth" value="3" id="auth4"<c:if test="${member.auth == 3}">checked</c:if>>일반
					</c:if>
					<c:if test="${member.auth == 9}">
					<input type="radio" name="auth" value="9" id="auth5" checked>관리
					</c:if>
				</li>
			</ul>
			<div class="align-center">
				<c:if test="${member.auth != 9}">
				<input type="submit" value="수정">
				</c:if>
				<input type="button" value="목록" onclick="location.href='userList.do'">
			</div>
			<ul>
				<li>
					<label>이름</label>${member.name}
				</li>
				<li>
					<label>전화번호</label>${member.phone}
				</li>
				<li>
					<label>이메일</label>${member.email}
				</li>
				<li>
					<label>우편번호</label>${member.zipcode}
				</li>
				<li>
					<label>주소</label>${member.address1} ${member.address2}
				</li>
			</ul>
		</form>
	</div>
</div>
</body>
</html>