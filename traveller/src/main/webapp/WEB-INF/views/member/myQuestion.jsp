<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
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
		<h2>1:1 문의</h2>
		<hr size="2" color="black">
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
			</tr>
			<c:forEach var="question" items="${questionList}">
			<tr>
				<td><a href="${pageContext.request.contextPath}/question/detail.do?comm_num=${question.question_num}">${question.question_title}</a></td>
				<td>${question.question_regdate}</td>
			</tr>
			</c:forEach>
		</table>
		</c:if>
	</div>
</div>
</body>
</html>

