<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 동행 신청내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sungho_search.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	let myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		let keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요!');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
</head>
<body class="chrome">
	<div id="__nuxt">
		<div id="__layout">
			<div id="wrapper">
				<div id="screenArea">  
				<jsp:include page="/WEB-INF/views/common/header.jsp"/>
				<!-- 여기서 부터 사이드바 입니다.-->
				   <div id="container">
				   		<div class="inr">			
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
					 							<li><a href="${pageContext.request.contextPath}/accom/applyAccomList.do">동행 신청내역</a></li>
					 							<li><a href="${pageContext.request.contextPath}/accom/requestAccomList.do">받은 동행 신청내역</a></li>
					 							<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
					 							<li><a href="${pageContext.request.contextPath}/order/myOrderList.do">예약내역</a></li>
											</ul>
										</dd>
									</dl>
				    			</div>
				    		</div> 
				    	
				    				<!--  -->
				    		<div id="contents" class="contents" style="min-height:70%;">
				    			<div class="text_wrap big fix">
				    						<strong class="tit">나의 동행 신청내역</strong>
				    			</div>
				    		<form id = "search_form" action="applyAccomList.do" method="get">
							<ul class="search">
							<li>
							<select name="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>
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
				    			<div class="panels">
									<div id="tabPkg" class="panel selected">
										<div class="tbl">
									    	<c:if test="${empty list}">
													<table class="board_type">
														<colgroup>
														<!-- 1번 --><col style="width: 15%;">
														<!-- 2번 --><col style="width: 60%;"> 
														<!-- 3번 --><col style="width: 25%;"> 
														</colgroup> 
														<thead>
															<tr>
																<th style="text-align:center;">글번호</th> 
																<th style="text-align:center;">제목</th> 
																<th style="text-align:center;">작성자</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td></td>
																<td style="text-align:center;">동행 신청한 내역이 없습니다.</td>
																<td></td>
															</tr>
									                	</tbody>
									              	</table>
												</c:if>
												<c:if test="${!empty list}">
													<table class="board_type">
														<colgroup>
														<!-- 1번 --><col style="width: 15%;">
														<!-- 2번 --><col style="width: 60%;"> 
														<!-- 3번 --><col style="width: 25%;">
														</colgroup> 
														<thead>
															<tr>
																<th style="text-align:center;">글번호</th> 
																<th style="text-align:center;">제목</th> 
																<th style="text-align:center;">작성자</th>
															</tr>
														</thead>
														<tbody>
														<c:forEach var="accom_info" items="${list}">
															<tr>
															<!-- 1번 -->
																<td style="text-align:center;">
																	${accom_info.accom_num}
																</td>
															<!-- 2,3,4번 -->
																<td class="txl" style="text-align:center;">
																	<a href="detail.do?accom_num=${accom_info.accom_num}"><strong class="title">${accom_info.accomVO.accom_title}</strong></a>
																</td> 
									                   		<!-- 5,6번 -->	
									                   			<td style="text-align:center;">
									                   				${accom_info.accomVO.id}
									                   			</td> 
									                   		</tr>
									                   	</c:forEach>
									                   	</tbody>
									                </table>
									            </c:if>
									            <br>
									            <div style="text-align:center;">${page}</div>
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

