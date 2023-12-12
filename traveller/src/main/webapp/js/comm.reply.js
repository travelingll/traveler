$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	//댓글 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		  
		$.ajax({
			url:'listReply.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,comm_num:$('#comm_num').val()},
			dataType:'json',
			success:function(param){
				//loading img hide
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<h4>' + item.id + '</h4>';
					output +='<div class="sub-item">';
					
					output +='<p>' + item.comm_recontent +'</p>';
					
					if(item.comm_remodifydate){
						output += '<span class="modify-date">최근 수정일 : ' + item.comm_remodifydate + '</span>';
					}else{
						output += '<span class="modify-date">등록일 : ' + item.comm_redate + '</span>';
					}
					//로그인한 회원버호와 작성자의 회원번호 일치 여부 체크
					if(param.user_num == item.mem_num){//로그인한 회원번호와 작성자 회원번호 일치
						output += ' <input type="button" data-renum="' + item.comm_renum + '" value="수정" class="modify-btn">';
						output += ' <input type="button" data-renum="' + item.comm_renum + '" value="삭제" class="delete-btn">';
					}
					output += '<hr size="1" noshade width="100%">';
					output +='</div>';
					output += '</div>';
					   
					//문서객체에 추가
					$('#output').append(output);
				});
				if(currentPage>=Math.ceil(count/rowCount)){
					$('.paging-button').hide();
				}else{
					$('.paging-button').show();
					
				}
			},
			error:function(){
				//loading img hide
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}
		})
	}
	//page 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
	$('.paging-button input').click(function(){
		selectList(currentPage +1);
	})
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#comm_recontent').val().trim(	)==''){
			alert('내용을 입력하세요');
			$('#comm_recontent').val('').focus();
			return false;
		}
		
		//form 이하의 태그에 입력한 데이터를 모두 읽어옴(쿼리 스트링 형식으로 읽어옴)
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data: form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성 할 수 있습니다.')
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글을 다시 호출함
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		})
		
		//기본 이벤트 제거
		event.preventDefault();
		
	})
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구함.
		let inputLength = $(this).val().length;
		
		if(inputLength > 300){
				$(this).val($(this).val().substring(0,300));
				
			}else{
				let remain = 300 -inputLength;
				remain += '/300';
				if($(this).attr('id') =='comm_recontent'){
					$('#re_first .letter-count').text(remain); //re_first .letter-count 붙이면 안됨
				}else{
					$('#mre_first .letter-count').text(remain);
				}
				
			
		}
	})
	//댓글 수정 버튼 클릭 시 수정폼 노출
	$(document).on('click','.modify-btn',function(){
		//댓글 번호 읽어오기
		let comm_renum = $(this).attr('data-renum');
		//댓글 내용
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
																//g:지정문자열 모두, i:대소문자 무시
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="comm_renum" id="comm_mrenum" value="'+comm_renum+'">';
		modifyUI += '<textarea row="3" cols="50" name="comm_recontent" id="comm_mrecontent" class="rep-content">'+content+'</textarea>';
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span><div>';
		modifyUI += '<div id="mre_second" class-"align-right">';
		modifyUI += '<input type="submit" values"수행">';
		modifyUI += '<input type="button" value="취소" class="re-reset">'
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면
		//숨겨져 있는 div(class=sub-item)을 환원시키고 수정폼을 초기화함(제거)
		initModifyForm();
		
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//수정버튼을 감싸고 있는 div
		$(this).parent().hide();
		
		//수정폼을 수정하고자 하는 데이터가 있는 div 에 노출
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#comm_mrecontent').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);
	})
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	})
	//댓글 수정폼초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#comm_mrecontent').val().trim()==''){
			alert('내용 입력하세요');
			$('#comm_mrecontent').val('').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와통신
		$.ajax({
			url:'updateReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 수정할 수 있습니다.')
				}else if(param.result == 'success'){
					//댓글 내용
					$('#mre_form').parent().find('p').html($('#comm_mrecontent').val().replace(/</g,'&lt;').replace(/>/,'&gt;').replace(/\n/g,'<br>'));
					//수정 시간
					$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초 미만');
					//수정폼 삭제 및 초기화
					initModifyForm();
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 수정할 수 없습니다.')
				}else{
					alert('댓글 수정 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		})
		//기본이벤트 제거
		event.preventDefault();
	})
	//댓글 삭제
	$(document).on('click','.delete-btn',function(){
		//댓글 번호
		let comm_renum = $(this).attr('data-renum');
		
		$.ajax({
			url:'deleteReply.do',
			type:'post',
				// 키		변수(value)
			data:{comm_renum:comm_renum},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제 완료');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		})
	})
	//초기 데이터(목록) 호출
	selectList(1);
})
