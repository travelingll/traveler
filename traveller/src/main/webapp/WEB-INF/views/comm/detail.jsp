<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commDetail.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.reply.js"></script>
	

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
											<a href="#">트래블러 클럽</a>
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
<!-- 여기까지 사이드바 입니다. -->
<!-- 여기서부터는 본문 입니다. -->
							<div id="contents" class="contents">
								<div class="ly_wrap main_cuc">
									<div class="inr">
										<div class="text_wrap big fix">
											<strong class="tit"><em>트래블러 커뮤니티</em> 입니다.</strong>
										</div> 
										<div class="rating_list">
											<ul class="list_review_v2">
												<li>
													<div class="rating_info">
														<strong class="point">${comm.comm_hit}</strong> 
														<div>
															<span>
															<c:if test="${!empty comm.photo}">
																<img src="${pageContext.request.contextPath}/upload/${comm.photo}" width="40" height="40" class="noimg">
															</c:if>
															<c:if test="${empty comm.photo}">
																<img src="${pageContext.request.contextPath}/images/face.jpg" width="40" height="40" class="my-photo">
															</c:if>
															</span> 
															<span>${comm.id}</span> 
															<span></span> 
															<span></span> 
															<span>${comm.reg_date}</span>
														</div> 
														
													</div> 
													<div class="product_info">
														<ul>
															<li>
																<strong>제목</strong>
																<span>${comm.comm_title}</span>
															</li> 
					<!----> 
					<!---->
														</ul>
													</div>
													
													<div class="review_cont con">${comm.comm_content}</div> 
												 	
  													<div class="review_cate">
  														<span class="topic_icon topic-12">객실 뷰가 좋아요</span>
  														
  													</div> 
  													<div class="review_img_list">
  														<ul>
  															<li>
  																<a href="#none">
  																<c:if test="${!empty comm.filename1}">
																	<img src="${pageContext.request.contextPath}/upload/${comm.filename1}" class="detail-img">
																</c:if>		
  																</a>
  															</li>
  															<li>
  																<a href="#none">
  																<c:if test="${!empty comm.filename2}">
																	<img src="${pageContext.request.contextPath}/upload/${comm.filename2}" class="detail-img">
																</c:if>	
  																</a>
  															</li>
  															<li>
  																<a href="#none">
  																<c:if test="${!empty comm.filename3}">
																	<img src="${pageContext.request.contextPath}/upload/${comm.filename3}" class="detail-img">
																</c:if>	
  																</a>
  															</li>
  														</ul>
  													</div>
  													<ul class="detail-sub">
														<li>
														<%--좋아요 --%>
														<button class="vote" id="output_fav" data-num="${comm.comm_num}">좋아요<span id="output_fcount"></span></button>
															<script>
															$('.vote').on('click', function(){
																$('.vote').toggleClass('selected');
 															 });
															</script>
														</li>
														<c:if test="${user_num == comm.mem_num}">
														<div class="vote_list_toggle" style="float:right;">
															<input class="btn more" type="button" value="수정" onclick="location.href='updateForm.do?comm_num=${comm.comm_num}'">
															<input class="btn more" type="button" id="delete_btn" value="삭제">
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
														</div>
														</c:if>	
													</ul>
      											</li>
      										</ul> 
   										</div>
		<!-- 댓글 시작 -->				<div class="inr" style="margin-top:50px;">
										<div id="reply_div">
											<span class="re-title">댓글<br></span>
												<form id="re_form" style="margin-top:30px;">
													<span class="re-title">
														<c:if test="${!empty comm.photo}">
															<img src="${pageContext.request.contextPath}/upload/${comm.photo}" class="noimg" style="float:left;">	
														</c:if>
														<c:if test="${empty comm.photo}">
															<img src="${pageContext.request.contextPath}/images/face.jpg" class="my-photo">
														</c:if>
													</span>
													<input type="hidden" name="comm_num" value="${comm.comm_num}" id="comm_num">
													<textarea style="float:left; height: 53px; border:none; margin-left:20px; border-bottom: 2px solid #111;" rows="3" cols="100" name="comm_recontent" id="comm_recontent" class="rep-content"
													<c:if test="${empty user_num}">disabled="disabled"</c:if>><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
													<c:if test="${!empty user_num}">
													<input id="resecond" class="btn" style="float:right; margin-top:30px; float:left;" type="submit" value="전송">
													
													<div id="re_first" style="margin-top:10px; margin-left:80px;">
														<span class="letter-count">300/300</span>
													</div>
											
													</c:if>
												</form>
										</div>
		<!-- 댓글 목록 출력 시작 -->			<div class="inr" style="margin-top:10px;">
										<div id="output"></div>
											<div class="paging-button" style="display:none;">
												<input src="${pageContext.request.contextPath}/images/loding.gif" width="50" height="50">
											</div>
		<!-- 댓글 목록 출력 끝 -->			</div>
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
	</div>

</body>
</html>
