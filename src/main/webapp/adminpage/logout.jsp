<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//방법1 : 직접 객체를 가져와서 remove한다.
session.removeAttribute("UserId");
session.removeAttribute("UserName");

//방법2 : invalidate() 함수를 사용하면 session영역에 내용이 다 지워진다.
session.invalidate();
JSFunction.alertLocation("로그아웃되었습니다.","login.jsp" , out);
%>