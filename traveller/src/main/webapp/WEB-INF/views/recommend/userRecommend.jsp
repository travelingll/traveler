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
												<a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
											</dt>
											<dd>
												<ul class="list_lnb">
													<li><a href="${pageContext.request.contextPath}">트래블러추천</a></li>
	 												<li><a href="${pageContext.request.contextPath}/recommend/userRecommend.do">사용자맞춤추천</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">사용자맞춤추천 여행상품</strong></div> 
									<div class="content-main">
										<table>
											<tr>
												<th colspan="2">여행상품</th>
												<th>가격<br></th>
											</tr>
											<c:forEach var="rec" items="${item}">
												<tr>
													<td><img src="${pageContext.request.contextPath}/upload/${rec.item_img1}" width="150px"></td>
													<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${rec.item_num}"><b>${rec.item_name}</b>
														<br>${rec.item_content}<br>${rec.date_start} ~ ${rec.date_end}</a></td>
													<td><fmt:formatNumber value="${rec.item_price}"/>원<br></td>
												</tr>
											</c:forEach>
										</table>
										<div class="printArea" style="text-align:center;">
											${page}
										</div>
										    <!-- 각 요소를 개별적으로 출력 -->
										    <h2>Style 1:</h2>
										    <ul>
										        <c:forEach var="style" items="${style1}">
										            <li style="display:inline-block;">${style}</li>
										        </c:forEach>
										    </ul>
										    <div>
										    	${count}
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