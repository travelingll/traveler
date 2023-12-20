<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
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
    							<h1 class="title">아이디 찾기 완료</h1> 
    						<!---->
    					</div>
    				</div> 
    				
    				<div id="container">
    					<div class="contents_wrap login_wrap">
    						<div class="logo_wrap">
    							<span class="logo">트래블러</span>
    						</div> 
  						</div>
  						<div class="tab_cont on">
  							${member.name}님의 아이디는 ${member.id}입니다.
							<p>
							<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
  						</div>
  					</div>
  				</div> 
			</div>
		</div>
	</div> 
</body>
</html>

