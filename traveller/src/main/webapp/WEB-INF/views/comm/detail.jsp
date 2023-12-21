<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.reply.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>${comm.comm_title}</h2>
		<ul class="detail-info">
			<li>
				<c:if test="${!empty comm.photo}">
				<img src="${pageContext.request.contextPath}/upload/${comm.photo}" 
				 width="40" height="40" class="my-photo">
				</c:if>
				<c:if test="${empty comm.photo}">
				<img src="${pageContext.request.contextPath}/images/face.jpg" 
				 width="40" height="40" class="my-photo">
				</c:if>
			</li>
			<li>
				${comm.id}<br>
				조회 : ${comm.comm_hit}
				카테고리 : ${comm.category}
				태그 : ${comm.tag}
			</li>
									    
		</ul>
		<hr size="1" noshade="noshade" width="100%" >
		<c:if test="${!empty comm.filename1}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${comm.filename1}" class="detail-img">
		</div>
		</c:if>
		<c:if test="${!empty comm.filename2}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${comm.filename2}" class="detail-img">
		</div>
		</c:if>
		<c:if test="${!empty comm.filename3}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${comm.filename3}" class="detail-img">
		</div>
		</c:if>
		<p>
			${comm.comm_content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<ul class="detail-sub">
			<li>
				<%--좋아요 --%>
				<img id="output_fav" data-num="${comm.comm_num}" src="${pageContext.request.contextPath}/upload/fav01.png" width="20">
				좋아요
				<span id="output_fcount"></span>
			</li>
			<li>
				<c:if test="${!empty comm.modify_date}">
					최근 수정일 : ${comm.modify_date}
				</c:if>
				작성일 : ${comm.reg_date}
				<%-- 로그인한 회원 번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
			</li>
			<c:if test="${user_num == comm.mem_num}">
			<input type="button" value="수정" onclick="location.href='updateForm.do?comm_num=${comm.comm_num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script>
				let delete_btn = document.getElementById('delete_btn');
				//이벤트 연결
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까');
					if(choice){
						location.replace('delete.do?comm_num=${comm.comm_num}');
					}
				};
			</script>
			
			
			
			</c:if>
		</ul>
		<!-- 댓글 시작 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
				<input type="hidden" name="comm_num" value="${comm.comm_num}" id="comm_num">
				<textarea rows="3" cols="50" name="comm_recontent" id="comm_recontent" class="rep-content"
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
</body>
</html>