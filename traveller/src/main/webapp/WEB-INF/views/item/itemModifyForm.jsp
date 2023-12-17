<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
	});
		$('.photo_btn').click(function(){
			let photo_choice = $(this).parent().parent().find('.photo_choice');
			photo_choice.show();
			$(this).hide();
			
		photo_path = $(this).parent().parent().find('.pic').attr('src');
		
		});
		
		$('.photo').change(function(){
			photo_path = $(this).parent().parent().find('.photo');
			let pic = $(this).parent().parent().find('.pic');
			let my_photo = this.files[0];
			
			if(!my_photo){
				pic.attr('src',photo_path);
				return false;
			}
			if(my_photo.size>10*1024*1024){
				alert(Math.round(my_photo.size/1024*1024) + 'MB (10MB까지만 업로드 가능)');
				pic.attr('src',photo_path);
				$(this).val('');
				return;
			}
			
			
		});
		$('.photo_reset').click(function(){
			
			$(this).parent().parent().find('.pic').attr('src', photo_path);
			$(this).siblings('.photo').val('');
			$(this).parent().hide();
			$(this).parent().siblings('.photo_btn').show();
		
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
		<h2>상품 수정</h2>
		<form action="itemModify.do" method="post" id="insert_form" enctype="multipart/form-data">
		<input type="hidden" name="item_num" value="${item.item_num}">
			<ul>
				<li>
					<label>상품표시여부 : </label>
					<input type="radio" name="status" value="1" id="status1" <c:if test="${item.status==1}"> checked="checked"</c:if> >미표시
					<input type="radio" name="status" value="2" id="status2" <c:if test="${item.status==2}"> checked="checked"</c:if> >판매가능
					<input type="radio" name="status" value="3" id="status3" <c:if test="${item.status==3}"> checked="checked"</c:if> >종료
				</li>
				<li>
					<label for="name">상품명</label>
					<input type="text" id="name" name="name" maxlength="100" size="20" value="${item.item_name}" class="insert_check">
				</li>
				<li>
					<label for="city">방문도시</label>
					<input type="text" id="city" name="city" maxlength="100" size="20" value="${item.item_content}" class="insert_check">
				</li>
				<li>
					<label for="price">상품가격</label>
					<input type="number" id="price" name="price" maxlength="30" size="20" value="${item.item_price}" class="insert_check">원
				</li>
				<li>
					<br>
						<div class="align-center">
							<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px" class="pic">
							<br>
							<br>
						</div>
						<div class="align-center">
							<label for="pic1">1일차 사진(필수입력)</label>
							<input type="button" value="수정" class="photo_btn">
						</div>
						<div class="photo_choice" style="display:none;">
							<input type="file" id="pic1" name="pic1" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
							<br>
							<input type="button" value="등록" class="photo_submit" data-num="1">
							<input type="button" value="취소" class="photo_reset">	
						</div>					
					<br> 
				</li>
				<li>
					<br>
					<div class="align-center">
						<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="150px" class="pic">
						<br>
						<br>
					</div>
						<div class="align-center">
						<label for="pic">2일차 사진(필수입력)</label>
							<input type="button" value="수정" class="photo_btn">
						</div>
						<div class="photo_choice" style="display:none;">
						<input type="file" id="pic2" name="pic2" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
							<br>
							<input type="button" value="등록" class="photo_submit" data-num="2">
							<input type="button" value="취소" class="photo_reset">	
						</div>					
					<br> 
				</li>
				<li>
					<br>
					<div class="align-center">
						<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="150px" class="pic">
						<br>
						<br>
					</div>
						<div class="align-center">
						<label for="pic">3일차 사진(필수입력)</label>
							<input type="button" value="수정" class="photo_btn">
						</div>
						<div class="photo_choice" style="display:none;">
						<input type="file" id="pic3" name="pic3" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
							<br>
							<input type="button" value="등록" class="photo_submit" data-num="3">
							<input type="button" value="취소" class="photo_reset">	
						</div>					
					<br> 
				</li>
				
				<li>
					<br>
					<label for="pic4">4일차 사진(선택입력)</label>
					<input type="file" id="pic4" name="pic4" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
					<br>
					<c:if test="${!empty item.item_img4}">
					<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="150px">
					<input type="button" value="수정"> 
					</c:if>
					<br>
				</li>
				<li>
					<label for="pic5">5일차 사진(선택입력)</label>
					<input type="file" id="pic5" name="pic5" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
					<br>
					<c:if test="${!empty item.item_img4 && item.item_img5}">
					<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="150px">
					<input type="button" value="수정"> 
					</c:if>
					<br>
				</li>
				<li>
					<label for="pic6">6일차 사진(선택입력)</label>
					<input type="file" id="pic6" name="pic6" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
					<c:if test="${!empty item.item_img4 && item.item_img5 && item.item_img6}">
					<br>
					<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="150px">
					<input type="button" value="수정"> 
					</c:if>
					<br>
				</li>
				<li>
				<br>
					<label for="item_st1">여행지</label>
					<input type="radio" id="item_st1" name="item_st1" value="1" <c:if test="${item.item_st1==1}">checked="checked"</c:if>  class="insert_check">동남아
					<input type="radio" id="item_st2" name="item_st1" value="2" <c:if test="${item.item_st1==2}">checked="checked"</c:if>  class="insert_check">북미
					<input type="radio" id="item_st3" name="item_st1" value="3" <c:if test="${item.item_st1==3}">checked="checked"</c:if>  class="insert_check">호주
					<input type="radio" id="item_st4" name="item_st1" value="4" <c:if test="${item.item_st1==4}">checked="checked"</c:if>  class="insert_check">유럽
					<input type="radio" id="item_st5" name="item_st1" value="5" <c:if test="${item.item_st1==5}">checked="checked"</c:if>  class="insert_check">국내
				</li>
				<li>
					<label for="item_st6">여행스타일1</label>
					<input type="radio" id="item_st6" name="item_st2" value="1" <c:if test="${item.item_st2==1}">checked="checked"</c:if> class="insert_check">혼자
					<input type="radio" id="item_st7" name="item_st2" value="2" <c:if test="${item.item_st2==2}">checked="checked"</c:if> class="insert_check">연인
					<input type="radio" id="item_st8" name="item_st2" value="3" <c:if test="${item.item_st2==3}">checked="checked"</c:if> class="insert_check">친구
				</li>
				<li>
					<label for="item_st9">여행스타일2</label>
					<input type="radio" id="item_st9" name="item_st3" value="1"  <c:if test="${item.item_st3==1}">checked="checked"</c:if>  class="insert_check">휴양
					<input type="radio" id="item_st10" name="item_st3" value="2" <c:if test="${item.item_st3==2}">checked="checked"</c:if>  class="insert_check">액티비티
					<input type="radio" id="item_st11" name="item_st3" value="3" <c:if test="${item.item_st3==3}">checked="checked"</c:if>  class="insert_check">관광
				</li>
				<li>
					<label for="start_date">여행출발일</label>
					<input type="date" id="name" name="start_date" maxlength="100" size="20" value="${item.date_start}" class="insert_check">
				</li>
				<li>
					<label for="end_date">여행종료일</label>
					<input type="date" id="name" name="end_date" maxlength="100" size="20" value="${item.date_end}" class="insert_check">
				</li>
				<li>
					<label for="quantity">모집인원</label>
					<input type="number" id="quantity" name="quantity" min="1" size="3" value="${item.quantity}" class="insert_check">
					<input type="button" id="quantity" value="마감">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="수정">
				<input type="button" value="목록" onclick="location.href='itemUpdateList.do'">
			<!--<input type="button" value="홈으로" onclick=request.getContextPath()+"/main/main.do">  -->
			</div>
		</form>
	</div>
</div>
</body>
</html>