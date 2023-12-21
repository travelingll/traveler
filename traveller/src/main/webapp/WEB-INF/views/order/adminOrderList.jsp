<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 예약관리 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.st1').click(function(){
		let st1 = $(this).attr('data-num');
		location.href='adminItemList.do?st1='+st1;
	})
})
</script>
<style type="text/css">
td{
	text-align:center;
}
</style>
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
		
	<div id="containerr" style="display: flex;">
    <div id="sidebar" style="width: 100%;">
		<h2>
			관리자 예약관리 게시판
		</h2><br>
	
		<table>
			<tr>
				<th>예약번호</th>
				<th>상품이름</th>
				<th>예약상태</th>
			</tr>
			<c:forEach var="order" items="${list}">
				<tr>
					<td><a href="orderDetail.do?order_num=${order.order_num}">${order.order_num}</a></td>
					<td><a href="orderDetail.do?order_num=${order.order_num}">${order.item_name}</a></td>
					<td><a href="orderDetail.do?order_num=${order.order_num}">${order.order_status}</a></td>
				</tr>
			</c:forEach>
		</table>
			<div class="align-center">
				${page}
			</div>
	</div>
	</div>
</div>
</div>
		</div>
</body>
</html> 