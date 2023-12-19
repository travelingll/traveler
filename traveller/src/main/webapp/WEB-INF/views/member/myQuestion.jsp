<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
												<a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
											</dt>
											<dd>
												<ul class="list_lnb">
													<li><a href="${pageContext.request.contextPath}/member/myPage.do">개인정보</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myWriteComm.do">내가 쓴 글</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myQuestion.do">1:1 문의</a></li>
	 												<li><a href="${pageContext.request.contextPath}/member/myMoney.do">적립금</a></li>
	 												<li><a>동행 신청내역</a></li>
													<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix">
    								<strong class="tit">1:1 문의</strong></div> 
										<div class="panels">
											<div id="tabPkg" class="panel selected">
												<div class="tbl">
												<c:if test="${count == 0}">
													<table class="board_type">
														<colgroup>
															<col style="width: 5%;"> 
															<col > 
															<col style="width: 15%;"> 
															<col style="width: 15%;">
															<col style="width: 13%;">
														</colgroup> 
													<thead>
														<tr>
															<th></th> 
															<th>제목</th> 
															<th></th>
															<th>작성일</th>
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
												<c:if test="${count > 0}">
													<table class="board_type">
														<colgroup>
															<col style="width: 5%;"> 
															<col > 
															<col style="width: 15%;"> 
															<col style="width: 15%;">
															<col style="width: 13%;">
														</colgroup> 
													<thead>
														<tr>
															<th></th> 
															<th>제목</th> 
															<th></th>
															<th>작성일</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
													<c:forEach var="question" items="${questionList}">
														<tr>
															<td></td>
															<td>
																<a href="${pageContext.request.contextPath}/question/questionDetail.do?question_num=${question.question_num}">${question.question_title}
																</a>
															</td>
															<td></td>
															<td>${question.question_regdate}</td>
															<td></td>
														</tr>
													</c:forEach>
													</tbody>
												</table>
											</c:if>
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