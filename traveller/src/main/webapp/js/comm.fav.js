$(function(){
	//좋아요 선택 여부와 선택한 총 개수 읽기
	function selectFav(){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{comm_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				displayFav(param);
				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
			
		})
	}
	//좋아요 등록(및 삭제) 이벤트 연결
	$('#output_fav').click(function(){
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{comm_num:$(this).attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌려주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('좋아요 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		})
	});
	//좋아요 표시
	function displayFav(param){
		let output;
		if(param.status=='yesFav'){//좋아요 미선택
			output = '../upload/fav02.png';
		}else{//좋아요 선택
			output = '../upload/fav01.png'
		}
		
		//문서 객체에 설정
		$('#output_fav').attr('src', output);
		$('#output_fcount').text(param.count);
	}
	//초기 데이터 호출
	selectFav();
	
});