<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		
		$('#photo_btn1').click(function(){
			$('#photo_choice1').show();
			$(this).hide();
		});
		
		
		
	});
});
</script>
</head> 
<body class="chrome">
	<div id="wrapper"><div id="screenArea">  
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div id="container"><div class="inr">	<div id="lnb" class="lnb"><div class="inr">
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
			</div></div>
				<div id="contents" class="contents">
					<div class="ly_wrap main_cuc">
						<div class="inr"><div class="text_wrap big fix">
							<strong class="tit">관리자 상품관리</strong>
						</div> 
						<div class="panels"><div id="tabPkg" class="panel selected"><div class="tbl">
							<form action="itemInsertForm.do" method="post" id="insert_form" enctype="multipart/form-data" style="text-align:center;">
							<input type="hidden" name="item_num" value="${item.item_num}">
								<table class="board_type">
									<colgroup>
										<col style="width: 25%;">
										<col style="width: 75%;"> 
									</colgroup> 
									<tr>
										<th>상품표시여부</th>
										<td>
											<c:if test="${item.status==1}">미표시</c:if>
											<c:if test="${item.status==2}">판매가능</c:if>
											<c:if test="${item.status==3}">종료</c:if>
										</td>
									</tr>
									<tr>
										<th>상품명</th>
										<td>${item.item_name}</td>
									</tr>
									<tr>
										<th>방문 도시</th>
										<td>${item.item_content}</td>
									</tr>
									<tr>
										<th>상품 가격</th>
										<td><fmt:formatNumber value="${item.item_price}"/>원</td>
									</tr>
									<tr>
										<th>1일차 사진</th>
										<td>
											<img src="${pageContext.request.contextPath}/upload/${item.item_img1}" width="150px">	
										</td>	
									</tr>
									<tr>
										<th>2일차 사진</th>
										<td>
											<img src="${pageContext.request.contextPath}/upload/${item.item_img2}" width="150px">
										</td>
									</tr>
									<tr>
										<th>3일차 사진</th>
										<td>
											<img src="${pageContext.request.contextPath}/upload/${item.item_img3}" width="150px">
										</td>
									</tr>
									<c:if test="${!empty item.item_img4}">
										<tr>
											<th>4일차 사진</th>
											<td>
												<img src="${pageContext.request.contextPath}/upload/${item.item_img4}" width="150px">
											</td>
										</tr>
									</c:if>
									<c:if test="${!empty item.item_img4 && !empty item.item_img5}">
										<tr>
											<th>5일차 사진</th>
											<td>
												<img src="${pageContext.request.contextPath}/upload/${item.item_img5}" width="150px">
											</td>
										</tr>
									</c:if>
									<c:if test="${!empty item.item_img4 && !empty item.item_img5 && ! empty item.item_img6}">
										<tr>
											<th>6일차 사진</th>
											<td>
												<img src="${pageContext.request.contextPath}/upload/${item.item_img6}" width="150px">
											</td>
											
										</tr>
									</c:if>
									<tr>
										<th>여행지</th>
										<td>
											<c:if test= "${item.item_st1==1}">동남아</c:if>
											<c:if test= "${item.item_st1==2}">북미</c:if>
											<c:if test= "${item.item_st1==3}">호주</c:if>
											<c:if test= "${item.item_st1==4}">유럽</c:if>
											<c:if test= "${item.item_st1==5}">국내</c:if>
										</td>
									</tr>
									<tr>
										<th>여행스타일1</th>
										<td>
											<c:if test= "${item.item_st2==1}">혼자</c:if>
											<c:if test= "${item.item_st2==2}">연인</c:if>
											<c:if test= "${item.item_st2==3}">친구</c:if>
										</td>
									</tr>
									<tr>
										<th>여행스타일2</th>
										<td>
											<c:if test= "${item.item_st3==1}">휴양</c:if>
											<c:if test= "${item.item_st3==2}">액티비티</c:if>
											<c:if test= "${item.item_st3==3}">관광</c:if>
										</td>
									</tr>
									<tr>
										<th>여행출발일</th>
										<td>${item.date_start}</td>
									</tr>
									<tr>
										<th>여행종료일 </th>
										<td>${item.date_end}</td>
									</tr>
									<tr>
										<th>모집인원</th>
										<td>${item.quantity}</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center;">
											<input type="button" value="수정" onclick="location.href='itemModifyForm.do?item_num=${item.item_num}'">
											<input type="button" value="목록" onclick="location.href='adminItemList.do'">
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div></div>
	</div></div></div></div>
</body>
</html>