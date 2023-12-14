<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<%-- 사이드 메뉴 삽입 필요 --%>
		<%-- 카테고리 삽입 필요 --%>
		<div class="content-main">
			<form action="eventList.do" id="search_form" method="get"><%-- 검색바 --%>
				<ul class="search">
					<li>
						<select name="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>전체</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>상품</option>
							<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>교환/환불</option>
							<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>기타</option>
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
				<input type="button" value="문의 작성" onclick="location.href='questionWriteForm.do'">
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
						<tr>
							<td>${question.question_category}</td>
							<td>${question.question_title}</td>
							<td>
								<c:if test="${question.mem_num==0}">비회원</c:if>
								<c:if test="${question.mem_num!=0}">${question.mem_num}</c:if>
								
							</td>
							<td>${question.question_regdate}</td>
							<td>${question.question_hit}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>