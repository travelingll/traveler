<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mileage.css">


<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
    						<strong class="tit">내역조회</strong>
    					</div> 
    					<c:if test="${count == 0}">
			
						<div class="mileage_wrap">
    						<div class="user_box">
    							<span class="icn mileage70"></span> 
    							<p class="mileage">
    							<span>${member.name}</span>
    								님의 사용 가능한 마일리지는 <br>
    								<em>0
    							<span class="icn mileage mid em"></span>
    								</em> 원 입니다.
    							</p> 
							</div>
    						<div class="box right">
    							<p>
    								<span>여행상품 <em></em></span>
    								<a href="${pageContext.request.contextPath}/item/itemMain.do" target="_blank" class="btn sml">보기</a>
    							</p> 
    							<p>
    								<span>고객센터</span>
    								<a href="#" class="btn sml">문의하기</a>
    							</p>
    						</div>
    					</div>
						</c:if>
									
						<c:if test="${count > 0}">
    					<div class="mileage_wrap">
    						<div class="user_box">
    							<span class="icn mileage70"></span> 
    							<p class="mileage">
    							<span>${member.name}</span>
    										님의 사용 가능한 마일리지는 <br>
    							<em><fmt:formatNumber value="${money_total}"/>
    								<span class="icn mileage mid em"></span>
    							</em> 원 입니다.
    							</p> 				
    						</div>		
    					<div class="box right">
    						<p>
    							<span>여행상품<em></em></span>
    							<a href="#" target="_blank" class="btn sml" style="float:right;">보기</a>
    						</p> 
    						<p>
    							<span>고객센터</span>
    							<a href="#" class="btn sml" style="float:right;">문의하기</a>
    						</p>
    					</div>
    				</div>
    				</c:if>     
    			</div>
    		</div>
    	</div>
		<div class="tbl" style="width:70%">
    		<c:if test="${count == 0}">
				<table class="board_type">
					<colgroup>
					<col style="width: 5%;"> 
					<col style="width: 10%;"> 
					<col style="width: 10%;"> 
					<col > 
					<col style="width: 20%;"> 
					<col style="width: 10%;">
					<col style="width: 15%;">
					</colgroup>								 								
				<thead>
															<tr>
																<th></th> 
																<th>적립금액</th>
																<th></th> 
																<th>내역</th>
																<th></th> 
																<th></th> 
																<th>적립일</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td></td>
																<td></td>
																<td></td>
																<td style="float:right;">적릭된 금액이 없습니다.</td>
																<td></td>
																<td></td>
															</tr>
                   										</tbody>
                   									</table>
												
											</c:if>
											<c:if test="${count > 0}">
											<table class="board_type">
												<colgroup>
													<col style="width: 15%;"> 
													<col > 
													<col style="width: 15%;"> 
													<col > 
													<col style="width: 15%;">
													<col>
												</colgroup> 
														<thead>
															<tr>
																<th></th> 
																<th>적립금액</th>
																<th></th> 
																<th>내역</th>
																<th></th> 
																<th>적립일</th>
															</tr>
														</thead>
														<tbody>
															 <c:forEach var="money" items="${moneyList}">
															<tr>
																<td>
																
																</td>
																<td class="txl">
																	<a>
																		<strong class="title">
																			<fmt:formatNumber value="${money.saved_money}"/>원
																		</strong>
																	</a> 
																</td> 
																<td>
																
																</td> 
																<td>
																	<a>
																		<span class="content">
                   														${money.sm_content}
                   														</span>
                   													</a>
                   												</td>
                   												<td>
                   												
																</td> 
                   												<td>
                   													<a>
                   													<span class="content">
                   														${money.sm_date}
                   													</span>
                   													</a>
                   												</td>
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
</body>
</html>

