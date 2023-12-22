<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
				<jsp:include page="/WEB-INF/views/common/header.jsp"/>
				<!-- 여기서 부터 사이드바 입니다.-->
				   <div id="container">
				   		<div class="inr">			
				    		<div id="lnb" class="lnb">
				    			<div class="inr">
				    				<dl>
										<dt class="type">		
											<a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
										</dt>
										<dd>
											<ul class="list_lnb">
												<li><a href="${pageContext.request.contextPath}/member/myPage.do">개인정보</a></li>
					 							<li><a href="${pageContext.request.contextPath}/member/myWriteComm.do">내가 쓴 글</a></li>
					 							<li><a href="${pageContext.request.contextPath}/member/myQuestion.do">1:1 문의</a></li>
					 							<li><a href="${pageContext.request.contextPath}/member/myMoney.do">적립금</a></li>
					 							<li><a href="${pageContext.request.contextPath}/accom/applyAccomList.do">동행 신청내역</a></li>
					 							<li><a href="${pageContext.request.contextPath}/accom/requestAccomList.do">받은 동행 신청내역</a></li>
					 							<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
					 							<li><a href="${pageContext.request.contextPath}/order/myOrderList.do">예약내역</a></li>
											</ul>
										</dd>
									</dl>
				    			</div>
				    		</div> 
				    	
				    				<!--  -->
				    		<div id="contents" class="contents" style="min-height:70%;">
				    			<div class="text_wrap big fix">
				    						<strong class="tit">예약내역</strong>
				    			</div>
				    			<div class="panels">
									<div id="tabPkg" class="panel selected">
										<div class="tbl">
									    	<c:if test="${empty list}">
													<table class="board_type">
														<colgroup>
														<!-- 1번 --><col style="width: 15%;">
														<!-- 2번 --><col style="width: 60%;"> 
														<!-- 3번 --><col style="width: 25%;"> 
														</colgroup> 
														<thead>
															<tr>
																<th>예약번호</th> 
																<th style="text-align:center;">상품명</th> 
																<th style="text-align:center;">예약일</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td></td>
																<td style="text-align:center;">예약내역이 없습니다.</td>
																<td></td>
															</tr>
									                	</tbody>
									              	</table>
												</c:if>
												<c:if test="${!empty list}">
													<table class="board_type">
														<colgroup>
														<!-- 1번 --><col style="width: 15%;">
														<!-- 2번 --><col style="width: 60%;"> 
														<!-- 3번 --><col style="width: 25%;">
														</colgroup> 
														<thead>
															<tr>
																<th>예약번호</th> 
																<th style="text-align:center;">상품명</th> 
																<th style="text-align:center;">예약일</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach var="order" items="${list}">
															<tr>
															<!-- 1번 -->
																<td>
																	${order.order_num}
																</td>
															<!-- 2,3,4번 -->
																<td class="txl">
																	<a href="userOrderDetail.do?order_num=${order.order_num}"><strong class="title">${order.item_name}</strong></a>
																</td> 
									                   		<!-- 5,6번 -->	
									                   			<td style="text-align:center;">
									                   				${order.order_date}
									                   			</td> 
									                   		</tr>
									                   	</c:forEach>
									                   	</tbody>
									                </table>
									            </c:if>
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

