<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
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
    							
							<div id="contents" class="contents">
								<div class="text_wrap big fix">
									<strong class="tit">적립금</strong></div>
										<c:if test="${count == 0}">
										<div class="result-display">
											적립금이 없습니다.
										</div>
										</c:if>
										<c:if test="${count > 0}">
										<div class="mypage-div1 align-center color">
											${member.name}님의 사용가능한 적립금은<br>
											총 <b><fmt:formatNumber value="${money_total}"/>원</b> 입니다.
										</div>
										<div class="mypage-div2 align-center">
											<table>
												<tr>
													<th>적립금액</th>
													<th>내역</th>
													<th>적립일</th>
												</tr>
												<c:forEach var="money" items="${moneyList}">
												<tr>
													<td><fmt:formatNumber value="${money.saved_money}"/>원</td>
													<td>${money.sm_content}</td>
													<td>${money.sm_date}</td>
												</tr>
												</c:forEach>
											</table>
										</div>
										</c:if>
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

