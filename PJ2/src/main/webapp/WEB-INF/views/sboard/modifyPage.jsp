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
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">수정 하기</h3>
				</div>
				<form role="form" action="modifyPage" method="post">
					<input type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">

					<div class="box-body">
						<div class="form-group">
							<label for="title">번호</label> <input name='bno'
								class="form-control" value="${boardVO.bno}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="title">제목</label> <input type="text" name='title'
								class="form-control" value="${boardVO.title}">
						</div>
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" name="content" rows="15"
								style="resize: none;">${boardVO.content}</textarea>
						</div>
					</div>

					<div class="box-footer">
						<button type="button" class="btn btn-primary listBtn">
							<i class="fa fa-list"></i> 목록
						</button>
						<div class="pull-right">
							<button type="button" class="btn btn-warning cancelBtn">
								<i class="fa fa-trash"></i> 취소
							</button>
							<button type="submit" class="btn btn-success modBtn">
								<i class="fa fa-save"></i> 수정하기
							</button>

						</div>
					</div>
				</form>




				<script>
					$(document).ready(function() {

						var formObj = $("form[role='form']");
						console.log(formObj);

						$(".modBtn").on("click", function() {
							var modcon2 = confirm('수정하시겠습니까?');
							if (modcon2 == true) {
								formObj.submit();
							} else {
								return;
							}
						});

						$(".cancelBtn").on("click", function() {
							var cancon = confirm('취소하시겠습니까?');
							if (cancon == true) {
								history.go(-1);
							} else {
								return;
							}
						});

						$(".listBtn").on("click", function() {
							var listcon2 = confirm('목록으로 돌아 가시겠습니까?');
							if (listcon2 == true) {
								self.location = "/sboard/list"
							} else {
								return;
							}
						});

					});
				</script>


				<%@include file="../include/footer.jsp"%>