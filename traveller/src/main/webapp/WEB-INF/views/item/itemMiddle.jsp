<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 게시판(관리자)</title>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript">
</script>
<style>

</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div id="container">
	<div class="inr" >
		<div id="lnb" class="lnb" style="width: 20%;">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="${pageContext.request.contextPath}/item/itemMain.do">여행상품</a>
					</dt>
					<dd>
						<ul class="list_lnb">
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
	</div>
	
		
		
	<div id="containerr" style="display: flex;">
    <div id="sidebarr" style="width: 20%;">
    </div>
    <div id="sidebar" style="width: 80%;">
        <!-- 왼쪽 사이드바 내용 -->
      
	
    <div id="content" style="width: 80%;">
        <!-- 오른쪽 내용 -->
        <div class="row" style="width: 70%;" style="text-align:right;">
			<c:forEach var="item" items="${newList}" varStatus="status">
				<c:if test="${status.index <3}">
				<c:if test="${item.item_case==item_case}">
						<div class="card" style="width:30rem;" style="text-align: center;">
								<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" class="card-img-top"  style="width:30rem;">
							<div class="card-body">
								<h3 class="card-title">
									<h3>${item.item_name}</h3>
								</h3>
								<p class="card-text">
								${item.item_content}
								</p>
							</div>
						</div>
				</c:if>
				</c:if>
			</c:forEach>
		</div>
		</div>
	
		<table>
			<tr>
				<th>출발일</th>
				<th>도착일</th>
				<th>모집인원</th>
				<th>가격</th>
			</tr>
			<c:forEach var="item" items="${itemList}" >
			
				<c:if test="${item.item_case==item_case}">
				<tr>
					<td id="start"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">${item.date_start}</a></td>
					<td id="start"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">${item.date_start}</a></td>
					<td id="end"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}">${item.date_end}</a></td>
					<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><span class="total_order">${item.orderCount}</span>/ ${item.quantity} 명</a></td>
					<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><fmt:formatNumber value="${item.item_price}"/>원</a></td>
				</tr>
				</c:if>
			</c:forEach>
		</table>
		
		</div>
    </div>
</div>

		
</body>
</html> 