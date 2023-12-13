<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자-이벤트 수정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript">
		window.onload = function(){
			let updateForm = document.getElementById('event_updateForm');
			updateForm.onsubmit = function(){
				let input = document.querySelectorAll('.input');
				for(let i=0 ; i<input.length ; i++){
					if(input[i].value.trim()==''){
						let label = document.querySelector('label[for="'+input[i].id+'"]');
						alert(label.textContent+' 항목을 입력해주세요!');
						input[i].value='';
						input[i].focus();
						return false;
					}
				}
			};
		};
	</script>
</head>
<body>
	<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">
			<c:if test="${empty user_num || user_auth!=9}">
				<div>
					잘못된 접근입니다.
				</div>
			</c:if>
			<c:if test="${!empty user_num && user_auth==9}"> <%-- 관리자만 진입 가능 --%>
				<h2>관리자 - 이벤트 수정</h2>
				<form id="event_updateForm" action="eventUpdate.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="event_num" value="${event.event_num}">
					<ul>
						<li>
							<label for="event_title">이벤트 제목</label>
							${event.event_title}
						</li>
						<li>
							<label for="event_start">이벤트 시작일</label>
							<input type="date" name="event_start" id="event_start" value="${event.event_start}" class="input">
						</li>
						<li>
							<label for="event_end">이벤트 종료일</label>
							<input type="date" name="event_end" id="event_end" value="${event.event_end}" class="input">
						</li>
						<li>
							<label for="event_count">이벤트 참여 횟수</label>
							<input type="number" name="event_count" id="event_count" value="${event.event_count}" class="input">
						</li>
						<li>
							<label for="event_photo1">이벤트 썸네일</label>
							<input type="file" name="event_photo1" id="event_photo1" accept="image/gif,image/png,image/jpeg">									
							<c:if test="${!empty event.event_photo1}"><div id="file_detail">(${event.event_photo1} 파일이 등록되어 있습니다.)</div></c:if>
						</li>
						<li>
							<label for="event_content">이벤트 내용</label>
							<textarea name="event_content" id="event_content" rows="10" cols="70" class="input">${event.event_content}</textarea>
						</li>
					</ul>
					<div class="align-center">
						<input type="submit" value="이벤트 수정하기">
						<input type="button" value="목록으로" onclick="location.href='eventList.do'">
					</div>
				</form>
			</c:if>
		</div>
	</div>
</body>
</html>