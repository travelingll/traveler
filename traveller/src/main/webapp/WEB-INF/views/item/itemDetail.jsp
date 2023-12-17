<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상세정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
	.content-center{
		float: left;
        width: 67%;
        background-color: lightblue;
	}
	.content-main{
	padding:10px 20px;
	margin-left:230px;
	}
	.content-right{
	 	float: right;
        width: 27%;
        background-color: lightgreen;
	}
	.last-div{
	clear: right;
	}
	button{
	width:300px;
	}
	
	
</style>
<script>
	function openPopup1() {
    window.open("popup1.do", "예약시 유의사항", "width=500,height=500");
	}
	function openPopup2() {
    window.open("popup2.do", "여행시 유의사항", "width=500,height=500");
	}
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="side-menu">
		<ul>
 			<li><a href="${pageContext.request.contextPath}/comm/list.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">트래블러클럽</a></li>
  			<li><a href="${pageContext.request.contextPath}/accom/list.do">동행구하기</a></li>
 			<li><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
		</ul>
	</div>
	<div class="content-main">
	<!-- item-header 영역 시작 -->
		<div class="item-header">
			<div class="content-center">
				<div class="content-main-left">
					<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="100%">
				</div>
			</div>
			<div class="content-right">
				<div style="border: 1px solid black;">
					<h3>상품코드 ${item.item_num}</h3> <br>
				</div>
				<br>
				<div style="border: 1px solid black;">
					<h3>${item.item_name}</h3><br>
				</div>
				<br>
				<div style="border: 1px solid black;">
				<div class="last-div">
					<h2>가격 <fmt:formatNumber value="${item.item_price}"/>원</h2>
				</div>
				</div>
			</div>
		</div>
	<!-- item-header 영역 끝 -->
		<div style="clear:both;">
		<h2>여행 주요일정</h2>
		<hr size="10px">
		</div>
		<!-- 여행 주요일정 시작 -->
		
		<div class="content-center">
		<h3>여행 기간 : ${item.date_start} ~ ${item.date_end }</h3>
		<h3>여행 도시 : ${item.item_content}</h3>
		<h3>모집 인원 : <span></span>/${item.quantity}</h3>
		</div>
		<!-- 여행 주요일정 끝 -->
		<div class="content-right">
			예약하는 부분
		</div>
	<!-- 상품가격 알림 시작 -->
		<div class="content-center">
		<hr size="10px">
		<table>
			<tr>
				<th>비고</th>
				<th>성인(만 12세 이상)</th>
				<th>아동(만 12세 미만)</th>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber value="${item.item_price}"/>원</td>
				<td><fmt:formatNumber value="${item.item_price}"/>원</td>
			</tr>
		</table>
		<br>
		<br>
		<hr size="10px">
			<button onclick="openPopup1()">예약시 유의사항</button>	
			<button onclick="openPopup2()">여행시 유의사항</button>	
		</div>
	<!-- 상품가격 알림 끝 -->
	<br>
	<!-- 여행 상세정보 시작 -->
	<div class="content-center">
		<h2>여행 상세정보</h2>
		<br>
		<hr size="10px">
		<h2>1일차</h2>
		<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="100%">
		<br>
		
		<h2>2일차</h2>
		<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="100%">
		<br>
		
		<h2>3일차</h2>
		<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="100%">
		<br>
		
		<c:if test="${!empty item.item_img4}">
			<h2>4일차</h2>
			<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="100%">
			<br>
		</c:if>
		
		<c:if test="${!empty item.item_img4 && !empty item.item_img5}">
			<h2>5일차</h2>
			<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="100%">
			<br>
		</c:if>
		
		<c:if test="${!empty item.item_img4 && !empty item.item_img5 && !empty item.item_img6}">
			<h2>6일차</h2>
			<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="100%">
			<br>
		</c:if>
		
		
	</div>
	<!-- 여행 상세정보 끝 -->
	<!-- 여행 후기 시작 -->
	<div class="content-center">
		<h2>여행후기</h2>
		<hr size="10px">
	</div>
	<!-- 여행 후기 끝 -->
	<!-- 트래블러's pick 시작-->
	<div class="content-center">
		<h2>트래블러's pick</h2>
		<hr size="10px">
	</div>
	<!-- 트래블러's pick 끝-->
	</div>
</div>
</body>
</html>