<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/enuseo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commDetailWrite.css">
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
		}
	})
})
</script>
<script type="text/javascript">
var text = document.getElementById("textarea").value;
text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');

//<br> => enter
var text = document.getElementById("textarea").value;
text = text.replaceAll("<br>", "\r\n");
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
													<li><a href="${pageContext.request.contextPath}/faq/list.do">자주찾는질문</a></li>
							<li><a href="${pageContext.request.contextPath}/question/userQuestionWriteForm.do">1:1문의하기</a></li>
							<li><a href="${pageContext.request.contextPath}/question/questionList.do">1:1문의</a></li>
						</ul>
											</dd>
										</dl>
    								</div>
    							</div> 
    							<!-- 여기까지 사이드바 입니다.-->
    							<div id="contents" class="contents">
    								<div class="text_wrap big fix"><strong class="tit">글쓰기</strong></div> 
    								<div class="js_tabs link type1 v-tabs">
    									<ul class="tabs"></ul> 
    										<div class="panels">
    											<div id="tabCon01" class="panel selected">
    												<div class="tbl">  
    												
    												
    												
<form id="write_form" action="write.do" method="post">												
<table class="type2">
	<colgroup>
		<col style="width:15%">
		<col style="width:36%"> 
		<col style="width:15%"> 
		<col>
	</colgroup> 
	<tbody>
		<tr>
			<th>
				<span class="impt"><label for="title">제목</label></span>
			</th> 
			<td colspan="3">
				<div class="form_holder" style="width:819px">
					<input type="text" name="title" id="title"  placeholder="제목을 입력해 주세요." style="width:100%;" class="insert_check">
				</div>
			</td>
		</tr> 
		<tr>
			<th>
				<span class="impt"><label for="content">내용</label></span>
				
			</th> 
			<td colspan="3">
				<div class="form_holder v-placeholder" style="width:819px">
					<textarea rows="10"  name="content" id="content" placeholder="내용을 입력해 주세요." class="insert_check"></textarea> 
                </div>
            </td>
        </tr>
        <tr>
			<th>
				<span class="impt"><label>카테고리</label></span>
			</th> 
			<td colspan="3">
				<div class="form_wrap">
					<span class="form_holder check">
					
					<input type="radio" name="category" id="category" class="question_category" value="1">
					<label for="radioText01" class="label_checkbox">[상품예약.결제]</label>
					<input type="radio" name="category" id="category2" class="question_category" value="2">
					<label for="radioText02" class="label_checkbox">[해외패키지]</label>
					<input type="radio" name="category" id="category3" class="question_category" value="3">
					<label for="radioText03" class="label_checkbox">[개인정보변경]</label>						
					
					</span>
				</div>
            </td>
        </tr>
     	</tbody>
		</table>
		<div class="align-center" style="">
			<input class="btn" type="submit" value="등록">
			<input class="btn" type="button" value="목록" onclick="location.href='list.do'">
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
</div>
</div>
</div>



    													
    			
</body>

</html>
													

