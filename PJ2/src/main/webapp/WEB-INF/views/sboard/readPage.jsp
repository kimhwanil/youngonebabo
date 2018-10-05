<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>

<script type="text/javascript" src="/resources/js/upload.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style type="text/css">
.popup {
	position: absolute;
}

.back {
	background-color: gray;
	opacity: 0.5;
	width: 100%;
	height: 300%;
	overflow: hidden;
	z-index: 1101;
}

.front {
	z-index: 1110;
	opacity: 1;
	boarder: 1px;
	margin: auto;
}

.show {
	position: relative;
	max-width: 1200px;
	max-height: 800px;
	overflow: auto;
}
</style>

<div class='popup back' style="display: none;"></div>
<div id="popup_front" class='popup front' style="display: none;">
	<img id="popup_img">
</div>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-primary">
				<form role="form" action="modifyPage" method="post">
					<input type='hidden' name='bno' value="${boardVO.bno}"> <input
						type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">
				</form>

				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">제 목 : ${boardVO.title}</h3>
					</div>

					<div class="box-body" style="height: 450px">
						${boardVO.content}</div>
					<div class="box-footer">
						<div class="user-block">
							 <span class="description"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }" /></span>
						</div>
					</div>
				</div>
			</div>

			<div class="box-footer">
				<button type="submit" class="btn btn-primary" id="goListBtn">
					<i class="fa fa-list"></i> 목록
				</button>
				<div class="pull-right">
					<button type="submit" class="btn btn-warning" id="modifyBtn">
						<i class="fa fa-edit"></i> 수정
					</button>
					<button type="submit" class="btn btn-danger" id="removeBtn">
						<i class="fa fa-trash"></i> 삭제
					</button>
				</div>

			</div>
		</div>
	</div>
</section>


<script>
	$(document).ready(function() {

		var formObj = $("form[role='form']");
		console.log(formObj);

		$("#modifyBtn").on("click", function() {

			var modcon = confirm('수정하시겠습니까?');
			if (modcon == true) {
				formObj.attr("action", "/sboard/modifyPage");
				formObj.attr("method", "get");
				formObj.submit();

			} else {
				return;
			}
		});

		$("#removeBtn").on("click", function() {

			var remcon = confirm('삭제하시겠습니까?');
			if (remcon == true) {
				formObj.attr("action", "/sboard/removePage");
				formObj.submit();
			} else {
				return;
			}
		});

		$("#goListBtn").on("click", function() {
			
			var listcon = confirm('목록으로 돌아 가시겠습니까?');
			if (listcon == true) {
			self.location = "/sboard/list"
			} else {
				return;
			}
		});

	});
</script>


<%@include file="../include/footer.jsp"%>
