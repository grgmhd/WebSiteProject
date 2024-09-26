<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function validateForm(form) {
	if(!form.id.value){ 
		alert("아이디를 입력하세요.");
		form.id.focus();
		return false;
	}
	if(form.pass.value ==""){
		alert("패스워드를 입력하세요.");
		form.pass.focus();
		return false;
	}
}
</script>

 <body>
 <div class="container-fluid">
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				<form action="../member/login.do" method="post" name="loginFrm" onsubmit="return validateForm(this);">
				<%
				if(request.getAttribute("LoginErrMsg")!=null){
					JSFunction.alertBack("아이디 혹은 비밀번호가 일치하지 않습니다.", out);
				} 
				if (session.getAttribute("UserId") == null){
				%>
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="id" value="" class="login_input01" tabindex='1'/></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="pass" value="" class="login_input01" tabindex='2'/></li>
					</ul>
					<a href=""><input type="image" src="../images/login_btn.gif" class="login_btn01" tabindex='3'/></a>
				</div>
				<p style="text-align:center; margin-bottom:50px;"><a href="modify.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
				<%
				} else {
				%>
				<div class="login_box01">
					
					<span style="font-size: 18px; font-weight: bold;"><%= session.getAttribute("UserName") %></span> 님, 반갑습니다.<br>
					<br><br>
					<button type="button" class="btn btn-warning" onclick="location.href='modify.jsp';">회원정보수정</button>
					<button type="button" class="btn btn-danger" onclick="location.href='logout.jsp';">로그아웃</button>
				</div>
				<%
				}
				%>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
</div>
</body>
</html>
