<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 예약관리 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.st1').click(function(){
		let st1 = $(this).attr('data-num');
		location.href='adminItemList.do?st1='+st1;
	})
})
</script>
</head>
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
				<jsp:include page="/WEB-INF/views/common/header.jsp"/>
					<div id="container">
						<div class="inr">
							<div id="lnb" class="lnb">
								<div class="inr">
									<dl>
										<dt class="type">
											<a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 페이지</a>
										</dt>
										<dd>
											<ul class="list_lnb">
									  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">상품관리</a></li>
									  			<li><a href="${pageContext.request.contextPath}/admin/adminOrderList.do">예약관리</a></li>
									 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">상품등록</a></li>
									 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
											</ul>
										</dd>
									</dl>
								</div>
							</div> 
							<div id="contents" class="contents" style="min-height:70%;">
				    			<div class="text_wrap big fix">
				    						<strong class="tit">관리자 예약관리 게시판</strong>
				    			</div>
				    			<div class="panels">
									<div id="tabPkg" class="panel selected">
										<div class="tbl">
										<table class="board_type">
											<colgroup>
												<col style="width: 15%;">
												<col style="width: 60%;"> 
												<col style="width: 10%;"> 
											</colgroup> 
											<thead>
												<tr>
													<th>예약번호</th>
													<th>상품이름</th>
													<th>예약상태</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach var="order" items="${list}">
												<tr>
													<td><a href="orderDetail.do?order_num=${order.order_num}">${order.order_num}</a></td>
													<td><a href="orderDetail.do?order_num=${order.order_num}">${order.item_name}</a></td>
													<td><a href="orderDetail.do?order_num=${order.order_num}">${order.order_status}</a></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
											<div class="align-center">
												${page}
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html> 