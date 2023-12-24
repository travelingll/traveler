<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check}">
<script>
		alert('회원탈퇴가 완료되었습니다.');
		location.href='${pageContext.request.contextPath}/main/main.do';
	</script>
</c:if>
<c:if test="${!check}">
	<script>
		alert('입력한 정보가 정확하지 않습니다!');
		history.go(-1);
	</script>
</c:if>