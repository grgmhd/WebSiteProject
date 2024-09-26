<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 되돌리기 테스트 -->
<!-- 검색부분 -->
<div style="margin-bottom:20px;padding-right:50px; text-align: right;">
<form name="searchForm" action="../community/List.do">
		<input type="text" name="boardName" value="${param.boardName}">
		<select name="keyField">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="name">작성자</option>
		</select>
		<input type="text" name="keyString">
		<input type="submit" value="search">
</form>	
</div>
<div>
	<!-- 게시판리스트부분 -->
	<table class="table" border="1" width="90%">
		<colgroup>
			<col width="10%" style="text-align:center;">
			<col width="*" >
			<col width="15%" style="text-align:center;">
			<col width="15%" style="text-align:center;">
			<col width="10%" style="text-align:center;">
			<col width="10%" style="text-align:center;">
		</colgroup>
		
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>첨부</th>
		</tr>
		</thead>
		
		<tbody>
		<c:choose>
			<c:when test="${empty boardLists}"> <!-- 게시물이 없을때 -->
				<tr>
					<td colspan="6" align="center">
						등록된 게시물이 없습니다.
					</td>
				</tr>
			</c:when>
			<c:otherwise> <!-- 출력할 게시물이 있을때 -->
				<c:forEach items="${boardLists}" var="row" varStatus="loop">
		        <tr align="center">
		            <td>${row.idx}</td> 
		            <td align="left">	<!-- 제목 -->
		                <a href="../community/View.do?boardName=${row.boardName}&idx=${row.idx}">${row.title}</a>
		            </td>
		            <td align="center">${row.id}</td>    <!-- 작성자 -->    
		            <td align="center">${row.postdate}</td> <!-- 작성일 -->
		            <td align="center">${row.visitcount}</td> <!-- 조회수 -->
		            <td>	<!-- 첨부파일 -->
		            <c:if test="${not empty row.ofile}">
		            	첨부
		            </c:if>
		            </td>
		        </tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>	
	</table>
</div>
<div style="text-align:right;">
	<!-- 각종 버튼 부분 -->		
	<button type="button" onclick="location.href='../community/Write.do?boardName=${param.boardName}';">글쓰기</button>
</div>
<div>
	${map.pagingImg}
</div>

















