<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/find.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="__nuxt">
    	<!---->
    		<div id="__layout">
    			<div id="wrapper">
    				<div id="wrap">
    					<div id="headerWrap" class="header_wrap">
    						<div id="header">
    							<a href="${pageContext.request.contextPath}/member/loginForm.do" class="js_act btn_prev">
    							
    								<span>이전페이지</span>
    							</a> 
    							<h1 class="title">비밀번호 찾기 결과</h1> 
    						<!---->
    					</div>
    				</div> 
    				
    				<div id="container">
    					<div class="contents_wrap login_wrap">
    						<div class="logo_wrap">
    							<span class="logo">트래블러</span>
    						</div>
    						<dl class="inner_cont text_wrap mt28"><dt class="tit">회원님!<br>비밀번호를 찾았어요.</dt> <dd class="txt">회원님의 정보로 비밀번호를 찾았어요.</dd></dl>
	  						<div class="inner_cont grey_box big">
	  							<ul class="list_line">
			  						<li>
			  							${member.name}님의 비밀번호는 <b>${member.passwd}</b> 입니다.
			      					</li>
			      				</ul>
			      			</div>
  							<div class="bottom_wrap">
  								<div class="btn_wrap">
  									<button type="button" class="btn em big" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">홈으로</button>
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

