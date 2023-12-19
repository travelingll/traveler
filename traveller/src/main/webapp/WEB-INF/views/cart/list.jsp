<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>장바구니</h2>
		<c:if test="${empty list}">
		<div class="result-display">
			장바구니에 담은 상품이 없습니다.
		</div>
		</c:if>
		<c:if test="${!empty list}">
		<form id="cart_order" action="${pageContext.request.contextPath}/order/orderForm.do" method="post">
			<table>
				<tr>
					<th>상품명</th>
					<th>상품가격</th>
				</tr>
				<c:forEach var="cart" items="${list}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/item/detail.do?item_num=${cart.item_num}">
							<img src="${pageContext.request.contextPath}/upload/${cart.itemVO.item_img1}" width="50">
							${cart.itemVO.item_name}
						</a>
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${cart.itemVO.item_price}"/>원
					</td>
					<td class="align-center">
						<input type="button" value="삭제" class="cart-del" data-cartnum="${cart.cart_num}">
					</td>
				</tr>
				</c:forEach>
			</table>
		</form>
		</c:if>
	</div>
</div>
</body>
</html>

