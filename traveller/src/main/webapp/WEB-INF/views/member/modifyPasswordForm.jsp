<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//이벤트 연결
	$('#password_form').submit(function(){
		let items = document.querySelectorAll('input[type="text"],input[type="password"]');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				let label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value='';
				items[i].focus;
				return false;
			}
		}
		if($('#passwd').val()!=$('#cpasswd').val()){
			alert('새 비밀번호와 새 비밀번호 확인이 불일치');
			$('#passwd').val('').focus();
			$('#cpasswd').val('');
			return false;
		}
	});
});
</script>
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
	 												<li><a href="${pageContext.request.contextPath}/accom/applyAccomList.do">동행 신청내역</a></li>
	 												<li><a href="${pageContext.request.contextPath}/accom/requestAccomList.do">받은 동행 신청내역</a></li>
													<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
													<li><a href="${pageContext.request.contextPath}/order/myOrderList.do">예약내역</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="order-form">
									<h1 class="order-title order-center">비밀번호 수정</h1>
									<form action="modifyPassword.do" method="post" id="password_form" class="input-form">
										<input type="hidden" name="mem_num" value="${mem.mem_num}">
										<ul class="order-ul">
											<li>
												<label for="id">아이디</label>
												<input type="text" name="id" id="id" maxlength="12" placeholder="아이디를 입력">
											</li>
											<li>
												<label for="origin_passwd">현재 비밀번호</label>
												<input type="password" name="origin_passwd" id="origin_passwd" maxlength="12" placeholder="현재 비밀번호 입력">
											</li>
											<li>
												<label for="passwd">새 비밀번호</label>
												<input type="password" name="passwd" id="passwd" maxlength="12" placeholder="새 비밀번호 입력">
											</li>
											<li>
												<label for="cpasswd">새 비밀번호 확인</label>
												<input type="password" id="cpasswd" maxlength="12" placeholder="새 비밀번호 입력">
											</li>
										</ul>
										<div class="my-btn-align">
											<input type="submit" value="비밀번호 수정">
											<input type="button" value="My페이지" onclick="location.href='myPage.do'" id="home">
										</div>
									</form>
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