<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일대일 문의 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
	<script type="text/javascript">
		window.onload = function(){
			let searchForm = document.getElementById('search_form');
			searchForm.onsubmit = function(){
				let keyword = document.getElementById('keyword');
				if(keyword.value.trim()==''){
					alert('검색어를 입력하세요!');
					keyword.value='';
					keyword.focus();
					return false;
				}
			};
		};
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
	<div id="contents" class="contents">
		<div class="text_wrap big fix">
			<strong class="tit">1:1 문의</strong>
		</div> 
		<form action="questionList.do" id="search_form" method="get"><%-- 검색바 --%>
			<ul class="search" style="float:right;">
				<li>
				<select class="btn" name="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
						</select>
						<input class="btn" type="search" style="height: 25px;" size="16" name="keyword" id="keyword" value="${param.keyword}">
						<input class="btn" type="submit" value="검색">
					</li>
				</ul>
			</form>
			<div class="list-space align-right">
				<input class="btn" type="button" value="문의 작성" onclick="location.href='userQuestionWriteForm.do'">
			</div>
			
			
								<div class="js_tabs type1 v-tabs">
									<ul class="tabs">
										<li class="selected fx-cobrand-pkg" style="width: 33.3333%;">
											<a href="question.do?question_category=1">상품</a>
										</li> 
										<li class="fx-cobrand-htl" style="width: 33.3333%;">
											<a href="${pageContext.request.contextPath}/question/question.do?question_category=2">교환/환불</a>
										</li> 
										<li class="fx-cobrand-fnd" style="width: 32.3333%;">
											<a href="${pageContext.request.contextPath}/question/question.do?question_category=3">기타</a>
										</li>
									</ul> 
					
								<div class="panels">
									<div id="tabPkg" class="panel selected">
										<div class="tbl">
											<c:if test="${empty list}">
											<table class="board_type">
													<colgroup>
													<col> 
													<col style="width: 15%;"> 
													<col style="width: 15%;"> 
													<col style="width: 13%;"></colgroup> 
														<thead>
															<tr>
																<th>제목</th> 
																<th>작성일</th> 
																<th>조회수</th> 
																<th></th>
															</tr>
														</thead>
														<tbody>
															<tr>
																
																<td style="float:right;"> 표시할 게시물이 없습니다.</td>
															</tr>
                   										</tbody>
                   									</table>
											</c:if>
											<c:if test="${!empty list}">
											<table class="board_type">
														<colgroup>
													<col style="width: 13%;"> 
													<col> 
													<col style="width: 15%;"> 
													<col style="width: 15%;"> 
													<col style="width: 13%;"></colgroup> 
														<thead>
															<tr>
																<th>카테고리</th>
																<th>제목</th>
																<th>작성자</th>
																<th>작성일자</th>
																<th>조회수</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="question" items="${list}">
															<c:if test="${question.question_category!=0}">
															<tr>
																<td>
																	<c:if test="${question.question_category==1}">상품</c:if>
																	<c:if test="${question.question_category==2}">교환/환불</c:if>
																	<c:if test="${question.question_category==3}">기타</c:if>
																</td>
																<td class="txl">
																		<c:if test="${question.question_lock==2}">
																			<img src="${pageContext.request.contextPath}/upload/question_lock.png" width="8">
																		</c:if>
																			<a href="questionDetail.do?question_num=${question.question_num}">${question.question_title}</a>
																		<c:if test="${question.question_renum!=0}">
																		<br>
																			<a href="questionDetail.do?question_num=${question.question_num}">
																			&nbsp;&nbsp;&nbsp;[답변 완료]&nbsp;<img src="${pageContext.request.contextPath}/upload/question_answer.png" width="12">
																			</a>
																		</c:if>
																</td> 
																
																<td>
                   													<div class="name">
                   														<c:if test="${empty question.name}">비회원</c:if>
																		<c:if test="${!empty question.name}">${question.name}</c:if>
                   													</div>
                   												</td>
                   												
																<td>
																	<p class="date">
																		${question.question_regdate}
																	</p> 
																</td> 
																<td>
																	<span class="hit">
                   														&nbsp;&nbsp;&nbsp;&nbsp;${question.question_hit}
                   													</span>
                   												</td> 
                   											
                   											</tr>
                   											</c:if>
                   											</c:forEach>
                   										</tbody>
                   									</table>
                   									</c:if>
                   								</div> 
                   								<!----> 
                   						</div>
                   					</div>
                   				</div>
                   			</div>
						</div>
					</div>

</body>
</html>
