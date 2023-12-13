<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="side-menu">
			<ul>
	 			<li><a href="${pageContext.request.contextPath}/admin/main.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">관리자 페이지</a></li>
	  			<li><a href="${pageContext.request.contextPath}/admin/itemList.do">관리자 상품 게시판</a></li>
	 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
	 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
			</ul>
		</div>
		<div class="content-main">
		
		</div>
	</div>
</body>
</html>