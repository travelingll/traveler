<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>여행 상품 예약하기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/yena.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderform.css">
	<script type="text/javascript">
		window.onload = function(){
			
		};
	</script>
</head>
<body class="chrome">
	<div id="__nuxt"><div id="__layout"><div id="wrapper"><div id="screenArea">  
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="order-form">
			<h1 class="order-title order-center">여행 상품 주문서 작성</h1>
			<c:if test="${!empty user_num}"> <%--회원만 예약 가능--%>
				<form action="userOrder.do" method="post" class="input-form">
					<ul class="order-ul">
						<li>
							<label for="order_name">이름</label>
							<input type="text" placeholder="이름을 입력하세요" id="order_name" name="order_name">
						</li>
						<li>
							<label for="order_email">이메일</label>
							<input type="email" placeholder="이메일을 입력하세요" id="order_email" name="order_email">
						</li>
						<li>
							<label for="order_phone">전화번호</label>
							<input type="text" placeholder="전화번호를 입력하세요" id="order_phone" name="order_phone">
						</li>
						<li>
							<label for="order_birth">생년월일</label>
							<input type="text" id="order_birth" name="order_birth" placeholder="ex) 19990909">
						</li>
						<li class="order-radio">
							<label for="order_gender">성별</label>
							<input type="radio" name="order_gender" class="gender" value="1"> 남자
							<input type="radio" name="order_gender" class="gender" value="2"> 여자
						</li>
						<li>
							<label>메세지</label>
							<textarea name="notice" rows="5" cols="40"></textarea>
						</li>
					</ul>
					<hr size="1" noshade="noshade" width="100%">
					<ul class="order-ul">
						<li>
							<label>총 상품 금액</label>
							<span><fmt:formatNumber value="${order_total}" />원</span>
						</li>
						<li>
							<label>사용 가능 적립금</label>
							<span><fmt:formatNumber value="${user_money}" />원</span>
						</li>
						<li><%-- 보내는 데이터 --%>
							<label for="use_money">사용할 적립금</label>
							<div class="order-money"><input type="number" placeholder="${order_total}원까지 사용 가능" max="${order_total}" id="use_money" name="use_money" style="text-align:right;"></div>
						</li>
						<li>
							<label>결제 예정 금액</label>
							<span id="expect_money">원</span>
						</li>
						<li class="order-radio"><%-- 보내는 데이터 --%>
							<label for="payment">결제 수단</label>
							<input type="radio" name="payment" class="payment" value="1"> 카드 결제
							<input type="radio" name="payment" class="payment" value="2"> 무통장 입금
						</li>
					</ul>
					<div class="order-center">
						<input type="submit" value="여행상품 예약하기">
					</div>
				</form>
			</c:if>
		</div>
	</div></div></div></div>
</body>
</html>