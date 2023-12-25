<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비회원 비밀글 비밀번호 확인</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
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
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container"><div class="inr"><jsp:include page="question_sidemenu.jsp"/></div></div>
	<div id="containerr" style="display: flex;">
	    <div id="sidebar" style="width: 80%;">
			<h1>비밀번호 확인</h1>
			<form id="passwd_form" action="userQuestionPasswdCheck.do" method="post">
				<input type="hidden" value="${question_num}" id="question_num" name="question_num">
				<input type="hidden" value="${check}" id="check" name="check">
				<table>
					<tr>
						<td>
							<input type="password" id="question_passwd" name="question_passwd">
						</td>
					</tr>
				</table>
				<div class="ordertable-right">
					<input type="submit" value="확인">
				</div>
			</form>
		</div>
	</div>
</body>
</html>