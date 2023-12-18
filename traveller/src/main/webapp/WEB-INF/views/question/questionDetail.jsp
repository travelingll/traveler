<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 상세</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssss.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<%-- 사이드 메뉴 시작 --%>
		<jsp:include page="question_sidemenu.jsp"/>
		<%-- 사이드 메뉴 끝 --%>
		<div class="content-main">
			<h2>${detail.question_title}</h2>
			<div class="align-center">
				<ul class="align-right">
					<li>
						<c:if test="${empty detail.name}">비회원</c:if>
						<c:if test="${!empty detail.name}">${detail.name}</c:if>
					</li>
					<li>작성일 : ${detail.question_regdate}</li>
					<li>조회수 : ${detail.question_hit}</li>
				</ul>
				<c:if test="${ detail.question_renum==0 && (user_num==detail.mem_num || detail.mem_num==0) }"> <%-- 작성자 일치, 답변 미완료 시 수정/삭제 가능 --%>
					<div class="align-right">
						<input type="button" value="수정" onclick="location.href='userQuestionModifyForm.do?question_num=${detail.question_num}'">
						<input id="delete_btn" type="button" value="삭제">
						<script type="text/javascript">
							document.getElementById('delete_btn').onclick = function() {
								if(confirm('글을 삭제하시겠습니까?')){
									location.href='userQuestionDelete.do?question_num=${detail.question_num}';
								}
							};
						</script>
					</div>
				</c:if>
				<div class="align-center">
					<c:if test="${!empty detail.question_photo}">
						<img src="${pageContext.request.contextPath}/upload/${detail.question_photo}" width="500">
					</c:if>
					<p>${detail.question_content}</p>
				</div>
			</div>
			<c:if test="${!empty answer}"> <%-- 답변 완료 시 글 보임 --%>
				<hr size="1" noshade="noshade" width="100%">
				<h2>${answer.question_title}</h2>
				<div class="align-center">
					${answer.question_content}
					<input type="button" value="수정" onclick="location.href='adminQuestionModifyForm.do?question_num=${detail.question_num}'">
				</div>
			</c:if>
			<c:if test="${empty answer && user_auth==9}"> <%-- 관리자만 보임 --%>
				<div class="align-right">
					<input type="button" value="답변 작성하기" onclick="location.href='adminQuestionWriteForm.do?question_num=${detail.question_num}'">
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>