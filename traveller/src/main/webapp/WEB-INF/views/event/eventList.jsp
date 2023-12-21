<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이벤트 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eventList.css">
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
<body class="chrome">
	<div id="__nuxt"><div id="__layout"><div id="wrapper"><div id="screenArea">  
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container"><div class="inr"><div id="lnb" class="lnb"><div class="inr">
		<dl><dt class="tit_con_title" style="border-bottom:none;">		
			<a href="eventList.do">이벤트</a>
		</dt></dl>
	</div></div>
		<div class="content_block" id="content">
			<ul class="tab_page_cont" id="tab_page_cont">
				<li><a href="${pageContext.request.contextPath}/event/eventList.do">진행중</a></li>
				<li><a href="${pageContext.request.contextPath}/event/eventList.do?event_category=1">회원</a></li>
				<li><a href="${pageContext.request.contextPath}/event/eventList.do?event_category=2">비회원</a></li>
			</ul>
			<form name="search_form" id="search_form" action="eventList.do" method="post">
				<div class="brd_search">
					<select name="keyfield" class="keyfield">
						<option value="2" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="3" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
					</select>								
					<input type="text" name="keyword" id="keyword" value="${param.keyword}" class="txt_brd_search" placeholder="검색어 입력">
					<input type="submit" class="btn_nor" value="검색" id="search_btn">
				</div>
			</form>
			<p class="tbl_count"></p>
			<div class="promotion_block">
				<c:if test="${count==0}">
					<div class="result-display" style="float:center center;">표시할 이벤트가 없습니다</div>
				</c:if>
				<c:if test="${count>0}">
					<ul class="promotion_list">
						<c:forEach var="event" items="${list}"><c:if test="${event.event_category==category || category==null}">
							<li>
								<a href='eventDetail.do?event_num=${event.event_num}'>
									<img style=" display: block; width: 283px; height: 195px;" src="${pageContext.request.contextPath}/upload/${event.event_photo1}">
									<div class="list_block_info">
										<h5 class="tit_list_block" >${event.event_title}</h5>
										<span class="list_date">${event.event_start} ~ ${event.event_end}</span>
									</div>
								</a>
							</li>
						</c:if></c:forEach>	
					</ul>
				</c:if>
			</div>
			<div class="align-center">${page}</div>
			</div>
		</div></div>
	</div></div></div></div>
</body>
</html>