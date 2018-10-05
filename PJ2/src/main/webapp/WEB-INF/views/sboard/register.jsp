<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<style>
.fileDrop {
	width: 80%;
	height: 100px;
	border: 1px dotted gray;
	background-color: lightslategrey;
	margin: auto;
}
</style>

<section class="content">
	<div class="col-lg-12">
		<form role="form" name="writeForm" method="post">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">게시글 작성</h3>
				</div>
				<div class="box-body">
					<div class="form-group">
						<label for="title">제목</label> <input class="form-control"
							id="title" name="title" placeholder="제목을 입력해주세요">
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control" id="content" name="content"
							rows="17" placeholder="내용을 입력해주세요" style="resize: none;"></textarea>
					</div>
				</div>
				<div class="box-footer">
					<button type="button" class="btn btn-primary" id="goListBtn"
						onclick="golist(); return false;">
						<i class="fa fa-list"></i> 목록
					</button>
					<div class="pull-right">
						<button type="reset" class="btn btn-warning"
							onclick="return confirm('작성된 글을 초기화 하시겠습니까?'); return false;">
							<i class="fa fa-reply"></i> 초기화
						</button>
						<button type="submit" class="btn btn-success" id="save"
							onclick="writeCheck(this); return false;">
							<i class="fa fa-save"></i> 저장
						</button>
					</div>
				</div>
			</div>
		</form>
	</div>

</section>

<script type="text/javascript">
	function golist() {
		if (confirm("목록으로 돌아가시겠습니까??") == true) { //확인
			location.href = "/sboard/list"
		} else { //취소
			return;
		}
	}
</script>

<script>
	// 자바 스크립트 시작 
	function writeCheck(obj) {
		var obj = document.writeForm;

		if (!obj.title.value) // form 에 있는 name 값이 없을 때 
		{
			alert("제목을 적어주세요");
			obj.title.value = "";
			obj.title.focus();
			return;
		}
		if (!obj.content.value) {
			alert("내용을 적어주세요");
			obj.content.value = "";
			obj.content.focus();
			return;
		}
		if (!obj.writer.value) {
			alert("작성자를 적어주세요");
			obj.writer.value = "";
			obj.writer.focus();
			return;
		}
		form.submit();
	}
</script>

<%@include file="../include/footer.jsp"%>








