<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 작성</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript">
		window.onload = function(){
			let writeForm = document.getElementById('question_writeForm');
			writeForm.onsubmit = function(){
				//카테고리 유효성 검사
				let category = document.querySelectorAll('.question_category');
				flag = false;
				for(let i=0;i<category.length;i++){
					if(category[i].checked) flag = true;
				}
				if(!flag){
					alert('카테고리를 선택해주세요!');
					return false;
				}
				//입력란 유효성 검사
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
				//잠금유무 유효성 검사
				let lock = document.querySelectorAll('.question_lock');
				flag = false;
				for(let i=0;i<lock.length;i++){
					if(lock[i].checked) flag = true;
				}
				if(!flag){
					alert('비밀글을 설정해주세요!');
					return false;
				}
			};
		};
	</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="question_sidemenu.jsp"/>
		<div class="content-main">
			<h2>일대일 문의 등록</h2>
			<form id="question_writeForm" action="userQuestionWrite.do?question_num=${question_num}" method="post" enctype="multipart/form-data">
				<input type="hidden" name="user_num" value="${user_num}">
				<ul>
					<li>
						<label>카테고리</label>
						<input type="radio" name="question_category" class="question_category" value="1">상품
						<input type="radio" name="question_category" class="question_category" value="2">교환/환불
						<input type="radio" name="question_category" class="question_category" value="3">기타
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
							<input type="password" id="question_passwd" name="question_passwd">
						</li>
					</c:if>
					<li>
						<label for="question_lock">잠금 유무</label>
						<input type="radio" name="question_lock" class="question_lock" value="1">공개글
						<input type="radio" name="question_lock" class="question_lock" value="2">비밀글
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="문의 등록">
				</div>
			</form>
		</div>
	</div>
</body>
</html>