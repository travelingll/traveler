<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주찾는 질문 게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<form id="wirte_form" action="write.do" method="post">
		<ul>
			<li>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" class="faq_category">
			</li>
			<li>
				<label for="content">내용</label>
				<textarea rows="5" cols="30" name="content" id="content"></textarea>
			</li>
			<li>
				<label for="category">카테고리</label>
				<input type="radio" name="category" id="category" class="question_category" value="1">[상품예약.결제]
				<input type="radio" name="category" id="category2" class="question_category" value="2">[해외패키지]
				<input type="radio" name="category" id="category3" class="question_category" value="3">[개인정보변경]
			</li>
		</ul>
		<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
		</div>
	</form>
	</div>
</div>
</body>
</html>
