<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비회원 비밀글 비밀번호 확인</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssss.css">
	<script type="text/javascript">
		window.onload = function(){
			let passwd_form = document.getElementById('passwd_form');
			passwd_form.onsubmit = function(){
				let passwd = document.getElementById('question_passwd');
				if(passwd.value.trim()==''){
					alert('비밀번호를 입력해주세요!');
					passwd.value='';
					passwd.focus();
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
			<div class="align-center">
				<h4>비밀번호를 입력해주세요</h4>
			</div>
			<form id="passwd_form" action="userQuestionPasswdCheck.do" method="post">
				<input type="hidden" value="${question_num}" id="question_num" name="question_num">
				<input type="hidden" value="${check}" id="check" name="check">
				<ul>
					<li>
						<label for="question_passwd">비밀번호</label>
						<input type="password" id="question_passwd" name="question_passwd">
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="확인">
				</div>
			</form>
		</div>
	</div>
</body>
</html>