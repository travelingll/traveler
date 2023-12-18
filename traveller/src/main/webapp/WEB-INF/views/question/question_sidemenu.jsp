<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="side-menu">
	<ul>
		<li>
			<a href="questionList.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">일대일 문의</a>
		</li>
		<li>
			<a href="question.do?question_category=1">상품</a>
		</li>
		<li>
			<a href="question.do?question_category=2">교환/환불</a>
		</li>
		<li>
			<a href="question.do?question_category=3">기타</a>
		</li>
	</ul>
</div>