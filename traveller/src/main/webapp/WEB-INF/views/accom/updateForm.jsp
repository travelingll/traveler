<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c"  uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 수정</title>
<link rel ="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//이벤트 연결
	$('#write_form').submit(function(){
		if($('#accom_title').val().trim()==''){
			alert('제목을 입력하세요');
			$('#accom_title').val('').focus();
			return false;
		}
		if($('#accom_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#accom_content').val('').focus();
			return false;
		}
		if($('#accom_filename').val().trim()==''){
			alert('파일을 등록하세요');
			$('#accom_filename').val('').focus();
			return false;
		}
		if($('#accom_quantity').val().trim()==''){
			alert('모집인원을 입력하세요');
			$('#accom_quantity').val('').focus();
			return false;
		}
		if($('#accom_expense').val().trim()==''){
			alert('여행경비를 입력하세요');
			$('#accom_expense').val('').focus();
			return false;
		}
		if($('#accom_start').val().trim()==''){
			alert('출발일을 입력하세요');
			$('#accom_start').val('').focus();
			return false;
		}
		if($('#accom_end').val().trim()==''){
			alert('종료일을 입력하세요');
			$('#accom_end').val('').focus();
			return false;
		}
		if($('input[type=radio]:checked').length < 1){
			alert('진행여부를 선택하세요!');
			return false;
		}
	});
});
</script>
</head>
<body>
<div class = "page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class = "content-main">
		<h2>게시판 글수정</h2>
		<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for = "accom_title">제목</label>
				<input type="text" name="accom_title" id="accom_title" value="${accom.accom_title}"  maxlength="50">
			</li>
			<li>
				<label for = "accom_content">내용</label>
				<textarea rows="5" cols="30" name="accom_content" id="accom_content">${accom.accom_content}</textarea>
			</li>
			<li>
				<label for = "accom_filename">파일</label>
				<input type="file" name="accom_filename" id="accom_filename" accept="image/gif, image/png, image/jpeg">
				<c:if test = "${!empty accom.accom_filename}">
				<div id = "file_detail">
				(${accom.accom_filename})파일이 등록되어 있습니다.
				<input type = "button" value = "파일삭제" id = "file_del">
				<script type = "text/javascript">
				$(function(){
					$('#file_del').click(function(){
						let choice = confirm('삭제하시겠습니까?');
						if(choice){
							$.ajax({
								url:'deleteFile.do',
								data:{accom_num:${accom.accom_num}},
								dataType:'json',
								success:function(param){
									if(param.result == 'logout'){
										alert('로그인 후 사용하세요');
									}else if(param.result == 'success'){
										$('#file_detail').hide();
									}else if(param.result == "wrongAccess"){
										alert('잘못된 접속입니다.');
									}else{
										alert('파일 삭제 오류 발생');
									}
								},
								error:function(){
									alert('네트워크 오류 발생');
								}
							});
						}
					});
				});
				</script>
				</div>
				</c:if>
			</li>
			<li>
					<label for="accom_quantity">모집인원</label>
					<input type="number" id="accom_quantity" name="accom_quantity" value="${accom.accom_quantity}"
					  min="1" size="3">
				</li>
					<li>
					<label for="accom_expense">여행경비</label>
					<input type="number" name="accom_expense" id="accom_expense" class="input-check"
					value="${accom.accom_expense}" min="1" maxlength="999999999">
				</li>
				<li>
					<label for="accom_start">출발일</label>
					<input type="date" id="accom_start" name="accom_start"
					value="${accom.accom_start}" maxlength="100" size="20">
				</li>
				<li>
					<label for="accom_end">종료일</label>
					<input type="date" id="accom_end" name="accom_end"
					value="${accom.accom_end}" maxlength="100" size="20">
				</li>
				<li>
					<label>진행여부</label>
					<input type="radio" name="accom_status" value="0" id="accom_status0">진행중
					<input type="radio" name="accom_status" value="1" id="accom_status1">완료
				</li>
		</ul>
		<div class="align-center">
				<input type="submit" value="수정">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>