<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="side-menu">
		<ul>
			<li>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
			</li>
		</ul>
	</div>
	<div class="content-main">
		<a href="#"><img src="${pageContext.request.contextPath}/upload/event_test1.jpg">캐러셀이미지</a>
	</div>
</div>
</body>
</html>