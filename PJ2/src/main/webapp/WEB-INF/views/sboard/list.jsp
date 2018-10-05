<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page session="false" %>

<%@include file="../include/header.jsp" %>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body">
				<button id='newBtn'>공지등록</button>
				<select name="searchType" style="display:none; position: absolute; right: 230px;">
						<option value="tcw" <c:out value="${cri.searchType eq 'tcw' ? 'selected':'' }"  />>전체</option>
						<option value="t" <c:out value="${cri.searchType eq 't' ? 'selected':'' }"  />>제목</option>
						<option value="c" <c:out value="${cri.searchType eq 'c' ? 'selected':'' }"  />>내용</option>
						<option value="tc" <c:out value="${cri.searchType eq 'tc' ? 'selected':'' }"  />>제목 + 내용</option>
							
					</select>
				<input type="text" name="keyword" id="keywordInput" value='${cri.keyword }'style="position: absolute; right: 60px;">
				<button id='searchBtn' style="position: absolute; right: 10px;">검색</button>			
				</div>
			
				<div class="box">
					<div class="body-box">
<table class="table table-bordered">
	<tr>
	  <th style="width:60px; text-align:center">번호</th>
	  <th style="text-align:center">제목</th>
	  <th style="width: 200px; text-align:center">작성일</th>
	  <th style="width: 100px; text-align:center">조회수</th>
	</tr>
	<c:forEach var="boardVO" items="${list }">
	<tr>
	  <td style="text-align:center">${boardVO.bno }</td>
	  <td><a href="/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno }">${boardVO.title }<strong>[${boardVO.replycnt }]</strong></a></td>
	  <td style="text-align:center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
	  <td style="text-align:center"><span class="badge bg-blue">${boardVO.viewcnt }</span> </td>
	</tr>
	</c:forEach>
</table>				
					</div>
				</div>
				<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a></li>
							</c:if>
							
							<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=active':'' }" />>
								    <a href="list${pageMaker.makeSearch(idx) }">${idx }</a>
								</li>
							</c:forEach>							
							
							<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								<li><a href="list${pageMaker.makeSearch(pageMaker.endPage+1) }">&raquo;</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
	var result= '${msg}';
	if(result == "regSUCCESS"){
		alert("공지사항이 등록 되었습니다.")
	}else if(result == "modSUCCESS"){
		alert("공지사항이 수정 되었습니다.")
	}else if(result == "delSUCCESS"){
		alert("공지사항이 삭제 되었습니다.")
	}
</script>
<script>
	$(document).ready(function() {
		$('#searchBtn').on("click", function(event) {
			self.location = "list"+'${pageMaker.makeQuery(1)}'+"&searchType="+$("select option:selected").val()+"&keyword="+$('#keywordInput').val();
		});
		
		$('#newBtn').on("click", function(evt) {
			self.location="register"
		});	
	});
</script>

<%@include file="../include/footer.jsp" %>









    