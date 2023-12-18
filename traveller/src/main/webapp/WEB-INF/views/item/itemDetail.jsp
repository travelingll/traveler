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
	
a {
    color: #333;
    text-decoration: none; 
}
#lnb.lnb ul.list_lnb > li {
    border-bottom: 1px solid #ddd;
    line-height: 50px;
}
.list_lnb li{
	font-size:14px;
}
hr{
    color: black;
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
	
	<div id="container">
	<div class="inr">
		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="#">여행상품</a>
					</dt>
					<dd>
						<ul class="list_lnb">
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">호주</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">유럽</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">국내</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		</div>
	</div>
	
	
	<div class="content-main">
	<!-- item-header 영역 시작 -->
		<div class="item-header">
			<div class="content-center">
				<div class="content-main-left">
					<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="100%">
					<br><br><br>
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
		<hr size="5px" color="black">
		<br><br><br>
		</div>
		<!-- 여행 주요일정 시작 -->
		
		<div class="content-center">
		<h2>여행 기간 : ${item.date_start} ~ ${item.date_end }</h2>
		<br><br><br>
		<h3>여행 도시 : ${item.item_content}</h3>
		<br><br><br>
		<h3>모집 인원 : <span id="apply"></span>/${item.quantity}</h3>
		<br><br><br>
		</div>
		<!-- 여행 주요일정 끝 -->
		<div class="content-right">
			예약하는 부분
		</div>
	<!-- 상품가격 알림 시작 -->
		<div class="content-center">
		<hr size="5px" color="black">
		<table>
			<tr>
				<th>비고</th>
				<th>성인(만 12세 이상)</th>
				<th>아동(만 12세 미만)</th>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber value="${item.item_price}"/>원</td>
				<td><fmt:formatNumber value="${item.item_price * 0.8}"/>원</td>
			</tr>
		</table>
		<br>
		<br>
		<hr size="5px" color="black">
			<button onclick="openPopup1()">예약시 유의사항</button>	
			<button onclick="openPopup2()">여행시 유의사항</button>	
			<br><br><br>
		</div>
	<!-- 상품가격 알림 끝 -->
	<br>
	<!-- 여행 상세정보 시작 -->
	<div class="content-center">
		<h2>여행 상세정보</h2>
		<br>
		<hr size="5px" color="black">
		
		<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="100%">
		
		<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="100%">
		
		<c:if test="${!empty item.item_img4}">
		<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="100%">
		</c:if>
		<c:if test="${!empty item.item_img4 && !empty item.item_img5}">
		<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="100%">
		</c:if>
		<c:if test="${!empty item.item_img4 && !empty item.item_img5 && !empty item.item_img6}">
		<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="100%">
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