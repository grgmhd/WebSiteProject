<%@page import="member.ProjectMemberDTO"%>
<%@page import="member.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그인 폼에서 사용자가 입력한 아이디, 패스워드 받기
	String userId = request.getParameter("user_id");
	String userPwd = request.getParameter("user_pw");
	
	//application내장 객체를 통해 web.xml에 저장된 오라클 접속 정보를 읽어옴.
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	//JDBC를 통해 오라클 접속
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	//받아온 아이디, 패스워드를 매개변수로 getMemberDTO() 호출. 회원 인증 시도함.
	ProjectMemberDTO projectMemberDTO = dao.getMemberDTO(userId, userPwd);
	//자원해제
	dao.close();
	
	//회원정보가 존재한다면 DTO 객체에 회원정보를 저장한다.
	if (projectMemberDTO.getId() != null) {
		//회원인증(로그인)에 성공한 경우
		/*
			세션 영역에 아이디와 이름을 저장한다.
			세션 영역은 페이지를 이동하더라도 웹브라우저를 닫을 때까지는 
			영역이 공유되어 접근할 수 있다.
		*/
		session.setAttribute("UserId", projectMemberDTO.getId());
		session.setAttribute("UserName", projectMemberDTO.getName());
		//로그인 페이지로 단순 이동한다.
		response.sendRedirect("LoginMain.jsp");
	}
	else {
		//인증에 실패한 경우
		/*
			리퀘스트 영역은 실패 메세지를 저장한다.
			리퀘스트 영역은 하나의 요청이 완료될 때까지의 영역을 공유한다. 따라서
			포워드된 페이지까지 데이터를 공유할 수 있다.
		*/
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		//로그인 페이지로 포워드(페이지 전달)한다.
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
%>