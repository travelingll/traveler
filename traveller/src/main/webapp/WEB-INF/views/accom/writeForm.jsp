<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행구하기 게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/enuseo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/accomWriteForm.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//이벤트 연결
	$('#write_form').submit(function(){
		if($('#accom_title').val().trim()==''){
			alert('제목을 입력하세요');
			$('#accom_title').val('').focus();
			return false;
		}
		if($('#accom_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#accom_content').val('').focus();
			return false;
		}
		if($('#accom_quantity').val().trim()==''){
			alert('모집인원을 입력하세요');
			$('#accom_quantity').val('').focus();
			return false;
		}
		if($('#accom_expense').val().trim()==''){
			alert('여행경비를 입력하세요');
			$('#accom_expense').val('').focus();
			return false;
		}
		if($('#accom_start').val().trim()==''){
			alert('출발일을 입력하세요');
			$('#accom_start').val('').focus();
			return false;
		}
		if($('#accom_end').val().trim()==''){
			alert('종료일을 입력하세요');
			$('#accom_end').val('').focus();
			return false;
		}
		if($('input[type=radio]:checked').length < 1){
			alert('진행여부를 선택하세요!');
			return false;
		}
	});
});
</script>
</head>
<body>
<div class = "page-main">
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
												<a href="${pageContext.request.contextPath}/accom/list.do">트래블러 클럽</a>
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
	<div class = "content-main">
		<h2>게시판 글쓰기</h2>
		<br>
		<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for = "accom_title">제목</label>
				<input type="text" name="accom_title" id="accom_title" maxlength="50">
			</li>
			<li>
				<label for = "accom_content">내용</label>
				<textarea rows="5" cols="30" name="accom_content" id="accom_content"></textarea>
			</li>
			<li>
				<label for = "accom_filename">파일</label>
				<input type="file" name="accom_filename" id="accom_filename" accept="image/gif, image/png, image/jpeg">
			</li>
			<li>
					<label for="accom_quantity">모집인원</label>
					<input type="number" id="accom_quantity" name="accom_quantity" min="1" size="3">
				</li>
					<li>
					<label for="accom_expense">여행경비</label>
					<input type="number" name="accom_expense" id="accom_expense" class="input-check" min="1" maxlength="999999999">
				</li>
				<li>
					<label for="accom_start">출발일</label>
					<input type="date" id="accom_start" name="accom_start" maxlength="100" size="20">
				</li>
				<li>
					<label for="accom_end">종료일</label>
					<input type="date" id="accom_end" name="accom_end" maxlength="100" size="20">
				</li>
				<li>
					<label>진행여부</label>
					<input type="radio" name="accom_status" value="0" id="accom_status0">진행중
					<input type="radio" name="accom_status" value="1" id="accom_status1">완료
				</li>
		</ul>
		<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
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