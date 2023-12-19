<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/eunseo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide(); //수정 버튼 감추기
	});
	
	//이미지 미리 보기
	let photo_path = $('.my-photo').attr('src');
	$('#photo').change(function(){
		let my_photo = this.files[0];
		if(!my_photo){
			//선택을 취소하면 원래 처음 화면으로 되돌림
			$('.my-photo').attr('src',photo_path);
			return;
		}
		if(my_photo.size > 1024 * 1024){
			alert(Math.round(my_photo.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',photo_path);
			$(this).val(''); //선택한 파일 정보 지우기
			return;
		}
		
		//화면에서 이미지 미리 보기
		const reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload=function(){
			$('.my-photo').attr('src',reader.result);
		};
	}); //end of change
	
	//이미지 전송
	$('#photo_submit').click(function(){
		if($('#photo').val()==''){
			alert('파일을 선택하세요!');
			$('#photo').focus();
			return;
		}
		//파일 전송
		const form_data = new FormData();
		/*
		자바스크립트로 호출 document.getElementById('photo').files[0]
		jquery로 호출 $('#photo')[0].files[0] --> 제이쿼리는 모두 배열로 인식하기 때문에 인덱스를 명시해서 처리
		*/
		form_data.append('photo',$('#photo')[0].files[0]);
		$.ajax({
			url:'updateMyPhoto.do',
			type:'post',
			data:form_data,
			dataType:'json',
			contentType:false, //데이터 객체를 문자열로 바꿀지에 대한 값, true:일반문자
			processData:false, //해당 타입을 true로 하면 일반 text로 구분
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//수정된 이미지 정보 저장
					photo_path = $('.my-photo').attr('src');
					$('#photo').val('');
					$('#photo_choice').hide();
					$('#photo_btn').show(); //수정 버튼 표시
				}else{
					alert('파일 전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}); //end of click
	
	//이미지 미리보기 취소
	$('#photo_reset').click(function(){
		//초기 이미지 표시
		$('.my-photo').attr('src',photo_path); //이미지 미리보기 전 이미지로 되돌리기
		$('#photo').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show(); //수정 버튼 표시
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
													<li><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
												</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">개인정보</strong></div> 
    								<div class="js_tabs link type1 v-tabs">
    									<ul class="tabs"></ul> 
    										<div class="panels">
    											<div id="tabCon01" class="panel selected">
    												<div class="tbl">  
    												<ul>
														<li>
															<c:if test="${empty member.photo}">
															<img src="${pageContext.request.contextPath}/images/face.jpg" width="150" height="150" class="my-photo">
															</c:if>
															<c:if test="${!empty member.photo}">
															<img src="${pageContext.request.contextPath}/upload/${member.photo}" width="150" height="150" class="my-photo">
															</c:if>					
														</li>
														<li>
															<div class="align-center">
																<input class=btn type="button" value="수정" id="photo_btn">
															</div>
															<div id="photo_choice" style="display:none;">
																<input type="file" id="photo" accept="image/gif,image/png,image/jpeg"><br><br>
																<input class=btn type="button" value="전송" id="photo_submit">
																<input class=btn type="button" value="취소" id="photo_reset">
															</div>
														</li>
														<li>
														<div class="buttons" style="float:right" >
														
															<input class="btn" type="button" value="비밀번호 수정" onclick="location.href='modifyPasswordForm.do'">
															<input class="btn" type="button" value="회원탈퇴" id="user_delete">
															<script>
																let user_delete = document.getElementById('user_delete');
																	user_delete.onclick = function(){
																	let choice = confirm('정말 탈퇴 하시겠습니까?');
																		if(choice){
																			location.replace('deleteUserForm.do');
																					}
																				};
															</script>
														</div>	
															
														</li>
														<li>
															<c:if test="${member.auth == 3}">
															<b>등급 : 일반</b>
															</c:if>
															<c:if test="${member.auth == 2}">	
															<b>등급 : VIP</b>
															</c:if>
															<c:if test="${member.auth == 1}">
															<b>등급 : VVIP</b>
															</c:if>
															<c:if test="${member.auth == 9}">
															<b>등급 : 관리자</b>
															</c:if>
														</li>
													</ul>
    													<table class="type2">
    														<colgroup><col style="width: 20%;"><col></colgroup> 
    														<tbody>
    															<tr>
    																<th>이름</th><td>${member.name}</td>
    															</tr> 
    															<tr><th>아이디</th>
    																<td>
    																	${member.id}<!----> 
    																	<ul class="list_bul billiard">
    																		<li>트래블러닷컴에서는 사용하고 계신 아이디는 변경불가합니다.</li> <!---->
    																	</ul>
    																</td>
    															</tr> 
    															<tr>
    																<th>휴대폰번호</th> 
    																<td>${member.phone}
    																<input class="btn" type="button" value="연락처 수정" onclick="location.href='modifyUserForm.do'">
    																</td>
    															</tr> 
    															<tr>
    																<th>생년월일/성별</th> 
    																<td>${member.birth}</td>
    															</tr> 
    															<tr>
    																<th>이메일</th> 
    																<td>${member.email}
    																	<ul class="list_bul billiard">
    																		<li>트래블러닷컴에서는 사용하고 계신 e-mail주소는 변경 불가합니다.</li>
    																	</ul>
    																</td>
    															</tr>
    															<tr>
    																<th>우편번호</th> 
    																<td>${member.zipcode}</td>
    															</tr> 
    															<tr>
    																<th>주소</th> 
    																<td>${member.address1} ${member.address2}</td>
    															</tr> 
    															<tr>
    																<th>가입일</th> 
    																<td>${member.reg_date}</td>
    															</tr> 
    															<c:if test="${!empty member.modify_date}">
    															<tr>
    																<th>최근 정보 수정일</th> 
    																<td>${member.modify_date}</td>
    															</tr> 
    															</c:if>
    														</tbody>
    													</table>
    												</div>     
    											</div>
    										</div>
    									</div> <!---->
    								</div>
    							</div>
    						</div>
    					</div> 
    				</div> <!----> 
    				<div id="printArea">
    				</div> 
    														
    			</div>
    		</div>
    	</div>
  




ㄴ

 

</body>
</html>