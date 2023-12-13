<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이벤트 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<script type="text/javascript"> 
		window.onload = function(){
			let searchForm = document.getElementById('search_form');
			searchForm.onsubmit=function(){
				let keyword = document.getElementById('keyword');
				if(keyword.value.trim()==""){
					alert('검색어를 입력하세요');
					keyword.value='';
					keyword.focus();
					return false;
				}
			};//end of onsubmit
		};//end of onload
	</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="event_sidemenu.jsp"/>
		<div class="content-main">
			<%-- 검색바 시작 --%>
			<c:if test="${category==0}">
				<form action="eventList.do" id="search_form" method="get">
					<ul class="search">
						<li>
							<select name="keyfield">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목+내용</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>제목</option>
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
			</c:if>
			<%-- 검색바 끝 --%>
			<%-- 목록 출력 시작 --%>
			<c:if test="${count==0}">
				<div class="result-display">표시할 이벤트가 없습니다</div>
			</c:if>
			<c:if test="${count>0}">
				<div class="image-space">
					<c:forEach var="event" items="${list}">
						<div class="horizontal-area">
							<a href='eventDetail.do?event_num=${event.event_num}'>
								<img src="${pageContext.request.contextPath}/upload/${event.event_photo1}"><br>
								${event.event_title}<br>
								${event.event_start} - ${event.event_end}
							</a>
						</div>
					</c:forEach>
					<div class="float-clear">
						<hr width="100%" size="1" noshade="noshade">
					</div>
				</div>
			</c:if>
			<div class="align-center">${page}</div>
			<%-- 목록 출력 끝 --%>
		</div>
	</div>
</body>
</html>