<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript">
		window.onload = function(){
			let searchForm = document.getElementById('search_form');
			searchForm.onsubmit = function(){
				let keyword = document.getElementById('keyword');
				if(keyword.value.trim()==''){
					alert('검색어를 입력하세요!');
					keyword.value='';
					keyword.focus();
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
		<%-- 카테고리 삽입 필요 --%>
		<div class="content-main">
			<form action="questionList.do" id="search_form" method="get"><%-- 검색바 --%>
				<ul class="search">
					<li>
						<select name="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
						</select>
					</li>
					<li>
						<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
					</li>
					<li>
						<input type="submit" value="검색">
					</li>
				</ul>
			</form>
			<div class="list-space align-right">
				<input type="button" value="문의 작성" onclick="location.href='userQuestionWriteForm.do'">
			</div>
			<c:if test="${empty list}">
				<div class="result-display">표시할 일대일 문의가 없습니다</div>
			</c:if>
			<c:if test="${!empty list}">
				<table>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일자</th>
						<th>조회수</th>
					</tr>
					<c:forEach var="question" items="${list}">
						<c:if test="${question.question_category!=0}">
							<tr>
								<td>
									<c:if test="${question.question_category==1}">상품</c:if>
									<c:if test="${question.question_category==2}">교환/환불</c:if>
									<c:if test="${question.question_category==3}">기타</c:if>
								</td>
								<td>
									<c:if test="${question.question_lock==2}">
										<img src="${pageContext.request.contextPath}/upload/question_lock.png" width="8">
									</c:if>
									<a href="questionDetail.do?question_num=${question.question_num}">${question.question_title}</a>
									<c:if test="${question.question_renum!=0}">
										<br>
										<a href="questionDetail.do?question_num=${question.question_num}">
											&nbsp;&nbsp;&nbsp;[답변 완료]&nbsp;<img src="${pageContext.request.contextPath}/upload/question_answer.png" width="12">
										</a>
									</c:if>
								</td>
								<td>
									<c:if test="${empty question.name}">비회원</c:if>
									<c:if test="${!empty question.name}">${question.name}</c:if>
								</td>
								<td>${question.question_regdate}</td>
								<td>${question.question_hit}</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</c:if>
			<div class="align-center">${page}</div>
		</div>
	</div>
</body>
</html>