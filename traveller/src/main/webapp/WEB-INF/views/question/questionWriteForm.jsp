<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 작성</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<%-- 사이드 메뉴 삽입 필요 --%>
		<div class="content-main">
			<h2>일대일 문의 등록</h2>
			<form id="question_writeForm" action="questionWrite.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="user_num" value="${user_num}">
				<ul>
					<li>
						<label>카테고리</label>
						<input type="radio" name="question_category" value="1">상품
						<input type="radio" name="question_category" value="2">교환/환불
						<input type="radio" name="question_category" value="3">기타
					</li>
					<li>
						<label for="question_title">제목</label>
						<input type="text" id="question_title" name="question_title">
					</li>
					<li>
						<label for="question_content">내용</label>
						<textarea rows="5" cols="50" id="question_content" name="question_content" class="input"></textarea>
					</li>
					<li>
						<label for="question_photo">사진</label>
						<input type="file" id="question_photo" name="question_photo">
					</li>
					<c:if test="${empty user_num}">
						<li>
							<label for="question_passwd">비밀번호</label>
							<input type="password" id="question_passwd" name="question_passwd" class="input">
						</li>
					</c:if>
					<li>
						<label for="question_lock">카테고리</label>
						<input type="radio" name="question_lock" value="1">비밀글
						<input type="radio" name="question_lock" value="2">공개글
					</li>
				</ul>
				<div>
					<input type="submit" value="문의 등록">
					<input type="button" value="취소" onclick="eventList.do">
				</div>
			</form>
		</div>
	</div>
</body>
</html>