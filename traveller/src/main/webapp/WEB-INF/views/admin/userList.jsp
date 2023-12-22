<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	let myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		let keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
</head>
<body class="chrome">
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
												<a href="${pageContext.request.contextPath}/member/myPage.do">관리자 페이지</a>
											</dt>
											<dd>
												<ul class="list_lnb">
										  			<li><a href="${pageContext.request.contextPath}/admin/adminItemList.do">관리자 상품 게시판</a></li>
										 			<li><a href="${pageContext.request.contextPath}/admin/adminOrderList.do">관리자 예약관리 게시판</a></li>
										 			<li><a href="${pageContext.request.contextPath}/admin/itemInsert.do">관리자 상품등록</a></li>
										 			<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix">
    								<strong class="tit">회원관리</strong></div>
    								<div class="search_field">
										<div class="box_search wide_type">
											<form id="search_form" action="userList.do" method="get">
												<select name="keyfield" class="keyfield" style="height:54px;">
													<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>ID</option>
													<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>이름</option>
													<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>이메일</option>
												</select>
												<input type="search" class="input_keyword" size="20" placeholder="검색어를 입력해 주세요" name="keyword" id="keyword" value="${param.keyword}" >
												<input type="submit" class="btn" value="검색" style="height:54px;"> 
											</form>
										</div>
									</div>
											<div class="panels">
												<div id="tabPkg" class="panel selected">
													<div class="tbl">
													<c:if test="${count == 0}">
														<table class="board_type">
															<colgroup>
																<col style="width: 15%;"> 
																<col style="width: 10%;"> 
																<col style="width: 25%;"> 
																<col style="width: 25%;">
																<col style="width: 15%;">
																<col style="width: 10%;">
															</colgroup> 
														<thead>
															<tr>
																<th>ID</th>
																<th>이름</th>
																<th>이메일</th>
																<th>전화번호</th>
																<th>가입일</th>
																<th>등급</th>
															</tr>
														</thead>
														<tbody>
																<tr>
																	<td></td>
																	<td style="float:right;"> 표시할 게시물이 없습니다.</td>
																</tr>
	                   									</tbody>
	                   									</table>
													</c:if>
													<c:if test="${count > 0}">
														<table class="board_type">
															<colgroup>
																<col style="width: 15%;"> 
																<col style="width: 10%;"> 
																<col style="width: 25%;"> 
																<col style="width: 25%;">
																<col style="width: 15%;">
																<col style="width: 10%;">
															</colgroup> 
														<thead>
															<tr>
																<th>ID</th>
																<th>이름</th>
																<th>이메일</th>
																<th>전화번호</th>
																<th>가입일</th>
																<th>등급</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach var="member" items="${list}">
															<tr>
																<td>
																	<c:if test="${member.auth > 0}">
																	<a href="detailUserForm.do?mem_num=${member.mem_num}">${member.id}</a>
																	</c:if>
																	<c:if test="${member.auth == 0}">
																	${member.id}
																	</c:if>
																</td>
																<td>${member.name}</td>
																<td>${member.email}</td>
																<td>${member.phone}</td>
																<td>${member.reg_date}</td>
																<td>
																	<c:if test="${member.auth == 0}">탈퇴</c:if>
																	<c:if test="${member.auth == 1}">VVIP</c:if>
																	<c:if test="${member.auth == 2}">VIP</c:if>
																	<c:if test="${member.auth == 3}">일반</c:if>
																	<c:if test="${member.auth == 9}">관리</c:if>
																</td>
															</tr>
															</c:forEach>
														</tbody>
													</table>
												</c:if>
												<div style="text-align:center;"><br><br><br>${page}</div>
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