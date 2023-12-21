<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 예약관리 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
td{
	text-align:center;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
	<div class="inr">
		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="${pageContext.request.contextPath}/admin/main.do">관리자 페이지</a>
					</dt>
					<dd>
						<ul class="list_lnb">
				  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 상품관리 게시판</a></li>
				  			<li><a href="${pageContext.request.contextPath}/admin/adminOrderList.do">관리자 예약관리 게시판</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 
	</div>
</div>
		
	<div id="containerr" style="display: flex;">
    <div id="sidebar" style="width: 100%;">
		<h2>
			<b>관리자 예약관리 게시판 (예약상세)</b>
		</h2><br>
		<div>
			<ul>
				<li><h4>이름 : ${order.order_name}   </h4></li>
				<li><h4>이메일 : ${order.order_email} </h4></li>
				<li><h4>전화번호 : ${order.order_phone} </h4></li>
				<li><h4>생년월일 : ${order.order_birth} </h4></li>
				<li><h4>성별 : 
								<c:if test="${order.order_gender==1}">남자</c:if>
								<c:if test="${order.order_gender==2}">여자</c:if></h4></li>
				<li><h4>메세지 : ${order.notice} </h4></li>
				<li><h4>총 상품 금액 : <fmt:formatNumber value="${order.order_total}" />원</h4></li>
				<li><h4>사용한 적립금
								<fmt:formatNumber value="${order.order_price}-${order.order_custprice}"/>원</h4></li>
				<li><h4>결제 금액
								<fmt:formatNumber value="${order.order_price}"/>원</h4></li>
				<li><h4>결제수단
								<c:if test="${order.payment==1}">카드 결제</c:if>
								<c:if test="${order.payment==2}">무통장 입금</c:if></h4></li>
			</ul>
		</div>
		<div class="align-right">
							<input type="button" value="예약정보 수정" onclick="location.href='adminModifyOrderForm.do'">
							<input type="button" value="목록" onclick="location.href=''">
		</div>
		</div>
	</div>
</body>
</html> 