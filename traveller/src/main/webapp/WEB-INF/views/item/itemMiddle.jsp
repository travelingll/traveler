<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 게시판(관리자)</title>
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
				  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 상품 게시판</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 
		
	<div class="content-main">
		<h2>
			관리자 여행상품 게시판
		</h2>
		<table>
			<tr>
				<th>여행상품번호</th>
				<th>상태</th>
				<th><a href="itemDetail.do">여행상품명</a></th>
				<th>출발일</th>
				<th>도착일</th>
				<th>등록일</th>
				<th>모집인원</th>
			</tr>
			<c:forEach var="item" items="${itemList}">
				<tr>
					<td>${item.item_num}</td>
					<td><c:if test="${item.status==1}">미표시</c:if>
						<c:if test="${item.status==2}">판매중</c:if>
						<c:if test="${item.status==3}">판매종료</c:if>
					</td>
					<td><a href="itemDetail.do?item_num=${item.item_num}">${item.item_name}</a></td>
					<td>${item.date_start}</td>
					<td>${item.date_end}</td>
					<td>${item.reg_date}</td>
					<td><span class="total_order"></span>/ ${item.quantity} 명</td>
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
</body>
</html> 