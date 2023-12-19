<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="lnb" class="lnb">
	<div class="inr">
		<dl>
			<dt class="type">
				<a href="#">트래블러 클럽</a>
			</dt>
			<dd>
				<ul class="list_lnb">
					<li><a href="${pageContext.request.contextPath}/accom/list.do">동행구하기</a></li>
					<li><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
				</ul>
			</dd>
		</dl>
	</div>
</div>