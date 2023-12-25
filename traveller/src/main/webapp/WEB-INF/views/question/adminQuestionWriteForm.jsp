<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[관리자] 일대일 문의 작성</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
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
	    	<div class="user-answer">
				<h2 style="font-weight: bold">Q. ${question.question_title}</h2>
				<ul>
					<li>
						<img src="${pageContext.request.contextPath}/images/eventdetail_replydate.png" width="10">
						<c:if test="${empty question.name}">비회원</c:if>
						<c:if test="${!empty question.name}">${question.name}</c:if>
					</li>
					<li>
						<img src="${pageContext.request.contextPath}/images/eventdetail_clock.png" width="10"> ${question.question_regdate} 
						<img src="${pageContext.request.contextPath}/images/eventdetail_check.png" width="15">${question.question_hit}
					</li>
				</ul>
				<div class="detail-detailcontent">
					<c:if test="${!empty question.question_photo}">
						<img src="${pageContext.request.contextPath}/upload/${question.question_photo}" width="500">
					</c:if>
					<p>${question.question_content}</p>
				</div>
			</div>
			<h2 style="font-weight: bold">[관리자] 일대일 문의 답변 등록</h2>
			<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
				<form class="detail-form" id="question_writeForm" action="adminQuestionWrite.do" method="post">
					<input type="hidden" value="${question.question_num}" name="question_num" id="question_num">
					<input type="hidden" value="${question.question_category}" name="question_category" id="question_category">
					<table class="board_type">
						<colgroup>
							<col style="width:20%">
							<col style="width:80%"> 
							<col>
						</colgroup>
						<tr>
							<th><label for="question_title">제목</label></th>
							<td>
								<input type="text" id="question_title" name="question_title" value="고객님 문의 답변드립니다 :)">
							</td>
						</tr>
						<tr>
							<th><label for="question_content">답변</label></th>
							<td>
								<textarea rows="5" cols="50" id="question_content" name="question_content" class="input"></textarea>
							</td>
						</tr>
					</table>
					<div class="ordertable-right">
						<input type="submit" value="답변 등록">
					</div>
				</form>
			</div></div></div>
		</div>
	</div>
</body>
</html>