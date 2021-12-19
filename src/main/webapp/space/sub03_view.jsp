<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 글쓰기 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
//게시물의 일련번호를 파라미터를 통해 받는다. 
String idx = request.getParameter("idx");   
//DB연결
projectboardDAO dao = new projectboardDAO(application);
//조회수 증가
dao.updateVisitCnt(idx);

//일련번호에 해당하는 게시물 조회
ProjectBoardDTO dto = dao.selectView(idx);
//자원해제
dao.close();                               
%>
<script>
function deletePost() {
	var confirmed = confirm("정말로 삭제하겠습니까?");
	if(confirmed){
		var form=document.writeFrm;
		form.method="post";//전송방식을 post로 설정
		form.action="DeleteProcess.jsp";//전송할 URL
		form.submit();//폼값 전송
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
<form name="writeFrm"> <!-- enctype="multipart/form-data" -->
<!-- 게시물의 일련번호: 삭제시 사용할 예정입니다. -->
<input type="hidden" name="idx" value="<%= idx %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%= dto.getName() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%= dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<%= dto.getEmail() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%= dto.getVisitcount() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%= dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%= dto.getContent().replace("\r\n", "<br/>") %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<%= dto.getOfile() %>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<%
      /*
      	로그인 되었고, 세션영역에 저장된 아이디가 해당 게시물을 작성한 아이디와
      	일치한다면 수정, 삭제 버튼을 보이게 처리한다. 
      	즉, 작성자 본인이 해당 게시물을 조회했을때 버튼이 보인다. 
      */
      if (session.getAttribute("UserId") != null
          && session.getAttribute("UserId").toString().equals(dto.getId())) {
      %>
	<button type="button" class="btn btn-primary"
	onclick="location.href='sub03_edit.jsp?idx=<%= dto.getIdx() %>';">
	수정하기</button>
	<button type="button" class="btn btn-success" onclick="deletePost();">삭제하기</button>	
	<%
     }
     %>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='sub03.jsp';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>