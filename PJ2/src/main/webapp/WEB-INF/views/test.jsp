<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 412 -->
<style>
#modDiv {
	width: 300px;
	height: 100px;
	background-color: gray;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}

.pagination {
  width: 100%;
}

.pagination li{
  list-style: none;
  float: left; 
  padding: 3px; 
  border: 1px solid blue;
  margin:3px;  
}

.pagination li a{
  margin: 3px;
  text-decoration: none;  
}

</style>
</head>

<body> 
<!-- 댓글 등록 화면 -->
	<div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id='closeBtn'>Close</button>
		</div>
	</div>
	<h2>Ajax Test Page</h2>
	<div>
		<div>
			REPLYER <input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT <input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	<ul id="replies"></ul>
<!-- 	댓글 페이지 처리(아래) -->
	<ul class='pagination'></ul>	
	<!-- jQuery 2.1.4 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script>
	//@RestController의 경우 객체를 JSON방식으로 전달하기 때문에 jQuery를 이용하여 호출시 getJSON() 사용
		var bno = 10;//-------------------------------------------------------------------------------------
		getPageList(1);
		function getAllList() {//전체 목록에 대한 함수 처리
			$.getJSON("/replies/all/" + bno, function(data) {
				//console.log(data.length);
				//전체 댓글 목록 출력: 특정한 댓글을 선택하면 수정 삭제 가능한 화면(MOD버튼)
				var str = "";
				$(data).each(function() {
				str += "<li data-rno='"+this.rno+"' class='replyLi'>" + this.rno	+ ":" + this.replytext 	+ "<button>MOD</button></li>";
				});
				$("#replies").html(str);
			});
		}
//댓글 등록 버튼----------------------------------------------------------------
		$("#replyAddBtn").on("click", function() {
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
//jQuery를 이용하여 $.ajax()를 통해 서버를 호출, 전송 데이터는 JSON으로 구성된 문자열을 사용하고, 전송받은 결과는 단순 문자열
//댓글 등록후 전체 댓글 목록의 갱신
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {	"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("등록 되었습니다.");
						getAllList();
					}
				}
			});
		});
//"MOD" 항목을 클릭했을때 댓글의 번호와 내용이 보이게(화면 중앙):------------------------------
		$("#replies").on("click", ".replyLi button", function() {
			var reply = $(this).parent();
			var rno = reply.attr("data-rno");
			var replytext = reply.text();
			$(".modal-title").html(rno);
			$("#replytext").val(replytext);
			$("#modDiv").show("slow");
		});
//화면의 "DELETE"버튼을 누르면 삭제-------------------------------------------------
		$("#replyDelBtn").on("click", function() {
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
//"MODIFY" 수정: 수정되는 게시물의 번호는 URI에 추가해서 전송,PUT, 수정돼야하는 데이터는 JSON으로 구성해서 전송		
		$("#replyModBtn").on("click",function(){
			  var rno = $(".modal-title").html();
			  var replytext = $("#replytext").val();
			  $.ajax({
					type:'put',
					url:'/replies/'+rno,
					headers: { 
					      "Content-Type": "application/json",
					      "X-HTTP-Method-Override": "PUT" },
					data:JSON.stringify({replytext:replytext}), 
					dataType:'text', 
					success:function(result){
						console.log("result: " + result);
						if(result == 'SUCCESS'){
							alert("수정 되었습니다.");
							 $("#modDiv").hide("slow");
							//getAllList();
							 getPageList(replyPage);//아래(419)
						}
				}});
		});		
//댓글의 페이징 처리 함수: "/replies/게시물번호/페이지번호"-------------------------------------	
//결과 데이터는 댓글 목록에 해당하는 list data & 페이지 구성에 필요한 pageMaker 데이터로 구성된다.
		function getPageList(page){
		  $.getJSON("/replies/"+bno+"/"+page , function(data){
			  console.log(data.list.length);
			  var str ="";
			  $(data.list).each(function(){
				  str+= "<li data-rno='"+this.rno+"' class='replyLi'>"+this.rno+":"+ this.replytext+"<button>MOD</button></li>";
			  });
			  $("#replies").html(str);
			  printPaging(data.pageMaker);//아래 호출
		  });
	  }		
//JavaScript객체인 pageMarker를 이용해서 화면에 페이지 번호를 출력 함수----------------------------	
		function printPaging(pageMaker){			
			var str = "";			
			if(pageMaker.prev){
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			}
			
			for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){				
					var strClass= pageMaker.cri.page == i?'class=active':'';
				  str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
			}
			
			if(pageMaker.next){
				str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
			}
			$('.pagination').html(str);				
		}
//페이지번호 이벤트 처리----------------------------------------------------------------		
		var replyPage = 1;
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();//a href 태그의 기본 동작인 페이지 전환을 막는 역할,화면의 이동을 막은후 현재 클릭된 페이지의 번호를 얻어내고, 이 번호로 getPageList()를 호출
			replyPage = $(this).attr("href");//클릭되는 페이지 번호
			getPageList(replyPage);
		});
	</script>
</body>
</html>

