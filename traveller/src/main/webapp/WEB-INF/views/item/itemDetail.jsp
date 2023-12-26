<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상세정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">

<style>
	.content-center{
		float: left;
        width: 67%;
	}
	.content-main{
	padding:10px 20px;
	margin-left:230px;
	}
	.content-right{
	 	float: right;
        width: 27%;
	}
	.last-div{
	clear: right;
	}
	
a {
    color: #333;
    text-decoration: none; 
}
#lnb.lnb ul.list_lnb > li {
    border-bottom: 1px solid #ddd;
    line-height: 50px;
}
.list_lnb li{
	font-size:14px;
}
hr{
    color: black;
  }
.button {
  background-color: black;
  border: none;
  color: black;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  padding: 18px 20px;
  margin-right: 20px;
  border-radius: 8px;
}
img{
	width:80%;
}
th {
  background-color:#e3e3e3; /* 살짝 회색 배경색을 나타내는 색상 코드 */
}


.notice:hover {
  background-color:  #a2a4a8; /* 마우스 호버 시 배경색 변경 */
}
button {
    position: relative;
    display: inline-block;
    height: 35px;
    line-height: 23px;
    font-size: 12px;
    padding: 0 10px;
    margin-bottom: 10px;
    color: #666;
    background-color: #fff;
    font-weight: 400;
    text-align: center;
    border-radius: 4px;
    border: solid 1px #c2c2c2;
    width:320px;
}
</style>
<script>
	function openPopup1() {
    window.open("popup1.do", "예약시 유의사항", "width=500,height=500");
	}
	function openPopup2() {
    window.open("popup2.do", "여행시 유의사항", "width=500,height=500");
	}

</script>
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
						<a href="#">여행상품</a>
					</dt>
					<dd>
						<ul class="list_lnb">
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">동남아</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=2">북미</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">호주</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">유럽</a></li>
							<li><a href="${pageContext.request.contextPath}/item/itemMenu.do?list_num=1">국내</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		</div>
	</div>
	
	
	<div class="content-main">
	<!-- item-header 영역 시작 -->
		<div class="item-header">
			<div class="content-center">
				<div class="content-main-left">
					<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" >
					<br><br><br>
				</div>
			</div>
			<div class="content-right">
				<div >
					<h3>상품코드 ${item.item_num}</h3> <br>
				</div>
				<br>
				<div>
					<h3>${item.item_name}</h3><br>
				</div>
				<br>
				<div >
				<div class="last-div">
					<h2>가격 <fmt:formatNumber value="${item.item_price}"/>원</h2>
				</div>
				</div>
					<div>
					<br><br><br>
					<c:if test="${item.status==2}">
						<form id="reservationForm" action="${pageContext.request.contextPath}/cart/write.do" method="post">
						<label for="order_quantity">구매수량</label>
						<input type="number" name="order_quantity" id="order_quantity" value="1" min="1" max="${item.quantity}">
						<br><br><br><br><br>
						<input type="hidden" name="item_num" value="${item.item_num}" >
						<input type="hidden" name="item_price" value="${item.item_price}" >
						<input type="hidden" name="quantity" value="${item.quantity}">
	 					<input type="submit" value="장바구니에 담기" class="button">
						</form>
					</c:if>
					<c:if test="${item.status==3}">
	 					<input type="submit" value="판매종료" class="button" id="nosale">
	 					<script>$('#nosale').click(function(){alert('본 상품은 조기마감되었습니다. 감사합니다.')})</script>
					</c:if>
					</div>
			</div>
		</div>
		<!-- 테이블 시작 -->
		<!-- 트래블러's pick 시작-->
	<div class="content-center">
		<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">${item.item_name}</strong></div> 
									<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
										<table class="board_type" style="width: 100%;">
											<colgroup>
												<col style="width: 20%;"> 
												<col style="width: 45%;"> 
												<col style="width: 23%;"> 
												<col style="width: 12%;">
											</colgroup>
										<thead>
											<tr>
												<th colspan="4" >여행주요일정</th>
											</tr>
										</thead>
										<tbody>
												<tr>
													<td colspan="4">
													<h2>여행 기간 : ${item.date_start} ~ ${item.date_end }</h2>
													<br><br><br>
													<h3>여행 도시 : ${item.item_content}</h3>
													<br><br><br>
													<h3>모집 인원 : <span id="apply">${item.orderCount}</span>/${item.quantity}명</h3>
													
													</td>
												</tr>
										</tbody>
										</table><br><br>
									</div>
								</div>
							</div>
						</div>
	</div>
	<!-- 트래블러's pick 끝-->
		<!-- 테이블 끝 -->
	<!-- item-header 영역 끝 -->
		
	<!-- 상품가격 알림 시작 -->
		<div class="content-center">
		<hr size="5px" color="black">
		<table>
			<tr>
				<th>비고</th>
				<th>성인(만 12세 이상)</th>
				<th>아동(만 12세 미만)</th>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber value="${item.item_price}"/>원</td>
				<td><fmt:formatNumber value="${item.item_price * 0.8}"/>원</td>
			</tr>
		</table>
		<br>
		<br>
		<hr size="5px" color="black">
			<button class="notice" onclick="openPopup1()">예약시 유의사항</button>	
			<button class="notice" onclick="openPopup2()">여행시 유의사항</button>	
			<br><br><br>
		</div>
	<!-- 상품가격 알림 끝 -->
		
	
	<!-- 여행 상세정보 시작 -->
	<!-- 시작 -->
	<div class="content-center">
		<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit"></strong></div> 
									<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
										<table class="board_type" style="width: 100%;">
											<colgroup>
												<col style="width: 20%;"> 
												<col style="width: 45%;"> 
												<col style="width: 23%;"> 
												<col style="width: 12%;">
											</colgroup>
										<thead>
											<tr>
												<th colspan="4" >여행 상세정보</th>
											</tr>
										</thead>
										<tbody>
												<tr>
													<td colspan="4">
													<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" >
		
													<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" >
													
													<c:if test="${!empty item.item_img4}">
													<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" >
													</c:if>
													<c:if test="${!empty item.item_img4 && !empty item.item_img5}">
													<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" >
													</c:if>
													<c:if test="${!empty item.item_img4 && !empty item.item_img5 && !empty item.item_img6}">
													<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" >
													</c:if>
													</td>
												</tr>
										</tbody>
										</table><br><br>
									</div>
								</div>
							</div>
						</div>
	</div>
	<!-- 끝 -->
	<div class="content-center">
		
		
		
	
	</div>
	<!-- 여행 상세정보 끝 -->
	<!-- test시작 -->
	<div class="content-center">
		<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit"></strong></div> 
									<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
										<table class="board_type" style="width: 100%;">
											<colgroup>
												<col style="width: 20%;"> 
												<col style="width: 45%;"> 
												<col style="width: 23%;"> 
												<col style="width: 12%;">
											</colgroup>
										<thead>
											<tr>
												<th colspan="4" >여행 후기</th>
											</tr>
										</thead>
										<tbody>
												<tr>
													<td colspan="4">
													<c:if test="${order_status==2 && replyUsed==0}">
			<form action="itemReply.do" method="post">
	        <label for="comment">후기 내용:</label>
	        <input type="hidden" name="item_num" value="${item.item_num}">
	        <input type="hidden" name="item_st1" value="${item.item_st1}">
	        <input type="hidden" name="item_case" value="${item.item_case}">
	        <textarea id="comment" name="item_recontent" rows="4" cols="50"></textarea>
	        <br>
	        <input type="submit" value="후기 작성">
    		</form>
	</c:if>
    	<c:if test="${!empty replyList}">
    		<c:forEach var="reply" items="${replyList}">
    		<ul>
    		
    			<li>작성자 id : ${reply.user_id}      등록일 : ${reply.item_redate}</li>
    			<li>${reply.item_recontent}</li>
    			
            </ul>
    		</c:forEach>
    	</c:if>
    	<c:if test="${empty replyList}">
    		<h2>등록된 후기가 없습니다.</h2>
    	</c:if>
													</td>
												</tr>
										</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
	</div>
	<!-- test끝 -->
	<!-- 트래블러's pick 시작-->
	<div class="content-center" style="width:100%;">
		<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">트래블러's Pick</strong></div> 
									<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
										<table class="board_type">
											<colgroup>
												<col style="width: 20%;"> 
												<col style="width: 45%;"> 
												<col style="width: 23%;"> 
												<col style="width: 12%;">
											</colgroup>
										<thead>
											<tr>
												<th colspan="2">여행상품</th>
												<th>여행날짜</th>
												<th>가격<br></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${pickList}">
												<tr>
													<td><img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px"></td>
													<td><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><b>${item.item_name}</b></a></td>
													<td>${item.date_start} ~ ${item.date_end}</td>
													<td><fmt:formatNumber value="${item.item_price}"/>원<br></td>
												</tr>
											</c:forEach>
										</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
	</div>
	<!-- 트래블러's pick 끝-->
	</div>
</div>
</body>
</html>