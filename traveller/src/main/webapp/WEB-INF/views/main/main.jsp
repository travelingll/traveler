<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

</head>

 <body class="chrome">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

   <!-- 중앙 캐러셀 시작 -->
	<div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="0" class="active"></button>
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="1"></button>
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="2"></button>
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="3"></button> 
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="4"></button>     
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="5"></button>    
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="6"></button>    
			<button type="button" data-bs-target="#carouselExample" data-bs-slide-to="7"></button>   
			   
		</div>	
		<div class="carousel-inner" >
			<!-- 0 이미지 시작 -->
			<div class="carousel-item active">
				<img src="../images/carousel-main09.jpeg" class="d-block w-100" >
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 0 이미지 끝 -->
			<!-- 1 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main03.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 1 이미지 끝 -->
			<!-- 2 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main04.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 2 이미지 끝 -->
			<!-- 3 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main05.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 3 이미지 끝 -->
			<!-- 4 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main06.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 4 이미지 끝 -->
			<!-- 5 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main07.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 5 이미지 끝 -->
			
			<!-- 6 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main08.jpeg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 6 이미지 끝 -->
			<!-- 7 이미지 시작 -->
			<div class="carousel-item">
				<img src="../images/carousel-main02.jpg" class="d-block w-100">
				<div class="carousel-caption">
				</div>
			</div>
			<!-- 7 이미지 끝 -->
			
		</div><!-- end of .carousel-inneer -->
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
			<span class="visually-hidden">Previous</span>	
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
			<span class="visually-hidden">Next</span>	
		</button>                               
	</div>
	<!-- 중앙 캐러셀 끝 -->







 

</body>
    