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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/eventExecute.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container"><div class="inr"><jsp:include page="event_sidemenu.jsp"/></div></div>
	<div id="containerr" style="display: flex;">
	    <div id="sidebar" style="width: 80%;">
		    <div class="event-detailcontent">
		        <h2 class="detail-center">${event.event_title}</h2>
				<ul class="event-detailright">
					<li>
						<img src="${pageContext.request.contextPath}/images/eventdetail_clock.png" width="10"> ${event.event_start} - ${event.event_end}
						<img src="${pageContext.request.contextPath}/images/eventdetail_check.png" width="15">${event.event_hit}
					</li>
					<c:if test="${user_auth==9}"> <%-- 관리자만 보임 --%>
						<li>
							<input class="admin-btn" type="button" value="이벤트 수정" onclick="location.href='eventUpdateForm.do?event_num=${event.event_num}'">
						</li>
					</c:if>
				</ul>
				<div class="detail-center detail-detailcontent">
					<img src="${pageContext.request.contextPath}/upload/${event.event_photo1}" width="500">
					<p>${event.event_content}</p>
					<c:if test="${event.event_category==1 && check==0 && !empty user_num}">
						<div id="event_div">
							<input id="event_btn" type="button" value="${event.event_title}" data-eventnum="${event.event_num}">
						</div>
					</c:if>
					<c:if test="${event.event_category==1 && check==1 && !empty user_num}">
						<div id="event_div">
							<span class="event-output">이미 참여한 이벤트입니다 : (</span>
						</div>
					</c:if>
					<c:if test="${event.event_category==1 && empty user_num}">
						<div id="event_div">
							<input id="event_btn" type="button" value="회원 참여 가능" disabled>
						</div>
					</c:if>
					<c:if test="${event.event_category==2 && !empty user_num}">
						<div id="event_div">
							<span class="event-output">비회원만 참여 가능합니다 : (</span>
						</div>
					</c:if>
					<c:if test="${event.event_category==2 && empty user_num}">
						<div id="event_div">
							<input id="event_btn2" type="button" value="${event.event_title}" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
						</div>
					</c:if>
				</div>
				<hr size="1" noshade="noshade" width="100%">
				<div id="reply_div" class="detail-reply">
					<form id="re_form">
						<input type="hidden" name="event_num" id="event_num" value="${event.event_num}">
						<textarea placeholder="댓글을 입력해주세요!" name="event_recontent" id="event_recontent" class="rep-content" <c:if test="${empty user_num}">disabled</c:if>><c:if test="${empty user_num}">로그인 시 작성 가능</c:if></textarea>
						<div id="re_first"></div>
						<div id="re_second" class="reply-right">
							<input type="submit" value="댓글 등록">
						</div>
					</form>
					<div id="output" class="detail-output"></div>
					<input type="button" value="다음 댓글 보기" id="paging_btn" style="display:none;">
				</div>
			</div>
		</div>
	</div>
</body>