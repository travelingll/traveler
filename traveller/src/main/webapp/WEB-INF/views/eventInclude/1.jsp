<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 이벤트 시작 --%>
<c:if test="${!empty user_num}">
	<div id="event_div">
		<input id="event_btn" type="button" value="랜덤 적립금 받기" data-eventnum="${event.event_num}">
	</div>
</c:if>
<c:if test="${empty user_num}">
	<div id="event_div">
		<input id="event_btn" type="button" value="회원 참여 가능" disabled>
	</div>
</c:if>
<%-- 이벤트 끝 --%>