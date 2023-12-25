<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[관리자] 일대일 문의 수정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript">
		window.onload = function(){
			let modifyForm = document.getElementById('question_modifyForm');
			modifyForm.onsubmit = function(){
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
			<h2 style="font-weight: bold">[관리자] 일대일 문의 답변 수정</h2>
			<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
				<form  class="detail-form" id="question_modifyForm" action="adminQuestionModify.do" method="post">
					<input type="hidden" value="${question.question_num}" name="question_num"> <%--원글 번호--%>
					<input type="hidden" value="${re_question.question_num}" name="requestion_num"> <%--답변글 번호--%>
					<table class="board_type">
						<colgroup>
							<col style="width:20%">
							<col style="width:80%"> 
							<col>
						</colgroup>
						<tr>
							<th><label for="question_title">제목</label></th>
							<td>
								<input type="text" id="question_title" name="requestion_title" value="${re_question.question_title}">
							</td>
						</tr>
						<tr>
							<th><label for="question_content">답변</label></th>
							<td>
								<textarea rows="5" cols="50" id="question_content" name="requestion_content" class="input">${re_question.question_content}</textarea>
							</td>
						</tr>
					</table>
					<div class="ordertable-right">
						<input type="submit" value="답변 수정">
					</div>
				</form>
			</div></div></div>
		</div>
	</div>
</body>
</html>