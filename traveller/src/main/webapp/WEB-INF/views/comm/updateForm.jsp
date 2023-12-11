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
<script>
$(function(){
	$('#update_form').submit(function(){
		if($('#comm_title').val().trim()==''){
			alert('제목을 입력하세요');
			$('#comm_title').val('').focus();
			return false;
		}
		if($('#comm_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#comm_content').val('').focus();
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
					<input type="text" name="comm_title" id="comm_title" value="${comm.comm_title}" maxlength="50">
				</li>
				<li>
					<label for="comm_content">내용</label>
					<textarea rows="5" cols="30" name="comm_content"  id="comm_content">${comm.comm_content}</textarea>
				</li>
				<li>
					<label for="filename">파일</label>
					<input type="file" name="filename" id="filename"  accept="image/gif, image/png, image/jpeg">
					<c:if test="${!empty comm.filename}">
						<div id="file_detail">
							(${comm.filename})파일이 등록되어 있습니다.
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
														$('#file_detail').hide();
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