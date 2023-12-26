<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderTable.css">
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
		
		/* $('.photo').change(function(){
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
			
			
		}); */
		$('.photo_reset').click(function(){
			
			$(this).parent().parent().find('.pic').attr('src', photo_path);
			$(this).siblings('.photo').val('');
			$(this).parent().hide();
			$(this).parent().parent().find('.photo_btn').show();
		
		});
		const status = $('#closing').attr('data-num');
		const item_num=$('#closing').attr('data-itemnum');
		$('#closing').click(function(){
			var choice = confirm('본 상품을 마감하시겠습니까?');
			if(choice){
				$('#closing-cancel').show();
				$('#closing').hide();
				
			$.ajax({
				url:'adminItemModifyStatus.do',
				type:'post',
				data:{status:status,item_num:item_num},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인 후 사용하세요');
					}else if(param.result=='success'){
						location.reload();
						alert('본 상품을 마감처리하였습니다. 상세페이지에서 확인해주세요');
					}else{
						alert('마감처리 오류 발생');
					}
				},
				error:function(){
						alert('네트워크 통신 오류');
					}
				})
			}
		})
		
		$('#closing-cancel').click(function(){
			$('#closing').show();
			$('#closing-cancel').hide();
			var status=2;
			$.ajax({
				url:'adminItemModifyStatus.do',
				type:'post',
				data:{status:status,item_num:item_num},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인 후 사용하세요');
					}else if(param.result=='success'){
						alert('본 상품을 마감취소처리하였습니다. 상세페이지에서 확인해주세요');
					}else{
						alert('마감처리 오류 발생');
					}
				},
				error:function(){
						alert('네트워크 통신 오류');
					}
				})
			
		})
		
		
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
									<div class="text_wrap big fix">
										<strong class="tit">관리자 상품 수정</strong>
									</div>
									<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
										<form action="itemModify.do" method="post" id="insert_form" enctype="multipart/form-data" style="text-align:center;">
											<input type="hidden" name="item_num" value="${item.item_num}">
											<table class="board_type">
												<colgroup>
													<col style="width: 30%;">
													<col style="width: 70%;"> 
												</colgroup> 
												<tr>
													<th><label><b>상품표시여부</b></label></th>
													<td>
														<input type="radio" name="status" value="1" id="status1" <c:if test="${item.status==1}"> checked="checked"</c:if> >미표시
														<input type="radio" name="status" value="2" id="status2" <c:if test="${item.status==2}"> checked="checked"</c:if> >판매가능
														<input type="radio" name="status" value="3" id="status3" <c:if test="${item.status==3}"> checked="checked"</c:if> >종료
													</td>
												</tr>
												<tr>
													<th><label><b>지역</b></label></th>
													<td>
														<c:if test="${item.item_st1==1}">동남아</c:if>
														<c:if test="${item.item_st1==2}">북미</c:if>
														<c:if test="${item.item_st1==3}">호주</c:if>
														<c:if test="${item.item_st1==4}">유럽</c:if>
														<c:if test="${item.item_st1==5}">국내</c:if>
													</td>
												<tr>
													<th><label><b>상품유형</b></label></th>
													<td>
														${item.item_case}
													</td>
												</tr>
												<tr>
													<th><label for="name"><b>상품명</b></label></th>
													<td>
														<textarea id="name" name="name" cols="50" rows="5" class="insert_check" >${item.item_name}</textarea><br>
													</td>
												</tr>
												<tr>
													<th><label for="city"><b>방문도시</b></label></th>
													<td>
														<textarea id="city" name="city" cols="50" rows="5" class="insert_check">${item.item_content}</textarea>
													</td>
												</tr>
												<tr>
													<th><label for="price"><b>상품가격</b></label></th>
													<td>
														<input type="number" id="price" name="price" maxlength="30" size="20" value="${item.item_price}" class="insert_check">원
													</td>
												</tr>
												<tr>
													<th><label for="pic1"><b>1일차 사진(필수입력)</b></label></th>
													<td>
														<input type="button" value="수정" class="photo_btn">
														<input type="file" id="pic1" name="pic1" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
														<input type="button" value="취소" class="photo_reset">	
														<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px" class="pic">
													</td>
												</tr>
												<tr>
													<th><label for="pic"><b>2일차 사진(필수입력)</b></label></th>
													<td>
														<input type="button" value="수정" class="photo_btn">
														<input type="file" id="pic2" name="pic2" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
														<input type="button" value="취소" class="photo_reset">	
														<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="150px" class="pic">
													</td>
												</tr>
												<tr>
													<th><label for="pic"><b>3일차 사진(필수입력)</b></label></th>
													<td>
														<input type="button" value="수정" class="photo_btn">
														<input type="file" id="pic3" name="pic3" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
														<input type="button" value="취소" class="photo_reset">	
														<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="150px" class="pic">
													</td>
												</tr>
												<tr>
													<th><label for="pic4"><b>4일차 사진(선택입력)</b></label></th>
													<td>
														<c:if test="${empty item.item_img4}">
														<input type="file" id="pic4" name="pic4" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
														</c:if>
														<c:if test="${!empty item.item_img4}">
														<input type="button" value="수정" class="photo_btn">
														</c:if>
														<c:if test="${!empty item.item_img4}">
															<div class="photo_choice" style="display:none;">
																<input type="file" id="pic4" name="pic4" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
																<br>
																<input type="button" value="취소" class="photo_reset">	
															</div>
																<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="150px">
														</c:if>
													</td>
												</tr>
												<tr>
													<th><label for="pic5"><b>5일차 사진(선택입력)</b></label></th>
													<td>
														<c:if test="${empty item.item_img5}">
														<input type="file" id="pic5" name="pic5" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
														</c:if>
														<c:if test="${!empty item.item_img5}">
														<input type="button" value="수정" class="photo_btn">
														</c:if>
														<c:if test="${!empty item.item_img5}">
															<input type="file" id="pic5" name="pic5" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
															<input type="button" value="취소" class="photo_reset">	
															<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="150px">
														</c:if>
													</td>
												</tr>
												<tr>
													<th><label for="pic6"><b>6일차 사진(선택입력)</b></label></th>
													<td>
														<c:if test="${empty item.item_img6}">
														<input type="file" id="pic6" name="pic6" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" class="plus">
														</c:if>
														<c:if test="${!empty item.item_img6}">
														<input type="button" value="수정" class="photo_btn">
														</c:if>
														<c:if test="${!empty item.item_img6}">
															<input type="file" id="pic6" name="pic6" class="photo" maxlength="30" size="20" accept="image/gif, image/jpeg, image/png" value="${item.item_img1}" class="insert_check">
															<input type="button" value="취소" class="photo_reset">	
															<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="150px">
														</c:if>
													</td>
												</tr>
												<tr>
													<th><label for="item_st1"><b>여행지 : </b></label></th>
													<td>
														<input type="radio" id="item_st1" name="item_st1" value="1" <c:if test="${item.item_st1==1}">checked="checked"</c:if>  class="insert_check">동남아
														<input type="radio" id="item_st2" name="item_st1" value="2" <c:if test="${item.item_st1==2}">checked="checked"</c:if>  class="insert_check">북미
														<input type="radio" id="item_st3" name="item_st1" value="3" <c:if test="${item.item_st1==3}">checked="checked"</c:if>  class="insert_check">호주
														<input type="radio" id="item_st4" name="item_st1" value="4" <c:if test="${item.item_st1==4}">checked="checked"</c:if>  class="insert_check">유럽
														<input type="radio" id="item_st5" name="item_st1" value="5" <c:if test="${item.item_st1==5}">checked="checked"</c:if>  class="insert_check">국내
													</td>
												</tr>
												<tr>
													<th><label for="item_st6"><b>여행스타일1 : </b></label></th>
													<td>
														<input type="radio" id="item_st6" name="item_st2" value="1" <c:if test="${item.item_st2==1}">checked="checked"</c:if> class="insert_check">혼자
														<input type="radio" id="item_st7" name="item_st2" value="2" <c:if test="${item.item_st2==2}">checked="checked"</c:if> class="insert_check">연인
														<input type="radio" id="item_st8" name="item_st2" value="3" <c:if test="${item.item_st2==3}">checked="checked"</c:if> class="insert_check">친구
													</td>
												</tr>
												<tr>
													<th><label for="item_st9"><b>여행스타일2 : </b></label></th>
													<td>
														<input type="radio" id="item_st9" name="item_st3" value="1"  <c:if test="${item.item_st3==1}">checked="checked"</c:if>  class="insert_check">휴양
														<input type="radio" id="item_st10" name="item_st3" value="2" <c:if test="${item.item_st3==2}">checked="checked"</c:if>  class="insert_check">액티비티
														<input type="radio" id="item_st11" name="item_st3" value="3" <c:if test="${item.item_st3==3}">checked="checked"</c:if>  class="insert_check">관광
													</td>
												</tr>
												<tr>
													<th><label for="start_date"><b>여행출발일 : </b></label></th>
													<td>
														<input type="date" id="name" name="start_date" maxlength="100" size="20" value="${item.date_start}" class="insert_check">
													</td>
												</tr>
												<tr>
													<th><label for="end_date"><b>여행종료일</b></label></th>
													<td>	
														<input type="date" id="name" name="end_date" maxlength="100" size="20" value="${item.date_end}" class="insert_check">
													</td>
												</tr>
												<tr>
													<th><label for="quantity"><b>모집인원 : </b></label></th>
													<td>
														<input type="number" id="quantity" name="quantity" min="1" size="3" value="${item.quantity}" class="insert_check status">
														<input type="button" id="closing" data-num="3" data-itemnum="${item.item_num}" value="마감">
														<input type="button" id="closing-cancel" value="마감취소" data-num="2" data-itemnum="${item.item_num}" style="display:none;">
													</td>
												</tr>
											</table>
											<div class="align-center">
												<input type="submit" value="수정">
												<input type="button" value="목록" onclick="location.href='itemUpdateList.do'">
												<input type="button" value="본 상품으로 이동" onclick="location.href='${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}'">
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