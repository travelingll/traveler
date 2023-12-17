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

.card {
            width: 200px; /* 카드의 너비 조정 */
            margin: 200px 100px 200px 0px; /* 카드를 가운데로 정렬 */
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

		<div class="row">
			<c:forEach var="item" items="${list}" varStatus="status">
				<c:if test="${status.index < 3}">
					<div class="col-md-4">
						<div class="card" style="width:40rem;">
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