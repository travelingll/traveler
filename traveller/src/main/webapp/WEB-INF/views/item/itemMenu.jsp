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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
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
	<div class="side-menu">
		<ul>
			<li>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=3">호주</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=4">유럽</a>
				<a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=5">국내</a>
			</li>
		</ul>
	</div>
	<div class="content-main">

		<div class="row">
			<c:forEach var="item" items="${list}" varStatus="status">
				<c:if test="${status.index < 3}">
					<div class="col-md-4">
						<div class="card" style="width:18rem;">
							<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">${item.item_name}</h5>
								<p class="card-text">${item.item_content}</p>
								<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}" class="btn btn-primary" width="100px">더보기</a>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>

			<div class="align-center">
				${page}
			</div>
	</div>
</div>

</body>
</html> 