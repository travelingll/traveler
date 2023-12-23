<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
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
		
	});
});

</script>
<!-- <style>
form ul li label{
	width:200px;
	float:left;
}
.page-main{
	background:#FFFFFF;
	margin:40px 0;
	border-radius:5px;
	box-shadow:0 2px 6px rgba(100,100,100,0.3);
	min-height:650px;
}
.content-main{
	padding:10px 20px;
}
</style>-->
</head> 
<body class="chrome">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <div id="__nuxt">
    	<div id="__layout">
    		<div id="wrapper">
    			<div id="screenArea">
    				<div id="wrap">
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
									<div class="order-form">
									<h1 class="order-title order-center">관리자 상품등록</h1>
									<form action="itemInsertForm.do" method="post" id="insert_form" enctype="multipart/form-data" class="input-form">
										<ul class="admin-ul">
											<li>
												<label>상품표시여부</label>
												<input type="radio" name="status" value="1" id="status1">미표시
												<input type="radio" name="status" value="2" id="status2">판매가능
												<input type="radio" name="status" value="3" id="status3">종료
											</li>
											<li>
												<label>여행지</label>
												<input type="radio" id="item_st1" name="item_st1" value="1" class="insert_check">동남아
												<input type="radio" id="item_st2" name="item_st1" value="2" class="insert_check">북미
												<input type="radio" id="item_st3" name="item_st1" value="3" class="insert_check">호주
												<input type="radio" id="item_st4" name="item_st1" value="4" class="insert_check">유럽
												<input type="radio" id="item_st5" name="item_st1" value="5" class="insert_check">국내
											</li>
											<li>
												<label>상품 유형</label>
												<input type="radio" name="item_case" value="1" id="case1">&nbsp;1&nbsp;
												<input type="radio" name="item_case" value="1" id="case2">&nbsp;2&nbsp;
												<input type="radio" name="item_case" value="1" id="case3">&nbsp;3&nbsp;
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
												<input type="number" id="price" name="price" maxlength="30" size="20" class="insert_check"> 원
											</li>
											<li>
												<label for="pic1">대표 상품사진(필수입력)</label>
												<input type="file" id="pic1" name="pic1" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
											</li>
											<li>
												<label for="pic2">상품사진1(필수입력)</label>
												<input type="file" id="pic2" name="pic2" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
											</li>
											<li>
												<label for="pic3">상품사진2(필수입력)</label>
												<input type="file" id="pic3" name="pic3" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="insert_check">
											</li>
											<li>
												<label for="pic4">상품사진3(선택입력)</label>
												<input type="file" id="pic4" name="pic4" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
											</li>
											<li>
												<label for="pic5">상품사진4(선택입력)</label>
												<input type="file" id="pic5" name="pic5" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
											</li>
											<li>
												<label for="pic6">상품사진5(선택입력)</label>
												<input type="file" id="pic6" name="pic6" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
											</li>
											<li>
												<label for="item_st6">여행스타일1</label>
												<input type="radio" id="item_st6" name="item_st2" value="1" class="insert_check">혼자
												<input type="radio" id="item_st7" name="item_st2" value="2" class="insert_check">연인
												<input type="radio" id="item_st8" name="item_st2" value="3" class="insert_check">친구
											</li>
											<li>
												<label for="item_st9">여행스타일2</label>
												<input type="radio" id="item_st9" name="item_st3" value="1" class="insert_check">휴양
												<input type="radio" id="item_st10" name="item_st3" value="2" class="insert_check">액티비티
												<input type="radio" id="item_st11" name="item_st3" value="3" class="insert_check">관광
											</li>
											<li>
												<label for="start_date">여행출발일</label>
												<input type="date" id="name" name="start_date" maxlength="100" size="20" class="insert_check">
											</li>
											<li>
												<label for="end_date">여행종료일</label>
												<input type="date" id="name" name="end_date" maxlength="100" size="20" class="insert_check">
											</li>
											<li>
												<label for="quantity">모집인원</label>
												<input type="number" id="quantity" name="quantity" min="1" size="3" class="insert_check">
											</li>
										</ul>
										<div class="my-btn-align">
											<input type="submit" value="등록">
											<input type="button" value="목록" onclick="location.href='itemList.do'" id="home">
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
</div>
</body>
</html>