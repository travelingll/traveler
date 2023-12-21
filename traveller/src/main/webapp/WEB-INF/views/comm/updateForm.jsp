<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#update_form').submit(function(){
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
		if($('input[name="category"]:checkbox:checked').length<1){
			alert('카테고리를 체크해주세요');
			return false;
		}
		if($('input[name="tag"]:checkbox:checked').length<1){
			alert('태그를 1개 이상 체크해주세요');
			return false;
		}
	})
})
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>게시판 글수정</h2>
		<form id="update_form" action="update.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="comm_num" value="${comm.comm_num}">
			<ul>
				<li>
					<label for="comm_title">제목</label>
					<input type="text" name="comm_title" id="comm_title" value="${comm.comm_title}" maxlength="50" class="insert_check">
				</li>
				<li>
					<label for="comm_content">내용</label>
					<textarea rows="5" cols="30" name="comm_content"  id="comm_content" class="insert_check">${comm.comm_content}</textarea>
				</li>
				<li>
					<label for="filename1">파일</label>
					<input type="file" name="filename1" id="filename1"  accept="image/gif, image/png, image/jpeg" class="insert_check">
					<c:if test="${!empty comm.filename1}">
						<div id="file_detail">
							(${comm.filename1})파일이 등록되어 있습니다.
							<input type="button" value="파일삭제" id="file_del">
							<script>
								$(function(){
									$('#file_del').click(function(){
										let choice = confirm('삭제하시겠습니까?');
										if(choice){
											$.ajax({
												url:'deleteFile.do',
												type:'post',
												data:{comm_num:${comm.comm_num}},
												dataType:'json',
												success:function(param){
													if(param.result=='logout'){
														alert('로그인 후 사용하세요');
													}else if(param.result=='success'){
														$('#file_detail1').hide();
													}else if(param.result=='wrongAccess'){
														alert('잘못된 접속입니다');
													}else{
														alert('파일 삭제 오류 발생');
													}
												},
												error:function(){
													alert('네트워크 오류 발생');
												}
											})
										}
									});
								});
							</script>  
						</div>
					</c:if>
					</li>
					<li>
					<label for="filename2">파일</label>
					<input type="file" name="filename2" id="filename2"  accept="image/gif, image/png, image/jpeg">
					<c:if test="${!empty comm.filename2}">
						<div id="file_detail">
							(${comm.filename2})파일이 등록되어 있습니다.
							<input type="button" value="파일삭제" id="file_del">
							<script>
								$(function(){
									$('#file_del').click(function(){
										let choice = confirm('삭제하시겠습니까?');
										if(choice){
											$.ajax({
												url:'deleteFile.do',
												type:'post',
												data:{comm_num:${comm.comm_num}},
												dataType:'json',
												success:function(param){
													if(param.result=='logout'){
														alert('로그인 후 사용하세요');
													}else if(param.result=='success'){
														$('#file_detail2').hide();
													}else if(param.result=='wrongAccess'){
														alert('잘못된 접속입니다');
													}else{
														alert('파일 삭제 오류 발생');
													}
												},
												error:function(){
													alert('네트워크 오류 발생');
												}
											})
										}
									});
								});
							</script>  
						</div>
					</c:if>
					</li>
					<li>
					<label for="filename3">파일</label>
					<input type="file" name="filename3" id="filename3"  accept="image/gif, image/png, image/jpeg">
					<c:if test="${!empty comm.filename3}">
						<div id="file_detail">
							(${comm.filename3})파일이 등록되어 있습니다.
							<input type="button" value="파일삭제" id="file_del">
							<script>
								$(function(){
									$('#file_del').click(function(){
										let choice = confirm('삭제하시겠습니까?');
										if(choice){
											$.ajax({
												url:'deleteFile.do',
												type:'post',
												data:{comm_num:${comm.comm_num}},
												dataType:'json',
												success:function(param){
													if(param.result=='logout'){
														alert('로그인 후 사용하세요');
													}else if(param.result=='success'){
														$('#file_detail1').hide();
													}else if(param.result=='wrongAccess'){
														alert('잘못된 접속입니다');
													}else{
														alert('파일 삭제 오류 발생');
													}
												},
												error:function(){
													alert('네트워크 오류 발생');
												}
											})
										}
									});
								});
							</script>  
						</div>
					</c:if>
				</li>
				<li>
					<label>여행스타일</label>
					<input type="checkbox" name="category" id="category" value="1">커플여행
					<input type="checkbox" name="category" id="category" value="2">가족여행
					<input type="checkbox" name="category" id="category" value="3">아동동반여행
					<input type="checkbox" name="category" id="category" value="4">친구모임
					<input type="checkbox" name="category" id="category" value="5">나홀로여행
					<input type="checkbox" name="category" id="category" value="6">기타
				</li>
				<li>
					<label>태그</label>
					<input type="checkbox" name="tag" value="1">객실뷰가 좋아요
					<input type="checkbox" name="tag" value="2">일정이 알차요
					<input type="checkbox" name="tag" value="3">현지 음식이 맛있어요
					<input type="checkbox" name="tag" value="4">가이드가 배려 깊고 세심해요
					<input type="checkbox" name="tag" value="5">가격이 합리적이에요
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</div>
		</form>
	</div>
</div>	
</body>
</html>