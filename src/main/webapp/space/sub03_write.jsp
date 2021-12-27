<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 글쓰기 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);
%>
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
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
				<div>
<form name="writeFrm" method="post" action="writeProcessF.jsp"
	onsubmit="return validateForm(this);">
<input type="hidden" name="boardName" value="<%=boardName%>"/>
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		
		<td>
			<input type="text" class="form-control" 
				style="width:100px;" value="<%= session.getAttribute("UserId")%>"/>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" 
				style="width:400px;" value="<%= session.getAttribute("UserMail")%>"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" value="<%= session.getAttribute("UserPwd")%>"/>
		</td>
	</tr>  -->
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" name="title" class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content" class="form-control"></textarea>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" />
		</td>
	</tr> -->
</tbody>
</table>
<div class="row text-center" style="">
	<div class="container mt-3">
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='sub03.jsp?boardName=<%=boardName%>';">리스트보기</button>
	<div class="container mt-3">
</div>
</form>
				</div>
			</div>
		</div>
	
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
