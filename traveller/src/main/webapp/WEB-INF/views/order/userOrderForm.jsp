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
			let writeForm = document.getElementById('order_form');
			writeForm.onsubmit = function(){
				//입력란 유효성 검사
				let input = document.querySelectorAll('.input');
				for(let i=0;i<input.length;i++){
					let label = document.querySelector('label[for="'+input[i].id+'"]');
					if(input[i].value.trim()==''){
						alert(label.textContent+' 항목을 입력해주세요!');
						input[i].value='';
						input[i].focus();
						return false;
					}
				}
				//성별 유효성 검사
				let radio = document.querySelectorAll('.radio-gender');
				flag = false;
				for(let i=0;i<radio.length;i++){
					if(radio[i].checked) flag = true;
				}
				if(!flag){
					alert('성별을 선택해주세요!');
					return false;
				}
				//결제수단 유효성 검사
				let payment = document.querySelectorAll('.radio-select');
				flag = false;
				for(let i=0;i<payment.length;i++){
					if(payment[i].checked) flag = true;
				}
				if(!flag){
					alert('결제수단을 선택해주세요!');
					return false;
				}
				//적립금 사용 체크
				if(document.getElementById('use_money').value.trim()==''){
					document.getElementById('use_money').value = '0';
				}
			};
			//동적으로 결제금액 태그 생성하기
			let money_input = document.getElementById('use_money');
			money_input.onkeyup = function(){
				//적립금보다 많은 숫자 입력 시 경고
				if(${user_money}<money_input.value){
					alert('적립금보다 많은 금액은 사용할 수 없습니다!');
					money_input.value = '';
					return;
				}
				if(money_input.value<0){
					alert('음수는 입력할 수 없습니다!');
					money_input.value = '';
					return;
				}
				let use_money = this.value;
				let expect_money = document.getElementById('expect_money');
				expect_money.innerText = (${order_total}-use_money).toLocaleString()+'원';
			};
		};
	</script>
</head>
<body class="chrome">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="order-form">
		<h1 class="order-title order-center">주문서 작성</h1>
		<c:if test="${!empty user_num}"> <%--회원만 예약 가능--%>
			<form id="order_form" action="userOrder.do" method="post" class="input-form">
				<ul class="order-ul">
					<li>
						<label for="order_name">이름</label>
						<input type="text" placeholder="이름을 입력하세요" id="order_name" name="order_name" class="input">
					</li>
					<li>
						<label for="order_email">이메일</label>
						<input type="email" placeholder="이메일을 입력하세요" id="order_email" name="order_email" class="input">
					</li>
					<li>
						<label for="order_phone">전화번호</label>
						<input type="text" placeholder="전화번호를 입력하세요" id="order_phone" name="order_phone" class="input">
					</li>
					<li>
						<label for="order_birth">생년월일</label>
						<input type="text" id="order_birth" name="order_birth" placeholder="ex)19990909" class="input">
					</li>
					<li class="order-radio">
						<label for="order_gender">성별</label>
						<input type="radio" name="order_gender" class="radio-gender" value="1"> 남자
						<input type="radio" name="order_gender" class="radio-gender" value="2"> 여자
					</li>
					<li>
						<label>메세지</label>
						<textarea name="notice" style="hegiht:50px"></textarea>
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
						<div class="order-money"><input type="number" placeholder="<fmt:formatNumber value="${user_money}"/>원까지 사용 가능" min="0" max="${user_money}" id="use_money" name="use_money" style="text-align:right;"></div>
					</li>
					<li>
						<label>결제 예정 금액</label>
						<span id="expect_money"><fmt:formatNumber value="${order_total}" />원</span>
					</li>
					<li class="order-radio"><%-- 보내는 데이터 --%>
						<label for="payment">결제 수단</label>
						<div class="radio-right">
							<input type="radio" name="payment" class="radio-select" value="1"> 카드 결제
							<input type="radio" name="payment" class="radio-select" value="2"> 무통장 입금
						</div>
					</li>
				</ul>
				<div class="order-right">
					<input type="submit" value="여행상품 예약하기">
				</div>
			</form>
		</c:if>
	</div>
</body>
</html>