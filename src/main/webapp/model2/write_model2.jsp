<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
function validateForm(form) {
	if(form.title.value==""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if(form.content.value==""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>

<form name="writeFrm" method="post" enctype="multipart/form-data"
	action="../community/Write.do" onsubmit="return validateForm(this);">
	
	<input type="hidden" name="boardName" value="${param.boardName}">
	
	<table class="table" >
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th style="vertical-align:middle;">제목</th>
			<td><input type="text" name="title" style="width:50%;"></td>
		</tr>
		<tr>
			<th style="vertical-align:middle;">내용</th>
			<td>
				<textarea rows="10" name="content" style="width:90%;height: 150px"></textarea>
			</td>
		</tr>
		<tr>
			<th style="vertical-align:middle;">이메일</th>
			<td>
				<!-- <input type="text" style="width:400px;"> -->
			</td>
		</tr>
		<tr>
			<th style="vertical-align:middle;">첨부파일</th>
			<td>
				<input type="file" name="ofile">
			</td>
		</tr>
	</tbody>
	</table>
	
	<div style="text-align:right;">
		<!-- 각종 버튼 부분 -->
		<button type="submit">저장하기</button>
		<button type="button" onclick="location.href='../community/List.do?boardName=${param.boardName}';">목록보기</button>
	</div>
</form> 