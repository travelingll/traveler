<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 목록</title>
</head>
<body>
	<div class="content-main">
		
		<c:if test="${!empty questionList}">
			<%-- 사이드 메뉴 삽입 필요 --%>
			<%-- 카테고리 삽입 필요 --%>
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
					<li>
						<input type="button" value="문의 작성" onclick="location.href='questionWriteForm.do'">
					</li>
				</ul>
			</form>
			<c:if test="${category==0}">
				<%-- 일대일 문의 목록 출력 필요 --%>
			</c:if>
			<c:if test="${empty questionList}">
				<div class="result-display">표시할 일대일 문의가 없습니다</div>
			</c:if>
		</c:if>
	</div>
</body>
</html>