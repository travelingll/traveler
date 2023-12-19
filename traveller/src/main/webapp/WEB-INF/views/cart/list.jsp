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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
<script type="text/javascript">
</script>
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
	 							<li><a>동행 신청내역</a></li>
	 							<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
							</ul>
						</dd>
					</dl>
    			</div>
    		</div> 
    	
    				<!--  -->
    		<div id="contents" class="contents" style="min-height:70%;">
    			<div class="text_wrap big fix">
    						<strong class="tit">내역조회</strong>
    			</div> 
    		</div>
    	</div>
    </div>
	<div class="tbl" style="width:70%">
    	<c:if test="${empty list}">
				<table class="board_type">
					<colgroup>
					<col>
					<col style="width: 10%;"> 
					<col> 
					<col style="width: 10%;"> 
					<col style="width: 10%;"> 
					</colgroup>								 								
					<thead>
						<tr>
							<th>상품명</th>
							<th>상품가격</th>
							<th>수량</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td style="float:right;">장바구니에 담은 상품이 없습니다.</td>
							<td></td>
							<td></td>
							</tr>
                	</tbody>
              	</table>
			</c:if>
			<c:if test="${!empty list}">
				<table class="board_type">
					<colgroup>
					<!-- 1번 --><col style="width: 10%;">
					<!-- 2번 --><col > 
					<!-- 3번 --><col style="width: 15%;"> 
					<!-- 4번 --><col style="width: 15%;"> 
					<!-- 5번 --><col style="width: 15%;">
					<!-- 6번 --><col style="width: 10%;">
					</colgroup> 
					<thead>
						<tr>
							<th></th> 
							<th>상품명</th>
							<th>상품가격</th> 
							<th>수량</th>
							<th>합계</th> 
							<th></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="cart" items="${list}">
						<tr>
						<!-- 1번 -->
							<td>
								<a href="${pageContext.request.contextPath}/item/detail.do?item_num=${cart.item_num}">
								<img src="${pageContext.request.contextPath}/upload/${cart.itemVO.item_img1}" width="50">
								</a>
							</td>
						<!-- 2번 -->
							<td class="txl"><a><strong class="title">${cart.itemVO.item_name}</strong></a></td> 
						<!-- 3번 -->	
							<td><fmt:formatNumber value="${cart.itemVO.item_price}"/>원</td>
						<!-- 4번 -->	
							<td>
								<a>
									<input style="border:none;"type="number" name="order_quantity" min="1" max="${cart.itemVO.quantity}" value="${cart.order_quantity}" autocomplete="off">/${cart.itemVO.quantity}
									<input class="btn" type="button" style="margin-left:3px;" value="변경" class="cart-modify" data-cartnum="${cart.cart_num}" data-itemnum="${cart.item_num}">
								</a>
							</td>
                   		<!-- 5번 -->	
                   			<td><fmt:formatNumber value="${cart.itemVO.item_price * cart.order_quantity}"/>원</td> 
                   		<!-- 6번 -->	
                   			<td><input class="btn" type="button" value="삭제" class="cart-del" data-cartnum="${cart.cart_num}"></td>
                   		</tr>
                   		
                   	</c:forEach>
                   	</tbody>
                </table>
             <c:if test="${!empty list}">
				<table class="board_type">
					<colgroup>
					<!-- 1번 --><col>
					<!-- 2번 --><col > 
					</colgroup> 
					<thead>
						<tr>
							<th>합계</th> 
							<th></th>
						</tr>
					</thead>
					<tbody>
             			<tr>
							<td class="align-right"><b>총 구매금액</b></td>
							<td style="float:right;"><fmt:formatNumber value="${all_total}"/>원</td>
						</tr>
              		</tbody>
                </table>
                <div class="align-center cart-submit">
					<input class="btn" style="float:right; margin-top:10px;" type="submit" value="구매하기">
				</div>
             </c:if>
            
            </c:if> 
    				</div>
   				</div>
    		</div>
    	</div>
	</div>
</body>
</html>

