package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.FileUtil;
import util.JSFunction;

/* 뇌피셜(검증 필요) */
@WebServlet("/community/Delete.do")
public class DeleteController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		String idx = req.getParameter("idx");
		
		/* 아이디 검증 */
		
		//삭제할 게시물이 있는지 확인한 후 삭제
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		ProjectBoardDTO dto = dao.selectView(idx);
		int result = dao.deletePost(idx);
		dao.close();
		
		//게시물 삭제 성공했을때
		if(result == 1) {
			String saveFileName = dto.getSfile();
			FileUtil.deleteFile(req, "/Uploads", saveFileName);	
			
			JSFunction.alertLocation(resp, "해당 게시물이 삭제되었습니다.", "../community/List.do?boardName="+boardName);
			
			return;
		}
		else {
			JSFunction.alertBack(resp, "게시물을 삭제할 수 없습니다.");
		}
	}
}
