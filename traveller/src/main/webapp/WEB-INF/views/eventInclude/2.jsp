<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 이벤트 시작 --%>
<c:if test="${empty user_num}">
	<div id="event_div">
		<input id="event_btn" type="button" value="회원가입하러 가기" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
	</div>
</c:if>
<c:if test="${!empty user_num}">
	<div id="event_div">
		<input id="event_btn" type="button" value="비회원 참여 가능" disabled="disabled" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
	</div>
</c:if>
<%-- 이벤트 끝 --%>