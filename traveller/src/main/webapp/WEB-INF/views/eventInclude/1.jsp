<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 이벤트 시작 --%>
<c:if test="${!empty user_num}">
	<div>
		<input id="event_btn" type="button" value="랜덤 적립금 받기!" onclick="location.href='eventExecute.do'">
	</div>
</c:if>
<c:if test="${empty user_num}">
	<div>
		<input id="event_btn" type="button" value="회원만 참여 가능" disabled onclick="location.href='eventExecute.do'">
	</div>
</c:if>
<%-- 이벤트 끝 --%>