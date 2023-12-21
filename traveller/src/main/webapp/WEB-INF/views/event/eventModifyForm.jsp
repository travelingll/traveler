<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자-이벤트 수정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
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
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container"><div class="inr"><jsp:include page="event_sidemenu.jsp"/></div></div>
	<div id="containerr" style="display: flex;">
	    <div id="sidebar" style="width: 80%;">
			<c:if test="${empty user_num || user_auth!=9}">
				<h1 class="detail-center">잘못된 접근입니다.</h1>
			</c:if>
			<c:if test="${!empty user_num && user_auth==9}"> <%-- 관리자만 진입 가능 --%>
				<h1 class="detail-center">관리자 - 이벤트 수정</h1>
				<h4 class="detail-center form-title">${event.event_title}</h4>
				<form class="detail-form" id="event_updateForm" action="eventUpdate.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="event_num" value="${event.event_num}">
					<ul class="input-form">
						<li>
							<label for="event_start">이벤트 일자</label>
							<input type="date" name="event_start" id="event_start" value="${event.event_start}" class="input"> - <input type="date" name="event_end" id="event_end" value="${event.event_end}" class="input">
						</li>
						<li>
							<label for="event_count">이벤트 참여 횟수</label>
							<input type="number" name="event_count" id="event_count" value="${event.event_count}" class="input">
						</li>
						<li>
							<label for="event_photo1">이벤트 썸네일</label>
							<input type="file" name="event_photo1" id="event_photo1" accept="image/gif,image/png,image/jpeg">									
							<c:if test="${!empty event.event_photo1}"><div class="file-right" id="file_detail">(${event.event_photo1} 파일이 등록되어 있습니다.)</div></c:if>
						</li>
						<li>
							<label for="event_content">이벤트 내용</label>
							<textarea name="event_content" id="event_content" rows="10" cols="70" class="input">${event.event_content}</textarea>
						</li>
					</ul>
					<div class="file-right">
						<input type="submit" value="이벤트 수정하기">
					</div>
				</form>
			</c:if>
		</div>
	</div>
</body>
</html>