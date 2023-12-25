<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
.page-main{
	background:#FFFFFF;
	margin:40px 0;
	border-radius:5px;
	box-shadow:0 2px 6px rgba(100,100,100,0.3);
	min-height:650px;
}
.result-display{
	width:400px;
	height:200px;
	margin:50px auto;
	border:1px solid #000;
	display:flex;
	align-items:center;
	justify-content:center;
}
.align-center{
	text-align:center;
}
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="result-display">
		<div class="align-center">
			<c:if test="${!empty accessMsg}">
				${accessMsg}
			</c:if>
			<c:if test="${empty accessMsg}">
				잘못된 접속입니다.
			</c:if>
			<p>
			<br><br>
			<div class="align-center">
			<c:if test="${!empty accessUrl}">
			<input type="button" value="이동"
			   onclick="location.href='${accessUrl}'">
			</c:if>
			</div>
			<c:if test="${empty accessUrl}">
				<input type="button" value="홈으로"
			       onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</c:if>
		</div>
	</div>
</div>
</body>
</html>




