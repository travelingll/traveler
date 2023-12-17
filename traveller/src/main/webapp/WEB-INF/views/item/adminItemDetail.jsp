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
<style>
form ul li label{
	width:200px;
	float:left;
}
</style>
</head> 
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>상품 등록</h2>
		<form action="itemInsertForm.do" method="post" id="insert_form" enctype="multipart/form-data">
		<input type="hidden" name="item_num" value="${item.item_num}">
			<ul>
				<li>
					상품표시여부
					<c:if test="${item.status==1}">미표시</c:if>
					<c:if test="${item.status==2}">판매가능</c:if>
					<c:if test="${item.status==3}">종료</c:if>
					<br>
				</li>
				<li>
				<br>
					상품명 ${item.item_name}
				</li>
				<li>
				<br>
					방문 도시 ${item.item_content}
				</li>
				<li>
				<br>
					상품 가격 <fmt:formatNumber value="${item.item_price}"/>원
				</li>
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px">
					<br>
					1일차 사진
					<br>
				</li>
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="150px">
					<br>
					2일차 사진
					<br> 
				</li>
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="150px">
					<br>
					3일차 사진
					<br> 
				</li>
					<c:if test="${!empty item.item_img4}">
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="150px">
					<br>
					4일차 사진
					<br>
				</li>
				<br>
					</c:if>
					<c:if test="${!empty item.item_img4 && item.item_img5}">
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="150px">
					<br>
					5일차 사진
					<br>
				</li>
					</c:if>
					<c:if test="${!empty item.item_img4 && item.item_img5 && item.item_img6}">
				<li>
				<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="150px">
					<br>
					6일차 사진
					<br>
				</li>
					</c:if>
				<li>
				<br>
					여행지
					<c:if test= "${item.item_st1==1}">동남아</c:if>
					<c:if test= "${item.item_st1==2}">북미</c:if>
					<c:if test= "${item.item_st1==3}">호주</c:if>
					<c:if test= "${item.item_st1==4}">유럽</c:if>
					<c:if test= "${item.item_st1==5}">국내</c:if>
				</li>
				<li>
				<br>
					여행스타일1
					<c:if test= "${item.item_st2==1}">혼자</c:if>
					<c:if test= "${item.item_st2==2}">연인</c:if>
					<c:if test= "${item.item_st2==3}">친구</c:if>
				</li>
				<li>
				<br>
					여행스타일2
					<c:if test= "${item.item_st3==1}">휴양</c:if>
					<c:if test= "${item.item_st3==2}">액티비티</c:if>
					<c:if test= "${item.item_st3==3}">관광</c:if>
				</li>
				<li>
				<br>
					여행출발일 ${item.date_start}
				</li>
				<li>
				<br>
					여행종료일 ${item.date_end}
				</li>
				<li>
				<br>
					모집인원 ${item.quantity}
				</li>
			</ul>
			<div class="align-center">
				<input type="button" value="수정" onclick="location.href='itemModifyForm.do?item_num=${item.item_num}'">
				<input type="button" value="목록" onclick="location.href='itemUpdateList.do'">
			<!--<input type="button" value="홈으로" onclick=request.getContextPath()+"/main/main.do">  -->
			</div>
		</form>
	</div>
</div>
</body>
</html>