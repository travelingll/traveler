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
												<a href="${pageContext.request.contextPath}/comm/list.do">트래블러 클럽</a>
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
    								<div class="text_wrap big fix"><strong class="tit">글쓰기</strong></div> 
    								<div class="js_tabs link type1 v-tabs">
    									<ul class="tabs"></ul> 
    										<div class="panels">
    											<div id="tabCon01" class="panel selected">
    												<div class="tbl">  
    												
    												
    												
<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="comm_num" value="${comm.comm_num}">													
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
				<span class="impt"><label for="comm_title">제목</label></span>
			</th> 
			<td colspan="3">
				<div class="form_holder" style="width:819px">
					<input type="text" name="comm_title" id="comm_title"  placeholder="제목을 입력해 주세요." value="${comm.comm_title}" style="width:100%;" class="insert_check">
				</div>
			</td>
		</tr> 
		<tr>
			<th>
				<span class="impt"><label for="comm_content">내용</label></span>
				
			</th> 
			<td colspan="3">
				<div class="form_holder v-placeholder" style="width:819px">
					<textarea rows="10"  name="comm_content" id="comm_content" placeholder="내용을 입력해 주세요." class="insert_check"></textarea> 
                </div>
            </td>
        </tr>
        <tr>
			<th>
				<span class="impt"><label>여행스타일</label></span>
			</th> 
			<td colspan="3">
				<div class="form_wrap">
					<span class="form_holder check">
											<input type="radio" name="category" id="category" value="1" class="inpt_checkbox"> 
											<label for="radioText01" class="label_checkbox">커플여행</label>
											<input type="radio" name="category" id="category" value="2" class="inpt_checkbox"> 
											<label for="radioText02" class="label_checkbox">가족여행</label>
											<input type="radio" name="category" id="category" value="3" class="inpt_checkbox"> 
											<label for="radioText03" class="label_checkbox">아동동반여행</label>
											<input type="radio" name="category" id="category" value="4" class="inpt_checkbox"> 
											<label for="radioText04" class="label_checkbox">친구모임</label>
											<input type="radio" name="category" id="category" value="5" class="inpt_checkbox"> 
											<label for="radioText04" class="label_checkbox">나홀로여행</label>
											<input type="radio" name="category" id="category" value="6" class="inpt_checkbox"> 
											<label for="radioText04" class="label_checkbox">기타</label>
					</span>
				</div>
            </td>
        </tr>
        <tr>
			<th>
				<span class="impt"><label>태그</label></span>
			</th> 
			<td colspan="3">
				<div class="form_wrap">
					<span class="form_holder check">
											<input type="checkbox" name="tag" value="1">
											<label for="radioText01" class="label_checkbox">객실뷰가 좋아요</label>
											<input type="checkbox" name="tag" value="2">
											<label for="radioText02" class="label_checkbox">일정이 알차요</label>
											<input type="checkbox" name="tag" value="3">
											<label for="radioText03" class="label_checkbox">현지 음식이 맛있어요</label>
											<input type="checkbox" name="tag" value="4"> 
											<label for="radioText04" class="label_checkbox">가이드가 배려 깊고 세심해요</label>
											<input type="checkbox" name="tag" value="5"> 
											<label for="radioText04" class="label_checkbox">가격이 합리적이에요</label>
					</span>
				</div>
            </td>
        </tr>
        <tr>
			<th>
				<span class="impt"><label>파일첨부</label></span>
			</th> 
			<td colspan="3">
						<div class="file_attach_wrap">
							<ul>
								<div class="file_attach_wrap mt20">
									<ul>
										<li>
											<a class="btn" style="cursor:pointer;display:;"><label for="filename1">파일</label></a> 
											<input type="file" name="filename1" id="filename1"  accept="image/gif, image/png, image/jpeg" style="display:none;" class="insert_check">
										</li> 
										<li>
											<span class="img">
												<img src="" alt="" style="display:none;">
											</span> 
											<a class="cls" style="cursor:pointer;display:none;">삭제</a> 
											<span class="img" style="display:;"></span> 
											<a class="btn" style="cursor:pointer;display:;"><label for="filename2">파일</label></a> 
											<input type="file" name="filename2" id="filename2"  accept="image/gif, image/png, image/jpeg" style="display:none;">
										</li>  
										<li>
											<span class="img">
												<img src="" alt="" style="display:none;">
											</span> 
											<a class="cls" style="cursor:pointer;display:none;">삭제</a> 
											<span class="img" style="display:;"></span> 
											<a class="btn" style="cursor:pointer;display:;"><label for="filename3">파일</label></a> 
											<input type="file" name="filename3" id="filename3"  accept="image/gif, image/png, image/jpeg" style="display:none;">
										</li> 
									</ul>
								</div>
							</ul>
						</div> 
						<p class="txt billiard">개당 3MB 미만의 <strong>BMP, GIF, JPG, JPEG, PNG, TIF</strong> 파일만 등록 가능합니다.</p> 
						<p class="txt billiard">음란 및 불법적인 내용은 통보 없이 삭제될 수 있습니다.</p></td>
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
													
				