<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행구하기 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type = "text/javascript">
window.onload = function(){
	let myForm = documentg.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		let keyword = documentg.getElementById('keyword');
		if(keyword.value.trim()==''){
		alert('검색어를 입력하세요');
		keyword.value='';
		keyword.focus();
		return false;
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="side-menu">
		<ul>
 			<li><a href="${pageContext.request.contextPath}/comm/list.do" style="font-weight:bold; font-size:24px; border-bottom:2px solid #000;">트래블러클럽</a></li>
  			<li><a href="${pageContext.request.contextPath}/accom/list.do">동행구하기</a></li>
 			<li><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
		</ul>
	</div>
	<div class = "content-main">
		<h2>동행구하기 게시판</h2>
		<form id = "search_form" action="list.do" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>
					<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
			</li>
		</ul>
		</form>
		<div class="list-space align-right">
			<input type="button" value="글쓰기"
				onclick="location.href='writeForm.do'"
					<c:if test="${empty user_num}">disabled = "disabled"</c:if>
					>
					<input type="button" value="목록"	 onclick="location.href='list.do'">
					<input type="button" value="홈으로"
			    onclick="location.href='${pageContext.request.contextPath}/main/main.do'">          
		</div>
		<c:if test = "${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>글번호</th>
				<th>글상태</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>모집인원</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<c:forEach var="accom" items="${list}">
			<tr>
				<td>${accom.accom_num}</td>
				<td>
					<c:if test="${accom.accom_status == 0}">진행중</c:if>
				    <c:if test="${accom.accom_status == 1}">완료</c:if>
				</td>
				<td><a href="detail.do?accom_num=${accom.accom_num}">${accom.accom_title}</a></td>
				<td>${accom.id}</td>
				<td>${accom.accom_regdate}</td>
				<td>${accom.accom_quantity}</td>
				<td>${accom.accom_hit}</td>
				<td></td>
				<%-- 추천수 부분 --%>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>