<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 맞춤 여행 추천</title>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<c:forEach var="item" items="${list}">
	<c:if test="${item.item_st1 == 1}">
		<div>
			<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" class="card-img-top">
			<div>
				<h5 class="card-title">${item.item_name}</h5>
				<p class="card-text">${item.item_content}</p>
				<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">더보기</a>
			</div>
		</div>
	</c:if>
	</c:forEach>
	</div>
</div>
</body>
</html>