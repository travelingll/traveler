<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="lnb" class="lnb">
	<div class="inr">
		<dl>
			<dt class="type">
				<a href="${pageContext.request.contextPath}/event/eventList.do">이벤트</a>
			</dt>
			<dd>
				<ul class="list_lnb">
					<li><a href="${pageContext.request.contextPath}/event/eventList.do?event_category=1">회원</a></li>
					<li><a href="${pageContext.request.contextPath}/event/eventList.do?event_category=2">비회원</a></li>
				</ul>
			</dd>
		</dl>
	</div>
</div>