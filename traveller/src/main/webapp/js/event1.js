$(function(){
	$('#event_btn').click(function(){
		let event_num = $('#event_btn').attr('data-eventnum');		
		$.ajax({
			url:'eventExecute.do',
			type:'post',
			data: {event_num:event_num},
			dataType:'json',
			success:function(param){
				if(param.result=='success'){
					alert(param.money+'원이 지급되었습니다!');
					//동적으로 태그 생성하기
					
				} else if(param.result=='end'){
					alert('이벤트가 종료되었습니다!');
				} else if(param.result=='done'){
					alert('이미 참여한 이벤트입니다!');
				} else{
					alert('이벤트 오류');
				}
			},
			error:function(){
				alert('네트워크 통신 오류');
			}
		});//end of ajax
	});//end of click
});//end of function