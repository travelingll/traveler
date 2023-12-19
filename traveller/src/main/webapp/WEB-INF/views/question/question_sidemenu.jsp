<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="#">고객센터</a>
					</dt>
					<dd>
						<ul class="list_lnb">
						<li><a href="${pageContext.request.contextPath}/faq/list.do">자주찾는질문</a></li>
							<li><a href="${pageContext.request.contextPath}/comm/list.do">1:1문의하기</a></li>
							<li><a href="${pageContext.request.contextPath}/question/questionList.do">1:1문의</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 