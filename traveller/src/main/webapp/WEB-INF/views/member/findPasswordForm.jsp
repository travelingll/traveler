<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//비밀번호 찾기 유효성 체크
	$('#find_form').submit(function(){
		let items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				let label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}//end of if
		}//end of for
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>비밀번호 찾기</h2>
		<form action="findPassword.do" method="post" id="find_form">
			<ul>
				<li>
					<label for="id">아이디</label>
					<input type="text" name="id" id="id" maxlength="12" class="input-check">
				</li>
				<li>
					<label for="name">이름</label>
					<input type="text" name="name" id="name" maxlength="10" class="input-check">
				</li>
				<li>
					<label for="email">이메일</label>
					<input type="email" name="email" id="email" maxlength="50" class="input-check">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="비밀번호 찾기">
				<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>

