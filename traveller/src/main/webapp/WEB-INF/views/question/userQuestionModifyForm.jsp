<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 수정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(function(){
			let modifyForm = document.getElementById('question_modifyForm');
			modifyForm.onsubmit = function(){
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
			};//end of on submit
		});
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="detail-sidemenu"><jsp:include page="question_sidemenu.jsp"/></div>
	<div class="detail-page">
		<div class="detail-content">
			<h2 class="detail-center">일대일 문의 수정</h2>
			<form class="detail-form" id="question_modifyForm" action="userQuestionModify.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="question_num" value="${detail.question_num}">
				<ul class="input-form">
					<li>
						<label>카테고리</label>
						<input type="radio" name="question_category" class="question_category" value="1" <c:if test="${detail.question_category==1}">checked</c:if>> 상품
						<input type="radio" name="question_category" class="question_category" value="2" <c:if test="${detail.question_category==2}">checked</c:if>> 교환/환불
						<input type="radio" name="question_category" class="question_category" value="3" <c:if test="${detail.question_category==3}">checked</c:if>> 기타
					</li>
					<li>
						<label for="question_title">제목</label>
						<input type="text" id="question_title" name="question_title" value="${detail.question_title}">
					</li>
					<li>
						<label for="question_content">내용</label>
						<textarea rows="5" cols="50" id="question_content" name="question_content" class="input"> ${detail.question_content}</textarea>
					</li>
					<li>
						<label for="question_photo">사진</label>
						<input type="file" id="question_photo" name="question_photo">
						<c:if test="${!empty detail.question_photo}">
							<div>
								${detail.question_photo} 사진이 등록되어 있습니다!
								<input type="button" value="파일 삭제" id="delete_photo">
							</div>
							<script type="text/javascript">
								$('#delete_photo').click(function(){
									$.ajax({
										url: 'deletePhoto.do',
										type: 'post',
										data: {'question_num':${detail.question_num}},
										dataType: 'json',
										success: function(param){
											if(param.result=='logout'){
												alert('로그인이 필요합니다!');
											} else if(param.result=='wrongAccess'){
												alert('회원글의 경우 작성자 본인만 글 삭제가 가능합니다!');
											} else if(param.result=='success'){
												alert('사진 파일 삭제를 완료했습니다!');
											} else{
												alert('사진 삭제 오류가 발생했습니다!');
											}
										},
										error: function(){
											alert('네트워크 오류가 발생했습니다!');
										}
									})//end of ajax
								});//end of click
							</script>
						</c:if>
					</li>
					<li>
						<label for="question_lock">잠금 유무</label>
						<c:if test="${detail.question_lock==1}"><input type="radio" name="question_lock" class="question_lock" value="1" checked> 공개글</c:if>
						<c:if test="${detail.question_lock==2}"><input type="radio" name="question_lock" class="question_lock" value="2" checked> 비밀글</c:if>
					</li>
				</ul>
				<div class="detail-center">
					<input type="submit" value="문의 수정">
				</div>
			</form>
		</div>
	</div>
</body>
</html>