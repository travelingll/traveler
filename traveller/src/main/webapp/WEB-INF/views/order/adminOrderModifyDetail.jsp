<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 예약관리 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.st1').click(function(){
		let st1 = $(this).attr('data-num');
		location.href='adminItemList.do?st1='+st1;
	})
})
</script>
<style type="text/css">
td{
	text-align:center;
}
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
	<div class="inr">
		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="${pageContext.request.contextPath}/admin/main.do">관리자 페이지</a>
					</dt>
					<dd>
						<ul class="list_lnb">
				  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 상품관리 게시판</a></li>
				  			<li><a href="${pageContext.request.contextPath}/admin/adminOrderList.do">관리자 예약관리 게시판</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
				 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 
		
	<div id="containerr" style="display: flex;">
    <div id="sidebar" style="width: 100%;">
		<h2>
			관리자 예약관리 게시판 (예약상세)
		</h2><br>
		<div class="choice">
			<h3>지역선택</h3>
			<br>
			<input type="button" value="동남아" data-num="1" class="st1">
			<input type="button" value="북미" data-num="2" class="st1">
			<input type="button" value="호주" data-num="3" class="st1">
			<input type="button" value="유럽" data-num="4" class="st1">
			<input type="button" value="국내" data-num="5" class="st1">
			<br>
		</div>
			<br>
			<div>
				<form id="adminListSearch" action="adminItemList.do" method="post">
				<ul class="search">
					<li>
						<select name="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>상품이름</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>상품내용</option>
						</select>
					</li>
					<li>
						<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
					</li>
					<li>
						<input type="submit" value="검색">
					</li>
				</ul>				
				</form>
				
				
				<div class="order-form">
				<h1 class="order-title order-center">주문서 작성</h1>
					<form id="order_form" action="userOrder.do" method="post" class="input-form">
						<table>
							<colgroup>
								<col style="width:20%">
								<col style="width:80%"> 
								<col>
							</colgroup>
							<tr>
								<th><label for="order_name">이름</label></th>
								<td>
									<input type="text" placeholder="이름을 입력하세요" id="order_name" name="order_name" class="input">
								</td>
							</tr>
							<tr>
								<th><label for="order_email">이메일</label></th>
								<td>
									<input type="email" placeholder="이메일을 입력하세요" id="order_email" name="order_email" class="input">
								</td>
							</tr>
							<tr>
								<th><label for="order_phone">전화번호</label></th>
								<td>
									<input type="text" placeholder="전화번호를 입력하세요" id="order_phone" name="order_phone" class="input">
								</td>
							</tr>
							<tr>
								<th><label for="order_birth">생년월일</label></th>
								<td>
									<input type="text" id="order_birth" name="order_birth" placeholder="ex)19990909" class="input">
								</td>
							</tr>
							<tr>
								<th><label for="order_gender">성별</label></th>
								<td>
									<input type="radio" name="order_gender" class="radio-gender" value="1"> 남자
									<input type="radio" name="order_gender" class="radio-gender" value="2"> 여자
								</td>
							</tr>
							<tr>
								<th><label>메세지</label></th>
								<td>
									<textarea name="notice" style="hegiht:50px"></textarea>
								</td>
							</tr>
							<tr>
								<th><label>총 상품 금액</label></th>
								<td>
									<span><fmt:formatNumber value="${order_total}" />원</span>
								</td>
							</tr>
							<tr>
								<th><label>사용 가능 적립금</label></th>
								<td>
									<span><fmt:formatNumber value="${user_money}" />원</span>
								</td>
							</tr>
							<tr><%-- 보내는 데이터 --%>
								<th><label for="use_money">사용할 적립금</label></th>
								<td>
									<div class="order-money"><input type="number" placeholder="<fmt:formatNumber value="${user_money}"/>원까지 사용 가능" min="1" max="${user_money}" id="use_money" name="use_money" style="text-align:right;"></div>
								</td>
							</tr>
							<tr>
								<th><label>결제 예정 금액</label></th>
								<td>
									<span id="expect_money">0원</span>
								</td>
							</tr>
							<tr>
								<th><label for="payment">결제 수단</label></th>
								<td>
									<input type="radio" name="payment" class="radio-select" value="1"> 카드 결제
									<input type="radio" name="payment" class="radio-select" value="2"> 무통장 입금
								</td>
							</tr>
						</table>
						<div class="order-right">
							<input type="submit" value="여행상품 예약하기">
						</div>
					</form>
			</div>
			</div>
	</div>
	</div>
</div>
</div>
</div>
</body>
</html> 