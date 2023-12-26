<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 게시판(관리자)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
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
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout"></div>
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
								<div id="contents" class="contents">
									<div class="ly_wrap main_cuc">
										<div class="inr">
											<div class="text_wrap big fix">
												<strong class="tit">관리자 상품관리</strong>
											</div> 
											<!-- 여기서부터는 검색 필드입니다. -->
											<div class="search_field">
												<div class="box_search wide_type">
												<form id="adminListSearch" action="adminItemList.do" method="post">
													<select name="keyfield" class="keyfield" style="height:54px;">
														<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>상품이름</option>
														<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>상품내용</option>	
													</select>
														<input type="search" class="input_keyword" size="20" placeholder="검색어를 입력해 주세요" name="keyword" id="keyword" value="${param.keyword}" >
														<input type="submit" class="btn"  value="검색" style="height:54px;">
												</form>
											</div>
											<div id="contents" class="contents" data-v-bead000e="">
												<div class="text_wrap big"><strong class="tit">지역선택</strong>
													<div class="panels">
														<div id="tabPkg" class="panel selected">
															<div class="option_wrap">
																<div class="list-space">
																	<input class="btn st1" type="button" value="동남아" data-num="1">
																	<input class="btn st1" type="button" value="북미" data-num="2">
																	<input class="btn st1" type="button" value="호주" data-num="3">
																	<input class="btn st1" type="button" value="유럽" data-num="4">
																	<input class="btn st1" type="button" value="국내" data-num="5">                   
																</div>		
															</div>
															<div class="tbl">
															<table class="board_type">
																<colgroup>
																	<col style="width: 14%;"> 
																	<col style="width: 9.5%;"> 
																	<col style="width: 9.5%;"> 
																	<col style="width: 29%;">
																	<col style="width: 23%;"> 
																	<col style="width: 13%;"> 
																	<col style="width: 11%;"> 
																</colgroup>								 								
																	<thead>
																		<tr>
																			<th>여행상품번호</th>
																			<th>상태</th>
																			<th>여행지</th>
																			<th><a href="itemDetail.do">여행상품명</a></th>
																			<th>여행날짜</th>
																			<th>등록일</th>
																			<th>모집인원</th>
																		</tr>
																	</thead>
																	<c:forEach var="item" items="${itemList}">
																	<c:if test="${item.item_st1==st1 || st1==null }">
																	<tbody>
																		<tr>
																			<td>${item.item_num}</td>
																			<td><c:if test="${item.status==1}">미표시</c:if>
																				<c:if test="${item.status==2}">판매중</c:if>
																				<c:if test="${item.status==3}">판매종료</c:if>
																			</td>
																			<td>
																				<c:if test="${item.item_st1==1}">동남아</c:if>
																				<c:if test="${item.item_st1==2}">북미</c:if>
																				<c:if test="${item.item_st1==3}">호주</c:if>
																				<c:if test="${item.item_st1==4}">유럽</c:if>
																				<c:if test="${item.item_st1==5}">국내</c:if>
																			</td>
																			<td><a href="adminItemDetail.do?item_num=${item.item_num}">${item.item_name}</a></td>
																			<td>${item.date_start} ~ ${item.date_end}</td>
																			<td>${item.reg_date}</td>
																			<td><span class="total_order">${item.orderCount}</span>/ ${item.quantity} 명</td>
																		</tr>
																	
																	</tbody>
																	</c:if>
																</c:forEach>
																
															</table>
															<br><br><br>
														<div style="text-align:center;">
															${page}
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
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