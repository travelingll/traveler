<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 상세 내역</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
		    		<strong class="tit">예약 번호 [${order.order_num}] 상세 내역</strong>
		    	</div>
		    	<c:if test="${order.order_status==1}"><%--사용 전에만 사용 가능--%>
			    	<div class="ordertable-right">
				    	<input type="button" value="예약자 정보 수정" onclick="location.href='userOrderModifyForm.do?order_num=${order.order_num}'">
				    	<input id="ordercancel_btn" type="button" value="예약 전체 취소">
						<script type="text/javascript">
							document.getElementById('ordercancel_btn').onclick = function(){
								if(confirm('예약을 취소하겠습니까? 되돌릴 수 없습니다!'))
									location.href='userCancel.do?order_num='+${order.order_num};
							};
						</script>
					</div>	
				</c:if>
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
							<th>예약 번호</th> 
							<th>상품명</th> 
							<th>예약일</th>
							<th>예약 상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${order.order_num}</td>
							<td class="txl"><strong class="title">${order.item_name}</strong></td> 
                   			<td>${order.order_date}</td> 
                   			<td>
                   				<c:if test="${order.order_status==1}">여행 전</c:if>
                   				<c:if test="${order.order_status==2}">여행 중</c:if>
                   				<c:if test="${order.order_status==3}">여행 불참</c:if>
                   				<c:if test="${order.order_status==4}">예약 취소</c:if>
                   			</td>	
						</tr>
                	</tbody>
              	</table>
 			</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
					<table class="board_type">
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 40%;"> 
							<col style="width: 20%;">
							<col style="width: 15%;">
							<col style="width: 15%;">
						</colgroup> 
						<thead>
							<tr>
								<th>상세 번호</th> 
								<th>상품명</th> 
								<th>기간</th>
								<th>가격</th>
								<th>예약 갯수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="detail" items="${detail}">
								<tr>
									<td>${detail.detail_num}</td>
									<td class="txl"><strong class="title"><a href='${pageContext.request.contextPath}/item/itemDetail.do?item_num=${detail.item_num}'>${detail.item_name}</a></strong></td> 
		                   			<td>${detail.itemVO.date_start}~${detail.itemVO.date_end}</td> 
		                   			<td><fmt:formatNumber value="${detail.itemVO.item_price}"/>원</td> 
		                   			<td>${detail.order_quantity}</td>
								</tr>
							</c:forEach>
	                	</tbody>
	              	</table>
   				</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
					<table class="board_type">
						<colgroup>
							<col style="width: 40%;">
							<col style="width: 60%;"> 
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
								<td>
									<c:if test="${!empty order.notice}">${order.notice}</c:if>
									<c:if test="${empty order.notice}">-</c:if>
								</td>
							</tr>
	                	</tbody>
	              	</table>
   				</div></div></div>
   				<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
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
								<th>예약자명</th>
								<td>${order.order_name}</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>${order.order_email}</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${order.order_phone}</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>${order.order_birth}</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<c:if test="${order.order_gender==1}">남자</c:if>
									<c:if test="${order.order_gender==2}">여자</c:if>
								</td>
							</tr>
	                	</tbody>
	              	</table>
   				</div>
   			</div></div>
   			<div class="panels">
   			</div>
		</div></div></div>
	</div></div>
</body>
</html>