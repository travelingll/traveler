function outputEvent(text){
	//태그
	let output = '<span class="event-output">';
	output += text;
	output += '</span>';
	
	//event_div 내의 버튼을 숨기고 결과 출력
	$('#event_btn').hide();
	$('#event_div').append(output);
};

$(function(){
	$('#event_btn').click(function(){
		
		/*-----ajax 통신-----*/
		$.ajax({
			url:'eventExecute.do',
			type:'post',
			data: {event_num:$('#event_btn').attr('data-eventnum'),
					answer:$('#event_answer').val()},
			dataType:'json',
			success:function(param){
				if(param.result=='success'){
					let text = '';
					if($('#event_answer')>0) text += '로또 번호는 ' + param.lotto_num + '입니다!<br>';
					text='성공! <span id="event_getmoney">'+param.money+'</span>원이 지급되었습니다 : )';
					outputEvent(text);
				} else if (param.result=='failed'){
					outputEvent('답 맞추기 실패 : (');
				} else if(param.result=='end'){
					outputEvent('종료된 이벤트입니다 : (');
				} else if(param.result=='done'){
					outputEvent('이미 참여한 이벤트입니다 : (');
				} else{
					alert('이벤트 오류!');
				}
			},
			error:function(){
				alert('네트워크 통신 오류!');
			}
		});//end of ajax
	});//end of click
});//end of function