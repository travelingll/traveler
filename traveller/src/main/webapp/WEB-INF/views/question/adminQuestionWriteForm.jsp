<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[관리자] 일대일 문의 작성</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript">
		window.onload = function(){
			let writeForm = document.getElementById('question_writeForm');
			writeForm.onsubmit = function(){
				let input = document.querySelectorAll('.input');
				for(let i=0;i<input.length;i++){
					let label = document.querySelector('label[for="'+input[i].id+'"]');
					if(input[i].value.trim()==''){
						alert(label.textContent+' 항목을 입력해주세요!');
						input[i].value='';
						input[i].focus();
						return false;
					}
				}
			};
		};
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container"><div class="inr"><jsp:include page="question_sidemenu.jsp"/></div></div>
	<div id="containerr" style="display: flex;">
	    <div id="sidebar" style="width: 80%;">
			<h2 class="detail-center form-title">[관리자] 일대일 문의 답변 등록</h2>
			<form class="detail-form" id="question_writeForm" action="adminQuestionWrite.do" method="post">
				<input type="hidden" value="${question.question_num}" name="question_num" id="question_num">
				<ul class="input-form">
					<li>
						<label for="question_title">제목</label>
						<input type="text" id="question_title" name="question_title" value="고객님 문의 답변드립니다 :)">
					</li>
					<li>
						<label for="question_content">답변</label>
						<textarea rows="5" cols="50" id="question_content" name="question_content" class="input"></textarea>
					</li>
				</ul>
				<div class="file-right">
					<input type="submit" value="답변 등록">
				</div>
			</form>
		</div>
	</div>
</body>
</html>