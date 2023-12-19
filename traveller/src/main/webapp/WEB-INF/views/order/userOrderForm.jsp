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
</head>
<body>
	<%--헤더 삽입?--%>
	<div class="page-main">
		<h2>예약</h2>
		<c:if test="${!empty user_num}"> <%--회원만 예약 가능--%>
			<form action="userOrder.do" method="post">
				<ul>
					<li>
						<label for="name">이름</label>
						<input type="text" placeholder="이름을 입력하세요" id="name" name="name">
					</li>
					<li>
						<label for="email">이메일</label>
						<input type="email" placeholder="이메일을 입력하세요" id="email" name="email">
					</li>
					<li>
						<label for="phone">전화번호</label>
						<input type="text" placeholder="전화번호를 입력하세요" id="phone" name="phone">
					</li>
					<li>
						<label for="birth">생년월일</label>
						<input type="date" id="birth" name="birth">
					</li>
					<li>
						<label for="gender">성별</label>
						<input type="radio" name="gender" class="gender" value="1">남자
						<input type="radio" name="gender" class="gender" value="2">여자
					</li>
				</ul>
				<hr size="1" noshade="noshade" width="100%">
				<ul>
					<li>
						<label>상품 금액</label>
						<span><fmt:formatNumber value="${order_total}" />원</span>
					</li>
					<li>
						<label>사용 가능 적립금</label>
						<span><fmt:formatNumber value="${user_money}" />원</span>
					</li>
					<li><%-- 보내는 데이터 --%>
						<label for="use_money">사용할 적립금</label>
						<input type="number" placeholder="${order_total}원까지 사용 가능" max="${order_total}" id="use_money" name="use_money">원
					</li>
					<li>
						<label>결제 예정 금액</label>
						<span><fmt:formatNumber value="${order_total-money}" />원</span>
					</li>
					<li><%-- 보내는 데이터 --%>
						<label for="payment">결제 수단 선택</label>
						<input type="radio" name="payment" class="payment" value="1">카드 결제
						<input type="radio" name="payment" class="payment" value="2">무통장 입금
						<input type="radio" name="payment" class="payment" value="3">카카오페이
						<input type="radio" name="payment" class="payment" value="4">네이버페이
						<input type="radio" name="payment" class="payment" value="5">페이코
					</li>
					<li>
						<label>남기실 말씀</label>
						<textarea name="notice" rows="5" cols="40"></textarea>
					</li>
				</ul>
				<input type="submit" value="예약하기">
			</form>
		</c:if>
	</div>
</body>
</html>