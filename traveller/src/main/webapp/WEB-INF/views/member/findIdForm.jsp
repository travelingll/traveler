<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/find.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//아이디 찾기 유효성 체크
	$('#find_form').submit(function(){
		let items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				let label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}//end of if
		}//end of for
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
    							<a href="${pageContext.request.contextPath}/member/loginForm.do" class="js_act btn_prev">
    							
    								<span>이전페이지</span>
    							</a> 
    							<h1 class="title">아이디 찾기</h1> 
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
  						<form id="find_form" action="findId.do" method="post">
  							<ul class="inner_cont form_wrap">
  								<li>
  									<div class="field_group">
  										<div class="input_text">
		  									<input id="name" name="name" type="text" title="이름" placeholder="" class="input-check" autocomplete="off">
		  									<label for="name">이름</label>
  										</div>
  									</div>
  								</li>
  								<li>
  									<div class="field_group">
  										<div class="input_text">
		  									<input id="email" name="email" type="email" title="이메일" placeholder="" class="input-check" autocomplete="off">
		  									<label for="email">이메일</label>
  										</div>
  									</div>
  								</li>
  							</ul>
  							<div class="btn_wrap mt12">
    							<input type="submit" class="btn em big disable" value="아이디 찾기">
    						</div> 
  						</form>
  						</div>
  					</div>
  				</div> 
			</div>
		</div>
	</div> 
</body>
</html>

