<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 작성</title>
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
						<label for="question_title">제목</label>
						<input type="text" id="question_title" name="question_title">
					</li>
					
				</ul>
			</form>
		</div>
	</div>
</body>
</html>