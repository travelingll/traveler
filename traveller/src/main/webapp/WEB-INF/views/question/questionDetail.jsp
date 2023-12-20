<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 상세</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="detail-sidemenu"><jsp:include page="question_sidemenu.jsp"/></div>
	<div class="detail-page">
		<div class="detail-content">
			<div class="question-user">
				<h2>Q. ${detail.question_title}</h2>
				<ul>
					<li>
						<img src="${pageContext.request.contextPath}/images/eventdetail_replydate.png" width="10">
						<c:if test="${empty detail.name}">비회원</c:if>
						<c:if test="${!empty detail.name}">${detail.name}</c:if>
					</li>
					<li>
						<img src="${pageContext.request.contextPath}/images/eventdetail_clock.png" width="10"> ${detail.question_regdate} 
						<img src="${pageContext.request.contextPath}/images/eventdetail_check.png" width="15">${detail.question_hit}
					</li>
					<li>
						<c:if test="${ detail.question_renum==0 && (detail.mem_num==user_num || detail.mem_num==0) }"> <%-- 작성자 일치, 답변 미완료 시 수정/삭제 가능 --%>
							<input class="admin-btn" type="button" value="수정" onclick="location.href='userQuestionModifyForm.do?question_num=${detail.question_num}'">
							<input class="admin-btn" id="delete_btn" type="button" value="삭제">
							<script type="text/javascript">
								document.getElementById('delete_btn').onclick = function() {
									if(confirm('글을 삭제하시겠습니까?')){
										location.href='userQuestionDelete.do?question_num=${detail.question_num}';
									}
								};
							</script>
						</c:if>
					</li>
				</ul>
				<hr size="1" width="80%" noshade="noshade">
				<div class="detail-detailcontent">
					<c:if test="${!empty detail.question_photo}">
						<img src="${pageContext.request.contextPath}/upload/${detail.question_photo}" width="500">
					</c:if>
					<p>${detail.question_content}</p>
				</div>
			</div>
			<c:if test="${!empty answer}"> <%-- 답변 완료 시 글 보임 --%>
				<div class="question-answer">
					<h2>A. ${answer.question_title}</h2>
					<c:if test="${user_auth==9}"><%-- 관리자만 보임 --%>
						<div class="detail-right"><input type="button" value="수정" onclick="location.href='adminQuestionModifyForm.do?question_num=${detail.question_num}'"></div>
					</c:if>
					<div class="detail-answer">${answer.question_content}</div>
				</div>
			</c:if>
			<c:if test="${empty answer && user_auth==9}"> <%-- 관리자만 보임 --%>
				<div class="detail-right"><input type="button" value="답변 작성하기" onclick="location.href='adminQuestionWriteForm.do?question_num=${detail.question_num}'"></div>
			</c:if>
		</div>
	</div>
</body>
</html>