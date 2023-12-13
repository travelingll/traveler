<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 이벤트 시작 --%>
<div>
	<input type="button" value="회원가입하러 가기" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
</div>
<%-- 이벤트 끝 --%>