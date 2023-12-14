<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class = "page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class = "content-main">
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
		<p>
			${accom.accom_content}
		</p>
			<hr size="1" noshade="noshade" width="100%">
			<p>모집 인원: ${accom.accom_quantity}명 여행 경비: ${accom.accom_expense}원 출발일: ${accom.accom_start} 종료일: ${accom.accom_end}</p>
			<hr size="1" noshade="noshade" width="100%" >
			작성일 : ${accom.accom_regdate}
			<hr size="1" noshade="noshade" width="100%" >
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
				  <!-- 동행신청 버튼 -->
				  <!-- 동행신청내역 버튼 -->
			</script>
			</c:if>
	</div>	
</div>
</body>
</html>