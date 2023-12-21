<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/accordion.css">

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

<script>
function collapse(element) {
    var before = document.getElementsByClassName("active")[0]               // 기존에 활성화된 버튼
    if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
        before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
        before.classList.remove("active");                  // 버튼 비활성화
    }
    element.classList.toggle("active");         // 활성화 여부 toggle

    var content = element.nextElementSibling;
    if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
        content.style.maxHeight = null;         // 접기
    } else {
        content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
    }
}
</script>







</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- 여기서 부터 사이드바 입니다.-->
<div id="container">
	<div class="inr">
		<div id="lnb" class="lnb">
			<div class="inr">
				<dl>
					<dt class="type">
						<a href="${pageContext.request.contextPath}/faq/list.do">고객센터</a>
					</dt>
					<dd>
						<ul class="list_lnb">
							<li><a href="${pageContext.request.contextPath}/faq/list.do">자주찾는질문</a></li>
							<li><a href="${pageContext.request.contextPath}/question/userQuestionWriteForm.do">1:1문의하기</a></li>
							<li><a href="${pageContext.request.contextPath}/question/questionList.do">1:1문의</a></li>
						</ul>
					</dd>
				</dl>
			</div>
		</div> 
			<div id="contents" class="contents">
			<div class="ly_wrap main_cuc">
				<div class="inr">
					<div class="text_wrap big fix">
						<strong class="tit"><em>트래블러 고객센터</em> 입니다.무엇을 도와드릴까요?</strong>
					</div> 
					<!-- 여기서부터는 검색 필드입니다. -->
					<div class="search_field">
						<div class="box_search wide_type">
						<form id="search_form" action="list.do" method="get">
						<select name="keyfield" class="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>	
							<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
						</select>
				
						<input type="search" class="input_keyword" style="height: 60px;" size="20" placeholder="검색어를 입력해 주세요" name="keyword" id="keyword" value="${param.keyword}">
						<input type="submit" class="btn"  value="검색">
						
						</form>
						</div> 
					</div>
					<div id="contents" class="contents" data-v-bead000e="">
						<div class="text_wrap big"><strong class="tit">최근 게시물</strong>
						<!-- 여기서부터 버튼입니다. -->
						
						<!-- 여기까지 버튼입니다. -->
						
						<div class="panels">
							<div id="tabPkg" class="panel selected">
								<div class="option_wrap">
									<div class="list-space">
									<c:if test="${!empty user_num && user_auth == 9}">
										<input class="btn" type="button" value="글쓰기" onclick="location.href='writeForm.do'"
			   								 <c:if test="${empty user_num}">disabled="disabled"</c:if>> 
										<input class="btn" type="button" value="목록" onclick="location.href='list.do'"> 
										<input class="btn" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">                      
									</c:if>
									</div>		
								</div> 
								<div class="tbl" style="width: 75%;">
   									<c:if test="${count == 0}">
										<div class="result-display">표시할 게시물이 없습니다.</div>
									</c:if>			
   									<c:if test="${count > 0}">		
   										<c:forEach var="faq" items="${list}">				
   											<c:if test="${faq.faq_category == 1}">
   												<li class="inr">
    												<button type="button" class="collapsible" onclick="collapse(this);">
    													<em>[상품예약.결제]</em>
    													<span>Q. ${faq.faq_title}</span>
    												</button>
    												<div class="content">
    							   						 <a>${faq.faq_content}</a>
   								 					</div>
   						</li>
   						</c:if>
   						<c:if test="${faq.faq_category == 2}">
    					<li class="inr">	
    						<button type="button" class="collapsible" onclick="collapse(this);">
    							<em>[해외패키지]</em>
    							<span>Q. ${faq.faq_title}</span>
    						</button>
    							<div class="content">
    							    <p>${faq.faq_content}</p>
   								 </div>
   						</li>
   						</c:if>
   						<c:if test="${faq.faq_category == 3}">
   						<li class="inr">
    						<button type="button" class="collapsible" onclick="collapse(this);">	
    							<em>[개인정보변경]</em>
    							<span>Q. ${faq.faq_title}</span>
    						</button>
    							<div class="content">
    							    <p>${faq.faq_content}</p>
   								 </div>
   						</li>
   						</c:if>
   						</c:forEach>
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
</body>
</html>

<!-- header.jsp를 제일 위에 올려주세요 -->

<!-- 여기서 부터 사이드바 입니다.-->
<!-- 여기까지 사이드바 입니다. -->
<!-- 여기서부터는 본문 입니다. -->
					<!-- 여기까지 검색창입니다. -->
		