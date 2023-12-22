<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#write_form').submit(function(){
		let items = document.querySelectorAll('.insert_check');
		for(let i=0; i<items.length; i++){
			let label = document.querySelector('label[for="'+items[i].id+'"]');
			if(items[i].value.trim()==''){
				alert(label.textContent + ' 항목은 필수 입력입니다.');
				items[i].value='';
				items[i].focus();
				return false;
			}
		}
		if($('input[name="category"]:radio:checked').length<1){
			alert('카테고리를 체크해주세요');
			return false;
		}
		if($('input[name="tag"]:checkbox:checked').length<1){
			alert('태그를 1개 이상 체크해주세요');
			return false;
		}
	})
})
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
													<li><a href="${pageContext.request.contextPath}/accom/list.do">동행구하기</a></li>
													<li><a href="${pageContext.request.contextPath}/comm/list.do">커뮤니티</a></li>
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
													<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
    													<table class="type2">
    														<colgroup>
    															<col style="width: 20%;"><col>
    														</colgroup> 
    														<tbody>
    															<tr>
    																<th><label for="comm_title">제목</label></th><td><input type="text" name="comm_title" id="comm_title" maxlength="50" class="insert_check"></td>
    															</tr> 
    															<tr>
    																<th><label for="comm_content">내용</label></th>
    																<td>
    																	<textarea rows="5" cols="30" name="comm_content" id="comm_content" class="insert_check"></textarea>
    																</td>
    															</tr> 
    															<tr>
    																<th><label for="filename1">파일</label></th> 
    																<td>
    																	<input type="file" name="filename1" id="filename1" accept="image/gif, image/png, image/jpeg" class="insert_check">
    																</td>
    															</tr>
    															<tr>
    																<th><label for="filename">파일</label></th> 
    																<td>
    																	<input type="file" name="filename2" id="filename2" accept="image/gif, image/png, image/jpeg" class="insert_check">
    																</td>
    															</tr> 
    															<tr>
    																<th><label for="filename">파일</label></th> 
    																<td>
    																	<input type="file" name="filename3" id="filename3" accept="image/gif, image/png, image/jpeg" class="insert_check">
    																</td>
    															</tr> 
    															<tr>
    																<th><label>여행스타일</label></th> 
    																<td>
    																	<input type="radio" name="category" value="1">커플여행
																		<input type="radio" name="category" value="2">가족여행
																		<input type="radio" name="category" value="3">아동동반여행
																		<input type="radio" name="category" value="4">친구모임
																		<input type="radio" name="category" value="5">나홀로여행
																		<input type="radio" name="category" value="6">기타
    																</td>
    															</tr>
    															<tr>
    																<th><label>태그</label></th> 
    																<td>
    																	<input type="checkbox" name="tag" value="1">객실뷰가 좋아요
																		<input type="checkbox" name="tag" value="2">일정이 알차요
																		<input type="checkbox" name="tag" value="3">현지 음식이 맛있어요
																		<input type="checkbox" name="tag" value="4">가이드가 배려 깊고 세심해요
																		<input type="checkbox" name="tag" value="5">가격이 합리적이에요
																		
																	</td>
    															</tr> 
    														</tbody>
    														
    													</table>
    													<div class="align-center">
															<input type="submit" value="등록">
															<input type="button" value="목록" onclick="location.href='list.do'">
														</div>
    													</form>
    													
    												</div>     
    											</div>
    										</div>
    									</div> <!---->
    								</div>
    							</div>
    						</div>
    					</div> 
    				</div> <!----> 										
    			</div>
    		</div>
    	</div>
</body>

</html>