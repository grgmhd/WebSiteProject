package Servlet;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.FileUtil;
import util.JSFunction;



@WebServlet("/community/Write.do")
public class WriteController extends HttpServlet {
	
	//글쓰기 페이지로 이동
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		req.setAttribute("bCRUD", "write");
		
		if(boardName.equals("emp"))
			req.getRequestDispatcher("/community/sub01.jsp?boardName=emp").forward(req, resp);
		else if(boardName.equals("prt"))
			req.getRequestDispatcher("/community/sub02.jsp?boardName=prt").forward(req, resp);	
	}
	
	//글쓰기 제어
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//디렉토리의 물리적 경로 획득
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		//최대 업로드 용량 설정
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		//파일 업로드 처리
		MultipartRequest mr 
			= FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		//업로드에 실패한 경우
		if(mr == null) {
			JSFunction.alertLocation(resp, "첨부 파일이 제한 용량을 초과합니다.", 
								"../community/Write.do");
			return;
		}
		
		//DTO에 저장
		ProjectBoardDTO dto = new ProjectBoardDTO();
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setBoardName(mr.getParameter("boardName"));
		/** 테스트용 더미데이터 입력 **/
		dto.setId("tester");
		dto.setEmail("test@java.com");
		
		//파일명 가져오기
		String fileName = mr.getFilesystemName("ofile");
		
		//서버에 저장한 파일이 있는 경우 파일명을 임시로 교체.
		if(fileName != null) {
			//임시 파일명 생성
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());		
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now + ext;		
		
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			
			//파일명 변경
			oldFile.renameTo(newFile);
			
			//파일명 저장
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
		}
		
		//새로운 게시물을 테이블에 저장
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		int result = dao.insertWrite(dto);
		dao.close();
		
		String boardName = mr.getParameter("boardName");
		if(result == 1) {
			resp.sendRedirect("../community/List.do?boardName="+boardName);
		}
		else {
			resp.sendRedirect("../community/Write.do?boardName="+boardName);
		}
	}
}














