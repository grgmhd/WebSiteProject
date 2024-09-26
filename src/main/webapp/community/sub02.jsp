<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 보호자 게시판; "모든" 회원 접근 & 수정 가능; 파일 첨부형 -->  
<%@ include file="../include/global_head.jsp" %>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub02_title.gif" alt="보호자 게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;보호자 게시판<p>
				</div>
				<div>				
					<!-- 컨텐츠 인클루드 -->
					<%-- <% out.print(request.getAttribute("bCRUD")); %> --%>
					<c:if test='${not empty bCRUD or bCRUD eq null}'>
					<c:choose>
						<c:when test="${bCRUD eq 'list'}">
							<%@ include file="../model2/list_model2.jsp" %>
						</c:when>
						<c:when test="${bCRUD eq 'view'}">
							<%@ include file="../model2/view_model2.jsp" %>
						</c:when>
						<c:when test="${bCRUD eq 'write'}">
							<%@ include file="../model2/write_model2.jsp" %>
						</c:when>
						<c:when test="${bCRUD eq 'edit'}">
							<%@ include file="../model2/edit_model2.jsp" %>
						</c:when>
					</c:choose>
					</c:if>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
