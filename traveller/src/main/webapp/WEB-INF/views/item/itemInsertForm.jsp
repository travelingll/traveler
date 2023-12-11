<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		if($('input[type="radio" name="status"]:checked').length<1){
			alert('상품 표시 종류를 선택하세요');
			return false;
		}
		
		if($('input[type="radio" name="item_st1"]:checked').length<1){
			alert('여행지를 선택하세요');
			return false;
		}
		if($('input[type="radio" name="item_st2"]:checked').length<1){
			alert('여행스타일1을 1개 선택하세요');
			return false;
		}
		if($('input[type="radio" name="item_st3"]:checked').length<1){
			alert('여행스타일2를 1개 선택하세요');
			return false;
		}
		
		let items = document.querySelectorAll('insert_check');
		for(let i=0; i<items.length; i++){
			let label = document.querySelector('label[for="'+items[i].id+'"]');
			if(items[i].value.tirm()==''){
				alert(label.textContent + ' 항목은 필수 입력입니다.');
				items[i].value='';
				items[i].focus();
				return false;
			}
		}
		
	})
})
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>상품 등록</h2>
		<form action="itemInsert.do" method="post" id="insert_form" enctype="multipart/form-data">
			<ul>
				<li>
					<label>상품표시여부</label>
					<input type="radio" name="status" value="1" id="status1">미표시
					<input type="radio" name="status" value="2" id="status2">판매가능
					<input type="radio" name="status" value="3" id="status3">종료
				</li>
				<li>
					<label for="name">상품명</label>
					<input type="text" id="name" name="name" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label for="city">방문도시</label>
					<input type="text" id="city" name="city" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label for="price">상품가격</label>
					<input type="number" id="price" name="price" maxlength="30" size="20" class="insert_check">
				</li>
				<li>
					<label for="pic1">상품사진1</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
				</li>
				<li>
					<label for="pic1">상품사진2</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
				</li>
				<li>
					<label for="pic1">상품사진3</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
				</li>
				<li>
					<label for="pic1">상품사진4</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
				</li>
				<li>
					<label for="pic1">상품사진5</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
				</li>
				<li>
					<label for="pic1">상품사진6</label>
					<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
				</li>
				<li>
					<label for="item_st1">여행지</label>
					<input type="radio" id="item_st1" name="item_st1" value="1" class="insert_check">동남아
					<input type="radio" id="item_st1" name="item_st1" value="2" class="insert_check">북미
					<input type="radio" id="item_st1" name="item_st1" value="3" class="insert_check">호주
					<input type="radio" id="item_st1" name="item_st1" value="4" class="insert_check">유럽
					<input type="radio" id="item_st1" name="item_st1" value="5" class="insert_check">국내
				</li>
				<li>
					<label for="item_st2">여행스타일1</label>
					<input type="radio" id="item_st2" name="item_st2" value="1" class="insert_check">혼자
					<input type="radio" id="item_st2" name="item_st2" value="2" class="insert_check">연인
					<input type="radio" id="item_st2" name="item_st2" value="3" class="insert_check">친구
				</li>
				<li>
					<label for="item_st2">여행스타일2</label>
					<input type="radio" id="item_st3" name="item_st3" value="1" class="insert_check">휴양
					<input type="radio" id="item_st3" name="item_st3" value="2" class="insert_check">액티비티
					<input type="radio" id="item_st3" name="item_st3" value="3" class="insert_check">관광
				</li>
				<li>
					<label for="name">여행출발일</label>
					<input type="text" id="name" name="name" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label for="name">여행종료일</label>
					<input type="text" id="name" name="name" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label for="quantity">모집인원</label>
					<input type="number" id="quantity" name="quantity" min="1" size="3" class="insert_check">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='itemList.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>