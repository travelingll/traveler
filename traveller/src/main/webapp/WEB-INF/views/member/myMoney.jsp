<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
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
		<h2>적립금</h2>
		<hr size="2" color="black">
		<c:if test="${count == 0}">
		<div class="result-display">
			적립금이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<div class="mypage-div1 align-center color">
			${member.name}님의 사용가능한 적립금은<br>
			총 <b><fmt:formatNumber value="${money_total}"/>원</b> 입니다.
		</div>
		<div class="mypage-div2 align-center">
			<table>
				<tr>
					<th>적립금액</th>
					<th>내역</th>
					<th>적립일</th>
				</tr>
				<tr>
					<td><fmt:formatNumber value="${money.saved_money}"/>원</td>
					<td>${money.sm_content}</td>
					<td>${money.sm_date}</td>
				</tr>
			</table>
		</div>
		</c:if>
	</div>
</div>
</body>
</html>

