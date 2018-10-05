<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.fileDrop{
		width:100%;
		height:200px;
		border: 1px dotted blue;
	}
	
	small{
		margin-left: 3px;
		font-weight: bold;
		color: gray;
	}
	
</style>
</head>
<body>
<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script>
		$(".fileDrop").on("dragenter dragover",function(event){
			event.preventDefault();//화면변화X
		});
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();//화면변화X
			
			var files = event.originalEvent.dataTransfer.files;//전달된 파일데이터를 가져올때
			var file = files[0];
			console.log(file);
			
			var formData = new FormData();//formData를 이용해서  서버로 파일전송 호출
			formData.append("file",file);//'file' 이름으로 끌어다 놓은 파일 객체를 추가
			
			$.ajax({
				url:'/uploadAjax',
				data:formData,
				dataType:'text',
				processData: false,
				contentType: false,
				type:'POST',
				success: function(data) {
					var str="";
					if(checkImageType(data)){
						str= "<div><a href='displayFile?fileName="+getImageLink(data)+"'>"
								+"<img src='displayFile?fileName="+data+"'>"
								+"</a><small data-src="+data+">X</small></div>";
					}else{//이미지 파일이 아닌 경우
						str= "<div><a href='displayFile?fileName="+data+"'>"
						+getOriginalName(data)+"</a><small data-src="+data+">X</small></div>";
					}				
					$(".uploadedList").append(str);
				}				
			});
		});
	
	$(".uploadedList").on("click","small",function(event){// X : 현재 파일이 들어 있는 영역삭제
		var that = $(this);
		$.ajax({
			url:"deleteFile",
			type:"post",
			data: {fileName:$(this).attr("data-src")},
			dataType:"text",
			success:function(result){
				if(result == "deleted"){
					alert("deleted!!");
					that.parent("div").remove();
				}
			}	
		});
	});	
		
		
	function getOriginalName(fileName){
		if(checkImageType(fileName)){
			return;
		}
		var idx = fileName.indexOf("_")+1;
		return fileName.substr(idx);
	}
		
	function getImageLink(fileName){
		if(!checkImageType(fileName)){
			return;
		}
		var front = fileName.substr(0,12);
		var end = fileName.substr(14)
		return front+end;
	}	
		
		//이미지 파일 인지 여부
	function checkImageType(fileName){
		var pattern = /jpg$|gif$|png$|jpeg$/i /* i는 대소문자 */
		return fileName.match(pattern);
	}	
		
	</script>
</body>
</html>
















