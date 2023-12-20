<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#login_form').submit(function(){
		if($('#id').val().trim()==''){
			alert('아이디를 입력하세요');
			$('#id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim()==''){
			alert('비밀번호를 입력하세요');
			$('#passwd').val('').focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<div id="__nuxt">
    	<!---->
    		<div id="__layout">
    			<div id="wrapper">
    				<div id="wrap">
    					<div id="headerWrap" class="header_wrap">
    						<div id="header">
    							<a href="${pageContext.request.contextPath}/main/main.do" class="js_act btn_prev">
    							
    								<span>이전페이지</span>
    							</a> 
    							<h1 class="title">로그인</h1> 
    						<!---->
    					</div>
    				</div> 
    				
    				<div id="container">
    					<div class="contents_wrap login_wrap">
    						<div class="logo_wrap">
    							<span class="logo">트래블러</span>
    						</div> 
    					<!---->
    					<form id="login_form" action="login.do" method="post">
    						<div class="inner_cont">
    							<div class="input_duo">
    								<span class="input_text">
    									<input maxlength="12" name="id" class="form-input" id="id" type="text" title="아이디" autocomplete="off" placeholder="" > 
    									<label for="id">아이디</label>
    								</span> 
    								<span class="input_text">
    									<input maxlength="12" name="passwd" class="form-input" id="passwd" type="password" title="비밀번호" autocomplete="off" placeholder=""> 
    									<label for="passwd">비밀번호</label>
    								</span> 
    							</div>
    						</div> 
    					<!----> 
    						<div class="btn_wrap mt12">
    							<input type="submit" class="btn em big disable" value="로그인">
     								 
  							 
  							</div> 
  							</form>
  							<div class="btn_wrap align_wrap mt24">
  								<div class="leftbox">
  									<button type="button" class="btn txt" onclick="location.href='${pageContext.request.contextPath}/member/findIdForm.do'">
  										아이디 찾기
  									</button>&nbsp;&nbsp;
  									<button type="button" class="btn txt" onclick="location.href='${pageContext.request.contextPath}/member/findPasswordForm.do'">
  										비밀번호 찾기
  									</button>
  								</div> 
  								<div class="rightbox">
  									<button type="button" class="btn txt blue ico join" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">회원가입</button>
  								</div>
  							</div> 
  							<div class="inner_cont align_wrap mt04">
  								<div class="rightbox">
  									<span class="tooltip02">
  										<em class="txt_none">회원가입하고 마일리지 혜택을 받아보세요!</em>
  									</span>
  								</div>
  							</div> 
  						   
  					<!---->
  				</div>
  			</div>
  		</div> 
  	<!---->
  </div>
 </div>
</div>
  
</body>
</html>
