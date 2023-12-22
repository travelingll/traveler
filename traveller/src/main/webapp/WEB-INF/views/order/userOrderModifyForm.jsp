<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약자 수정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			let order_modifyForm = document.getElementById('order_modifyForm');
			order_modifyForm.onsubmit = function(){
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
			};
		};
	</script>
</head>
<body class="chrome">
	<div id="wrapper"><div id="screenArea">  
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div id="container"><div class="inr"><div id="lnb" class="lnb"><div class="inr">
  				<dl>
				<dt class="type"><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a></dt>
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
  				</div></div> 
    		<div id="contents" class="contents" style="min-height:70%;">
		    	<div class="text_wrap big fix">
		    		<strong class="tit">예약 번호 [${order.order_num}] 예약자 정보 변경</strong>
		    	</div>
  			<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
				<table class="board_type">
					<colgroup>
						<col style="width: 15%;">
						<col style="width: 60%;"> 
						<col style="width: 25%;"> 
					</colgroup> 
					<thead>
						<tr>
							<th>예약 번호</th> 
							<th>상품명</th> 
							<th>예약일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${order.order_num}</td>
							<td class="txl"><strong class="title">${order.item_name}</strong></td> 
                   			<td>${order.order_date}</td> 
						</tr>
                	</tbody>
              	</table>
 			</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
					<table class="board_type">
						<colgroup>
							<col style="width: 15%;">
							<col style="width: 50%;"> 
							<col style="width: 20%;">
							<col style="width: 15%;">
						</colgroup> 
						<thead>
							<tr>
								<th>예약 상세 번호</th> 
								<th>상품명</th> 
								<th>상품가격</th>
								<th>상품갯수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="detail" items="${detail}">
								<tr>
									<td>${detail.detail_num}</td>
									<td class="txl"><a href="userOrderDetail.do?order_num=${order.order_num}"><strong class="title">${detail.item_name}</strong></a></td> 
		                   			<td>${detail.item_price}</td> 
		                   			<td>${detail.order_quantity}</td>
								</tr>
							</c:forEach>
	                	</tbody>
	              	</table>
   				</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
					<table class="board_type">
						<colgroup>
							<col style="width: 50%;">
							<col style="width: 50%;"> 
						</colgroup> 
						<thead>
							<tr>
								<th colspan="2">결제 정보</th> 
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>총 주문 금액</th>
								<td><fmt:formatNumber value="${order.order_price}"/>원</td>
							</tr>
							<tr>
								<th>적립금 사용 금액</th>
								<td><fmt:formatNumber value="${order.order_price-order.order_custprice}"/>원</td>
							</tr>
							<tr>
								<th>결제 금액</th>
								<td><fmt:formatNumber value="${order.order_custprice}"/>원</td>
							</tr>
							<tr>
								<th>결제 수단</th>
								<td>
									<c:if test="${order.payment==1}">카드 결제</c:if>
									<c:if test="${order.payment==2}">무통장 입금</c:if>
								</td>
							</tr>
							<tr>
								<th>남기신 말씀</th>
								<td><textarea>${order.notice}</textarea></td>
							</tr>
	                	</tbody>
	              	</table>
   				</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
					<form id="order_modifyForm" action="userOrderModify.do" method="post">
						<input type="hidden" value="${order.order_num}" name="order_num">
						<table class="board_type">
							<colgroup>
								<col style="width: 40%;">
								<col style="width: 60%;"> 
							</colgroup> 
							<thead>
								<tr>
									<th colspan="2">예약자 정보</th> 
								</tr>
							</thead>
							<tbody>
								<tr>
									<th><label for="order_name">예약자명</label></th>
									<td>
										<input class="input" type="text" value="${order.order_name}" id="order_name" name="order_name">
									</td>
								</tr>
								<tr>
									<th><label for="order_email">이메일</label></th>
									<td>
										<input class="input" type="email" value="${order.order_email}" id="order_email" name="order_email">
									</td>
								</tr>
								<tr>
									<th><label for="order_phone">연락처</label></th>
									<td>
										<input class="input" type="text" value="${order.order_phone}" id="order_phone" name="order_phone">
									</td>
								</tr>
								<tr>
									<th><label for="order_birth">생년월일</label></th>
									<td>
										<input class="input" type="text" value="${order.order_birth}" id="order_birth" name="order_birth">
									</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>
										<input type="radio" name="order_gender" class="order_gender" value="1" <c:if test="${order.order_gender==1}">checked</c:if>> 남자
										<input type="radio" name="order_gender" class="order_gendery" value="2" <c:if test="${order.order_gender==2}">checked</c:if>> 여자
									</td>
								</tr>
								<tr>
									<td colspan="2"><input type="submit" value="예약자 정보 변경하기"></td>
								</tr>
								
		                	</tbody>
		              	</table>
	              	</form>
   				</div>
   			</div></div>
   			<div class="panels">
   			</div>
		</div></div></div>
	</div></div>
</body>
</html>