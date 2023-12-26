<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#insert_form').submit(function(){
		if($('input[name="status"]:checked').length<1){
			alert('상품 표시 종류를 선택하세요');
			return false;
		}
		if($('input[name="item_st1"]:checked').length<1){
			alert('여행지를 선택하세요');
			return false;
		}
		if($('input[name="item_st2"]:checked').length<1){
			alert('여행스타일1을 입력하세요');
			return false;
		}
		if($('input[name="item_st3"]:checked').length<1){
			alert('여행스타일2를 입력하세요');
			return false;
		}
		
		let items = document.querySelectorAll('.insert_check');
		for(let i=0; i<items.length; i++){
			let label = document.querySelector('label[for="'+items[i].id+'"]');
			if(items[i].value.trim()==''){
				alert(label.textContent + ' 항목은 필수 입력입니다.');
				items[i].value='';
				items[i].focus();
				return false;
			}
		}
		
		$('#photo_btn1').click(function(){
			$('#photo_choice1').show();
			$(this).hide();
		});
		
		
		
	});
});
</script>
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
											<form action="itemInsertForm.do" method="post" id="insert_form" enctype="multipart/form-data" style="text-align:center;">
											<input type="hidden" name="item_num" value="${item.item_num}">
												<ul>
													<li>
														<b>상품표시여부 : </b>
														<c:if test="${item.status==1}">미표시</c:if>
														<c:if test="${item.status==2}">판매가능</c:if>
														<c:if test="${item.status==3}">종료</c:if>
														<br>
													</li>
													<li>
													<br>
														<b>상품명 : </b> ${item.item_name}
													</li>
													<li>
													<br>
														<b>방문 도시 : </b> ${item.item_content}
													</li>
													<li>
													<br>
														<b>상품 가격 : </b> <fmt:formatNumber value="${item.item_price}"/>원
													</li>
													<li>
													<br>
														<b>1일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px">		
														<br>
													</li>
													<li>
													<br>
														<b>2일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="150px">
														<br>
													</li>
													<li>
													<br>
														<b>3일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="150px">
														<br>
													</li>
														<c:if test="${!empty item.item_img4}">
													<li>
													<br>
														<b>4일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="150px">
														<br>
													</li>
													<br>
														</c:if>
														<c:if test="${!empty item.item_img4 && !empty item.item_img5}">
													<li>
													<br>
														<b>5일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="150px">
														<br>
													</li>
														</c:if>
														<c:if test="${!empty item.item_img4 && !empty item.item_img5 && ! empty item.item_img6}">
													<li>
													<br>
														<b>6일차 사진</b><br>
														<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="150px">
														<br>
													</li>
														</c:if>
													<li>
													<br>
														<b>여행지 : </b>
														<c:if test= "${item.item_st1==1}">동남아</c:if>
														<c:if test= "${item.item_st1==2}">북미</c:if>
														<c:if test= "${item.item_st1==3}">호주</c:if>
														<c:if test= "${item.item_st1==4}">유럽</c:if>
														<c:if test= "${item.item_st1==5}">국내</c:if>
													</li>
													<li>
													<br>
														<b>여행스타일1 : </b>
														<c:if test= "${item.item_st2==1}">혼자</c:if>
														<c:if test= "${item.item_st2==2}">연인</c:if>
														<c:if test= "${item.item_st2==3}">친구</c:if>
													</li>
													<li>
													<br>
														<b>여행스타일2 : </b>
														<c:if test= "${item.item_st3==1}">휴양</c:if>
														<c:if test= "${item.item_st3==2}">액티비티</c:if>
														<c:if test= "${item.item_st3==3}">관광</c:if>
													</li>
													<li>
													<br>
														<b>여행출발일 : </b> ${item.date_start}
													</li>
													<li>
													<br>
														<b>여행종료일 : </b> ${item.date_end}
													</li>
													<li>
													<br>
														<b>모집인원 : </b> ${item.quantity}
													</li>
												</ul>
												<br>
												<div class="align-center">
													<input type="button" value="수정" onclick="location.href='itemModifyForm.do?item_num=${item.item_num}'">
													<input type="button" value="목록" onclick="location.href='adminItemList.do'">
												<!--<input type="button" value="홈으로" onclick=request.getContextPath()+"/main/main.do">  -->
												</div>
											</form>
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