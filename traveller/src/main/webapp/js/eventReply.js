$(function(){
	let count; //총 댓글 갯수
	let currentPage; //현재 페이지
	let rowCount = 5; // 한 페이지에 표시할 댓글 수
	
	/*----------댓글 목록----------*/
	function selectEventReplyList(pageNum){
		currentPage = pageNum;

		//ajax 통신
		$.ajax({
			url:'eventReplyList.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,event_num:$('#event_num').val()},
			dataType:'json',
			success:function(param){

				count = param.count;
				
				if(pageNum==1){ //진입 시 내용물 제거
					$('#output').empty();
				}
				
				//동적인 댓글 출력 태그 생성
				$(param.list).each(function(index,item){
					
					let output = '<div class="item">';
					
					output += '<h4>'+item.id+'</h4>';
					output += '<div class="sub-item"><p>'+item.event_recontent+'</p>';
					
					if(item.event_modifydate) output += '<div class="event_modifydate detail-right">'+item.event_modifydate+'</div>';
					else output += '<div class="detail-right">'+item.event_redate+'</div>';
					
					if(param.user_num == item.mem_num){
						output += '<div class="detail-right"><input type="button" value="수정" class="modify-btn" data-renum="'+item.event_renum+'">';
						output += ' <input type="button" value="삭제" class="delete-btn" data-renum="'+item.event_renum+'"></div>';
					}
					
					output += '<hr size="1" width="100%">';
					output += '</div>';
					output += '</div>';
					
					$('#output').append(output);
				});
				
				//페이지 버튼 처리
				if(currentPage >= Math.ceil(count/rowCount)){
					$('#paging_btn').hide();
				} else{
					$('#paging_btn').show();
				}
			},
			error:function(){
				alert('네트워크 통신 오류');
			}
		});
	}//end of selectEventReplyList
	
	$('#paging_btn').click(function(){
		selectEventReplyList(currentPage+1);
	});
	
	/*----------댓글 등록----------*/
	$('#re_form').submit(function(event){
		
		if($('#event_recontent').val().trim()==''){
			alert('댓글 내용을 작성해주세요');
			$('#event_recontent').val().focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		
		$.ajax({
			url:'writeEventReply.do',
			type : 'post',
			data : form_data,
			dataType : 'json',
			success:function(param){
				console.log(param.result);
				if(param.result=='logout'){
					alert('로그인 필요');
				} else if(param.result=='success'){
					//폼 초기화
					initForm();
					//댓글 목록 불러오기
					selectEventReplyList(1);
				} else {
					alert('댓글 등록 오류');
				}
			},
			error:function(){
				alert('네트워크 오류');
			}
		});//end of ajax
		
		event.preventDefault();
	});//end of reply_form submit
	
	/*----------댓글 작성폼 초기화----------*/
	function initForm(){
		$('#event_recontent').val('');
	}
	
	/*----------댓글 수정폼----------*/
	$(document).on('click','.modify-btn',function(){
		
		let event_renum = $(this).attr('data-renum');
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
		
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="event_renum" id="event_mrenum" value="'+event_renum+'">';
		modifyUI += '<textarea rows="3" cols="50" name="event_recontent" id="event_mrecontent" class="rep-content">'+content+'</textarea>';
		modifyUI += '<div id="mre_first"></div>';
		modifyUI += '<div id="mre_second" class="align-right">';
		modifyUI += '<input type="submit" value="수정">';
		modifyUI += '<input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		//다른 댓글 수정 버튼 클릭 처리
		initModifyForm();
		$(this).parent().hide();
		
		//수정폼 노출
		$(this).parents('.item').append(modifyUI);
	});
	
	/*----------댓글 수정폼 초기화----------*/
	function initModifyForm(){
		$('.sub-item').show();//원댓글 표시
		$('#mre_form').remove();//수정폼 제거
	}
	
	/*----------수정폼 취소 버튼 클릭 시 수정폼 초기화----------*/
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	/*----------댓글 수정----------*/
	$(document).on('submit','#mre_form',function(event){
		//유효성 체크
		if($('#event_mrecontent').val().trim()==''){
			alert('댓글 내용을 입력하세요');
			$('#event_mrecontent').val('').focus();
			return false;
		}
		
		//데이터 저장
		let form_data = $(this).serialize();
		
		//통신
		$.ajax({
			url : 'eventReplyUpdate.do',
			type : 'post',
			data : form_data,
			dataType : 'json',
			success : function(param){
				if(param.result=='logout'){
					alert('로그인 필요');
				} else if(param.result=='wrongAccess'){
					alert('작성자만 댓글 삭제 가능');
				} else if(param.result=='success'){
					//댓글 내용 제어
					$('#mre_form').parent().find('p').html( $('#event_mrecontent').val()
						.replace(/</g, '&lt;').replace(/>/g,'&gt;').replace(/\n/g, '<br>'));
					//수정 시간
					$('#mre_form').parent().find('.event_modifydate').text('방금 수정됨');
					//수정폼 삭제 및 초기화
					initModifyForm();
					alert('댓글 수정 성공');
				} else{
					alert('댓글 수정 오류');
				}
			},
			error : function(){
				alert('네트워크 오류');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});

	/*----------댓글 삭제----------*/
	$(document).on('click','.delete-btn',function(){
		if(confirm('댓글을 삭제하시겠습니까?')){
			let event_renum = $(this).attr('data-renum');
			$.ajax({
				url:'deleteEventReply.do',
				type:'post',
				data:{event_renum:event_renum},
				dataType:'json',
				success:function(param){
					if(param.result=='logout'){
						alert('로그인 필요');
					} else if(param.result=='wrongAccess'){
						alert('댓글 작성자만 삭제 가능');
					} else if(param.result=='success'){
						alert('댓글 삭제 완료');
						selectEventReplyList(1);
					} else {
						alert('댓글 수정 오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
	});
	
	selectEventReplyList(1);
});