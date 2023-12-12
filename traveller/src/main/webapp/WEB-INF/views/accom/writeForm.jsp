<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행구하기 게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class = "page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class = "content-main">
		<h2>게시판 글쓰기</h2>
		<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for = "accom_title">제목</label>
				<input type="text" name="accom_title" id="accom_title" maxlength="50">
			</li>
			<li>
				<label for = "accom_content">내용</label>
				<textarea rows="5" cols="30" name="accom_content" id="accom_content"></textarea>
			</li>
			<li>
				<label for = "accom_filename">파일</label>
				<input type="file" name="accom_filename" id="accom_filename" accept="image/gif, image/png, image/jpeg">
			</li>
			<li>
					<label for="accom_quantity">모집인원</label>
					<input type="number" id="accom_quantity" name="accom_quantity" min="1" size="3" class="insert_check">
				</li>
					<li>
					<label for="accom_expense">여행경비</label>
					<input type="number" name="accom_expense" id="accom_expense" class="input-check" min="1" maxlength="999999999">
				</li>
				<li>
					<label for="accom_start">출발일</label>
					<input type="date" id="name" name="accom_start" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label for="accom_end">종료일</label>
					<input type="date" id="name" name="accom_end" maxlength="100" size="20" class="insert_check">
				</li>
				<li>
					<label>진행여부</label>
					<input type="radio" name="accom_status" value="1" id="accom_status1">진행중
					<input type="radio" name="accom_status" value="2" id="accom_status">완료
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