<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/enuseo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/accomDetail.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/accom.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/accom.reply.js"></script>

</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	    <div id="__nuxt">
    	<div id="__layout">
    		<div id="wrapper">
    			<div id="screenArea">
    				<div id="wrap">
    					<div id="container">
    						<div class="inr">
    						<!-- 여기서 부터 사이드바 입니다.-->
    							<div id="lnb" class="lnb">
    								<div class="inr">
    									<dl>
											<dt class="type">		
												<a href="${pageContext.request.contextPath}/member/myPage.do">트래블러 클럽</a>
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
    							<!-- 여기까지 사이드바 입니다.-->
	<div class="content-main">
		<h2>${accom.accom_title}</h2>
		<ul class="detail-info">
			<li>
				<c:if test="${!empty accom.photo}">
				<img src="${pageContext.request.contextPath}/upload/${accom.photo}" 
				 width="40" height="40" class="my-photo">
				</c:if>
				<c:if test="${empty accom.photo}">
				<img src="${pageContext.request.contextPath}/images/face.jpg" 
				 width="40" height="40" class="my-photo">
				</c:if>
			</li>
			<li>
				${accom.id}<br>
				조회 : ${accom.accom_hit}
			</li>
		</ul>
		<hr size="1" noshade="noshade" width="100%" >
		<c:if test="${!empty accom.accom_filename}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${accom.accom_filename}" class="detail-img">
		</div>	
		</c:if>
		<br>
		<p>
			${accom.accom_content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<p>모집 인원: ${accom.accom_quantity}명 여행 경비: <fmt:formatNumber value="${accom.accom_expense}"/>원 출발일: ${accom.accom_start} 종료일: ${accom.accom_end}</p>
				<c:if test="${user_num == accom.mem_num}">
			<input type="button" value="수정" onclick="location.href='updateForm.do?accom_num=${accom.accom_num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script>
				let delete_btn = document.getElementById('delete_btn');
				//이벤트 연결
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까');
					if(choice){
						location.replace('delete.do?accom_num=${accom.accom_num}');
					}
				};
			</script>
			<input type="button" value="동행신청내역" onclick="location.href='requestAccomList.do?accom_num=${accom.accom_num}'">
			</c:if>
		<c:if test="${!empty user_num && accom.present_cnt < accom.accom_quantity && user_num != accom.mem_num && accom.accom_status!=1}">
		<input type="button" value="동행신청" id="apply_btn">
		</c:if>
		<script>
				let delete_btn = document.getElementById('apply_btn');
				//이벤트 연결
				delete_btn.onclick=function(){
					let choice = confirm('동행 신청하시겠습니까');
					if(choice){
						location.replace('applyForAccom.do?accom_num=${accom.accom_num}');
					}
				};
			</script>
		<hr size="1" noshade="noshade" width="100%" >
		<ul class="detail-sub">
			<li>
				<%--좋아요 --%>
				<img id="output_fav" data-num="${accom.accom_num}" src="${pageContext.request.contextPath}/upload/fav01.png" width="50">
				좋아요
				<span id="output_fcount"></span>
			</li>
			
			<li>
				<c:if test="${!empty accom.accom_modifydate}">
					최근 수정일 : ${accom.accom_modifydate}
				</c:if>
				작성일 : ${accom.accom_regdate}
				<%-- 로그인한 회원 번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
			</li>	
		</ul>
		<!-- 댓글 시작 -->
  	<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<br>
			<form id="re_form">
				<input type="hidden" name="accom_num" value="${accom.accom_num}" id="accom_num">
				<textarea rows="3" cols="50" name="accom_recontent" id="accom_recontent" class="rep-content"
				<c:if test="${empty user_num}">disabled="disabled"</c:if>><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user_num}">
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>
				<div id="resecond" class="align-right">
					<input type="submit" value="전송">
				</div>
				</c:if>
			</form>
		</div>
		<!-- 댓글 목록 출력 시작 -->
		<div id="output"></div>
		<div class="paging-button" style="display:none;">
			<input src="${pageContext.request.contextPath}/images/loding.gif" width="50" height="50">
		</div> 
		<!-- 댓글 목록 출력 끝 -->
		<!-- 댓글 끝 -->
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