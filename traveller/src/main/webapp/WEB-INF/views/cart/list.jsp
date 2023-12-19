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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
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
													<li><a href="${pageContext.request.contextPath}/member/myPage.do">개인정보</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myWriteComm.do">내가 쓴 글</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myQuestion.do">1:1 문의</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myMoney.do">적립금</a></li>
	 												<li><a>동행 신청내역</a></li>
													<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">장바구니</strong></div> 
										<div class="content-main">
											<c:if test="${empty list}">
											<div class="result-display">
												장바구니에 담은 상품이 없습니다.
											</div>
											</c:if>
											<c:if test="${!empty list}">
											<form id="cart_order" action="${pageContext.request.contextPath}/order/userOrderForm.do" method="post">
												<table>
													<tr>
														<th>상품명</th>
														<th>상품가격</th>
														<th>수량</th>
														<th>합계</th>
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
														<td>
															<input type="number" name="order_quantity" min="1" max="${cart.itemVO.quantity}" value="${cart.order_quantity}" autocomplete="off">${cart.itemVO.quantity}
															<input type="button" value="변경" class="cart-modify" data-cartnum="${cart.cart_num}" data-itemnum="${cart.item_num}">
														</td>
														<td>
															<fmt:formatNumber value="${cart.itemVO.item_price * cart.order_quantity}"/>원
														</td>
														<td>
															<input type="button" value="삭제" class="cart-del" data-cartnum="${cart.cart_num}">
														</td>
													</tr>
													<tr>
														<td colspan="4" class="align-right"><b>총 구매금액</b></td>
														<td class="align-center"><fmt:formatNumber value="${all_total}"/>원</td>
													</tr>
													</c:forEach>
												</table>
												<div class="align-center cart-submit">
													<input type="submit" value="구매하기">
												</div>
											</form>
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
</body>
</html>

