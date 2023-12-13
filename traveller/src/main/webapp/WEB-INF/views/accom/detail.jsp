<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행구하기 게시판 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class = "page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class = "content-main">
	<h2>${accom.accom_title}</h2>
	<ul class="detail-info">
		<li>
			<c:if test="${!empty accom.photo}">
				<img src="${pageContext.request.contextPath}/upload/${accom.photo}" 
				 width="40" height="40" class="my-photo">
				</c:if>
				<c:if test="${empty accom.photo}">
				<img src="${pageContext.request.contextPath}/images/face.jpg" 
				 width="40" height="40" class="my-photo">
				</c:if>
			</li>
			<li>
				${accom.id}<br>
				조회 : ${accom.accom_hit}
			</li>
	</ul>
	<hr size="1" noshade="noshade" width="100%" >
	<c:if test="${!empty accom.accom_filename}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${accon.accpm_filename}" class="detail-img">
		</div>	
		</c:if>
		<p>
			${accom.accom_content}
		</p>
		<hr size="1" noshade="noshade" width="100%" >
	</div>
	
</div>
</body>
</html>