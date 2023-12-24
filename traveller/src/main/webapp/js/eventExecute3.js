function outputEvent(text,num){
	//태그
	let output = '<span class="event-output">로또 번호는 '+num+'입니다!<br><br>';
	output += text;
	output += '</span>';
	
	//event_div 내의 버튼을 숨기고 결과 출력
	$('#event_btn').hide();
	$('#event_div').append(output);
};

$(function(){
	$('#event_btn').click(function(){
		
		//값 미입력시
		if( $('#event_answer').val().trim()=='' ){
			alert('숫자를 입력해주세요!');
			$('#event_answer').val('').focus();
			return;
		}
		
		//입력받은 값을 띄어쓰기를 구분자로 배열에 저장
		let answer = $('#event_answer').val().split(' ');
		
		//6개보다 많거나 작게 입력한 경우
		if( answer.length != 6){
			alert('숫자 6개를 입력해주세요!');
			$('#event_answer').val('').focus();
			return;
		}
		
		for(let i=0 ; i<answer.length ; i++){
			//숫자 외의 값이 있는 경우
			if(/^[0-9]$/.test(answer[i])==false){
				alert('숫자 외의 문자는 입력할 수 없습니다!');
				$('#event_answer').val('').focus();
				return;
			}
			//입력한 숫자가 1~45 사이가 아닌 경우
			if(answer[i]<=0 || answer[i]>45) {
				alert('숫자는 1부터 45 사이만 입력 가능합니다!');
				$('#event_answer').val('').focus();
				return;
			}
		}
		
		/*-----ajax 통신-----*/
		$.ajax({
			url:'eventExecute.do',
			type:'post',
			data: {event_num:$('#event_btn').attr('data-eventnum'),
					answer:$('#event_answer').val()},
			dataType:'json',
			success:function(param){
				if(param.result=='success'){
					text='성공! <span id="event_getmoney">'+param.money+'</span>원이 지급되었습니다 : )';
					outputEvent(text,param.num);
				} else if (param.result=='failed'){
					outputEvent('로또 번호 맞추기 실패 : ( 위로금 100원이 지급됩니다',param.num);
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