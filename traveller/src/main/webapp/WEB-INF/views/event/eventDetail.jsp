<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이벤트 상세</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detailStyle.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/eventReply.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#event_btn').click(function() {
				let event_num = $('#event_btn').attr('data-eventnum');		
				$.ajax({
					url:'eventExecute.do',
					type:'post',
					data: {event_num:event_num},
					dataType:'json',
					success:function(param){
						if(param.result=='success'){
							alert(param.money+'원이 지급되었습니다!');
						} else if(param.result=='end'){
							alert('이벤트가 종료되었습니다!');
						} else if(param.result=='done'){
							alert('이미 참여한 이벤트입니다!');
						} else{
							alert('이벤트 오류');
						}
					},
					error:function(){
						alert('네트워크 통신 오류');
					}
				});//end of ajax
			});//end of click
		});//end of function
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="detail-sidemenu"><jsp:include page="event_sidemenu.jsp"/></div>
	<div class="detail-page">
		<div class="detail-content">
			<div class="align-center">
				<h2>${event.event_title}</h2>
				<ul class="align-right">
					<li>기간 : ${event.event_start} - ${event.event_end}</li>
					<li>조회수 : ${event.event_hit}</li>
					<c:if test="${user_auth==9}"> <%-- 관리자만 보임 --%>
						<li>
							<input type="button" value="이벤트 수정" onclick="location.href='eventUpdateForm.do?event_num=${event.event_num}'">
						</li>
					</c:if>
				</ul>
				<div class="align-center">
					<img src="${pageContext.request.contextPath}/upload/${event.event_photo1}" width="500">
					<p>${event.event_content}</p>
				</div>
				<jsp:include page="/WEB-INF/views/eventInclude/${event.event_num}.jsp"/><%-- 개별 이벤트 include --%>
				<hr size="1" noshade="noshade" width="100%">
			</div>
			<div id="reply_div">
				<form id="re_form">
					<input type="hidden" name="event_num" id="event_num" value="${event.event_num}">
					<textarea rows="3" cols="50" name="event_recontent" id="event_recontent" class="rep-content" <c:if test="${empty user_num}">disabled</c:if>><c:if test="${empty user_num}">로그인 시 작성 가능</c:if></textarea>
					<div id="re_first"></div>
					<div id="re_second" class="align-right">
						<input type="submit" value="댓글 등록">
					</div>
				</form>
			</div>
			<div id="output"></div>
			<input type="button" value="다음 댓글 보기" id="paging_btn" style="display:none;">
		</div>
	</div>
</body>
</html>