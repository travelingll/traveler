<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 맞춤 여행 추천</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
</head>
<body class="chrome">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div id="__nuxt">
    	<div id="__layout">
    		<div id="wrapper">
    			<div id="screenArea">
    				<div id="wrap">
    					<div id="container">
    						<div class="inr">
    						<!-- 여기서 부터 사이드바 입니다.-->
    							<div id="lnb" class="lnb">
    								<div class="inr">
    									<dl>
											<dt class="type">		
												<a href="${pageContext.request.contextPath}/recommend/adminRecommend.do">트래블러 PICK</a>
											</dt>
											<dd>
												<ul class="list_lnb">
													<li><a href="${pageContext.request.contextPath}/recommend/adminRecommend.do">트래블러추천</a></li>
	 												<li><a href="${pageContext.request.contextPath}/recommend/userRecommend.do">사용자맞춤추천</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">트래블러 맞춤 추천</strong></div> 
									<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
										<table class="board_type">
											<colgroup>
												<col style="width: 20%;"> 
												<col style="width: 45%;"> 
												<col style="width: 23%;"> 
												<col style="width: 12%;">
											</colgroup>
										<thead>
											<tr>
												<th colspan="2">여행상품</th>
												<th>여행날짜</th>
												<th>가격<br></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${list}">
												<tr>
													<td><img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px"></td>
													<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><b>${item.item_name}</b></a></td>
													<td>${item.date_start} ~ ${item.date_end}</td>
													<td><fmt:formatNumber value="${item.item_price}"/>원<br></td>
												</tr>
											</c:forEach>
										</tbody>
										</table><br><br>
										<div class="printArea" style="text-align:center;">
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
</div>
</body>
</html>

