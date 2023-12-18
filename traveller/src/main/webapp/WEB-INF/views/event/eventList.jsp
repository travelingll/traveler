<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이벤트 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
	
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
	<div class="inr">
		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="#">이벤트</a>
					</dt>
					<dd>
						<ul class="list_lnb">
							<li><a href="eventList.do?event_category=1">회원</a></li>
							<li><a href="eventList.do?event_category=2">비회원</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 
<!-- 여기까지 사이드바 입니다. -->
<!-- 여기서부터는 본문 입니다. -->
		<div id="contents" class="contents">
			<div class="ly_wrap main_cuc">
				<div class="inr">
					<div class="text_wrap big fix">
						<strong class="tit"><em>이벤트</em></strong>
					</div> 
					<!-- 여기서부터는 검색 필드입니다. -->
					<div class="search_field">
						<div class="box_search wide_type">
						<c:if test="${category==0}">
						<form id="search_form" action="eventList.do" method="get">
						<select name="keyfield" class="keyfield">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목+내용</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>제목</option>
								<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
						</select>
				
						<input type="search" class="input_keyword" size="20" placeholder="검색어를 입력해 주세요" name="keyword" id="keyword" value="${param.keyword}">
						<input type="submit" class="btn"  value="검색">
						
						</form>
						</c:if>
						</div> 
					</div>
					<!-- 여기까지 검색창입니다. -->
				<div id="contents" class="contents" data-v-bead000e="">
					<div class="text_wrap big"><strong class="tit">최근 게시물</strong>
						<!-- 여기서부터 버튼입니다. -->
						
						<!-- 여기까지 버튼입니다. -->
						
						<div class="panels">
							<div id="tabPkg" class="panel selected">
								<div class="option_wrap">
									<div class="list-space">
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
									</div>		
								</div> 
					
   							
     						</div>
  						</div>
  					</div>
  				</div>
  			</div>
  		</div>
   	</div>
</div>
</div>
</body>
</html>






