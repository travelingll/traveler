<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="side-menu">
		<ul>
 			<li><a href="${pageContext.request.contextPath}/member/myPage.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">마이페이지</a></li>
  			<li><a href="${pageContext.request.contextPath}/member/myPage.do">개인정보</a></li>
 			<li><a href="${pageContext.request.contextPath}/member/myWriteComm.do">내가 쓴 글</a></li>
 			<li><a href="${pageContext.request.contextPath}/member/myQuestion.do">1:1 문의</a></li>
 			<li><a href="${pageContext.request.contextPath}/member/myMoney.do">적립금</a></li>
 			<li><a>동행 신청내역</a></li>
		</ul>
	</div>
	<div class="content-main">
		<h2>내가 쓴 글 : 동행게시판</h2>
		<hr size="2" color="black">
		<div style="text-align:center;">
			<ul>
				<li style="display:inline-block;"><a href="${pageContext.request.contextPath}/member/myWriteComm.do">커뮤니티</a></li>
				<li style="display:inline-block;"><a href="${pageContext.request.contextPath }/member/myWriteAccom.do">동행게시판</a></li>
				<li style="display:inline-block;"><a>후기글</a></li>
			</ul>
		</div>		
		<div>
		<c:if test="${!empty user_num && !empty user_photo}">
		<img src="${pageContext.request.contextPath}/upload/${user_photo}" width="100" height="120" class="my-photo">
		${member.name}
		<c:if test="${member.auth == 3}"><b>등급 : 일반</b></c:if>
		<c:if test="${member.auth == 2}"><b>등급 : VIP</b></c:if>
		<c:if test="${member.auth == 1}"><b>등급 : VVIP</b></c:if>
		<c:if test="${member.auth == 9}"><b>등급 : 관리자</b></c:if>
		</c:if>
		<c:if test="${!empty user_num && empty user_photo}">
		<img src="${pageContext.request.contextPath}/images/face.jpg" width="100" height="120" class="my-photo">
		<br>${member.name}<br>
		<c:if test="${member.auth == 3}"><b>등급 : 일반</b></c:if>
		<c:if test="${member.auth == 2}"><b>등급 : VIP</b></c:if>
		<c:if test="${member.auth == 1}"><b>등급 : VVIP</b></c:if>
		<c:if test="${member.auth == 9}"><b>등급 : 관리자</b></c:if>
		</c:if>
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="accom" items="${accomList}">
			<tr>
				<td><a href="${pageContext.request.contextPath}/accom/detail.do?accom_num=${accom.accom_num}">${accom.accom_title}</a></td>
				<td>${accom.accom_regdate}</td>
				<td>${accom.accom_hit}</td>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>

