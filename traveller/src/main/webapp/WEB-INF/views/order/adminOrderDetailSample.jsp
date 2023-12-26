<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 예약관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#modi-btn').click(function(){
		$('#hiddenorder').show();
		$(this).hide();
		$('#list').hide();
	})
	$('#orderModify').submit(function(event){
		$.ajax({
			url:'orderModifyStatus.do',
			type:'post',
			dataType:'json',
			data:{orderStatus:$('input[name="orderStatus"]:checked').val(),
				order_num:$('#order_num').val()},
			success:function(param){
				if(param.result=='success'){
					$('#modi-btn').show();
					$('#hiddenorder').hide();
					$('#list').show();
				}else if(param.result=='logout'){
					alert('관리자 로그인 후 사용하세요');
				}else{
					alert('예약상태 수정 오류');
				}
			},
			error:function(){
				alert('네트워크 통신 오류 발생');
			}
		});
		
		
	})
});
</script>
<style type="text/css">
td{
	text-align:center;
}
table {
  width: 100%;
  border-collapse: collapse;
}

table th,
table td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

table th {
  background-color: #f2f2f2;
}

table tr:hover {
  background-color: #f2f2f2;
}

ul li:before {
  content: "";
  display: inline-block;
  width: 1em;
  margin-left: -1em;
}

ul li:last-child {
  margin-bottom: 0;
}
.detail{
  border: 1px solid black;
  margin-top: 10px;
  padding-top: 30px;
  display: flex;
  justify-content: center;
  line-height: 1.5;
  font-size: 12pt;
}
</style>
</head>
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
				<jsp:include page="/WEB-INF/views/common/header.jsp"/>
					<div id="container">
						<div class="inr">
							<div id="lnb" class="lnb">
								<div class="inr">
									<dl>
										<dt class="type">
											<a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 페이지</a>
										</dt>
										<dd>
											<ul class="list_lnb">
									  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">상품관리</a></li>
									  			<li><a href="${pageContext.request.contextPath}/admin/adminOrderList.do">예약관리</a></li>
									 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">상품등록</a></li>
									 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
											</ul>
										</dd>
									</dl>
								</div>
							</div> 
							<div id="contents" class="contents" style="min-height:70%;">
				    			<div class="text_wrap big fix">
				    						<strong class="tit">관리자 예약관리</strong>
				    			</div>
								<div>
								<table>
									<tr>
										<th>여행상품명</th>
										<th>구매수량</th>
										<th>상품가격</th>
									</tr>
									<c:forEach var="list" items="${detailList}">
										<tr>
											<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${list.item_num}">${list.item_name}</a></td>
											<td>${list.order_quantity}</td>
											<td><fmt:formatNumber value="${list.item_price}"/>원</td>
										</tr>
									</c:forEach>
								</table>
									<br>
								</div>
								<div class="detail" >
								<div style="width: 80%; text-align:center;">
								 <ul>
								 	<li>이름 : ${order.order_name}</li>
								 	<li> 이메일 : ${order.order_email}</li>
									<li> 전화번호 : ${order.order_phone}</li>
									<li> 생년월일 : ${order.order_birth} </li>
									<li> 성별 : 
											<c:if test="${order.order_gender==1}">남성</c:if>
											<c:if test="${order.order_gender==2}">여성</c:if> </li>
									<li>메세지 : ${order.notice} </li>
									<li>총 상품 금액 : <fmt:formatNumber value="${order.order_price}" />원</li>
									<li>사용한 적립금
											<fmt:formatNumber value="${order.order_price-order.order_custprice}"/>원</li>
									<li>결제 금액
											<fmt:formatNumber value="${order.order_price}"/>원</li>
									<li>결제수단 :
											<c:if test="${order.payment==1}">카드 결제</c:if>
											<c:if test="${order.payment==2}">무통장 입금</c:if></li>
									<li>예약 상태 : <c:if test="${order.order_status==1}">예약(사용전)</c:if>
										 <c:if test="${order.order_status==2}">사용중</c:if>
										 <c:if test="${order.order_status==3}">노쇼</c:if>
										 <c:if test="${order.order_status==4}">예약취소</c:if>
										 <br><br>
									</li>
									<li><br>
										<input type="button" id="modi-btn" value="예약상태 수정">
										<input type="button" value="목록" id="list" onclick="location.href='adminOrderList.do'">
												
										<div id="hiddenorder" style="display:none">
											<form id="orderModify">
												<input type="hidden" value="${order.order_num}" name="order_num" id="order_num">
												<ul>
													<li>
														<input type="radio" value="1" name="orderStatus" <c:if test="${order.order_status==1}">checked</c:if> id="st1">예약(사용전)
														<input type="radio" value="2" name="orderStatus" <c:if test="${order.order_status==2}">checked</c:if>  id="st2">사용중
														<input type="radio" value="3" name="orderStatus" <c:if test="${order.order_status==3}">checked</c:if> id="st3">노쇼
														<input type="radio" value="4" name="orderStatus" <c:if test="${order.order_status==4}">checked</c:if>  id="st4">예약취소
														<br><br>
														<input type="submit" value="수정">
													</li>
												</ul>
											</form>
										</div>
									</li>
									<br>
								 </ul>
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