package Servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.BoardPage;

@WebServlet("/community/List.do")
public class ListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		
		//DB 연결
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		
		Map<String, Object> map = new HashMap<String, Object>();
		 
		map.put("boardName", boardName);	
		
		//검색구역 & 검색어 파라미터 받기
		String searchField = req.getParameter("keyField");
		String searchWord = req.getParameter("keyString");
		
		//검색어를 입력했을때 파라미터 저장
		if(searchWord != null) {
			map.put("keyField", searchField);
			map.put("keyString", searchWord);
		}
		
		//게시물의 개수를 카운트
		int totalCount = dao.selectCount(map);
		
		ServletContext application = getServletContext();
		
		//페이지당 게시물 수 & 블록 당 페이지 수
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		//기본 페이지 번호
		int pageNum = 1;
		//파라미터로 받아온 페이지 번호
		String pageTemp = req.getParameter("pageNum");
		//파라미터 값 검증 후 페이지 번호 변경
		if(pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		
		//페이지 내 첫번째 게시물의 번호
		int start = (pageNum -1) * pageSize + 1;
		//페이지 내 마지막 게시물의 번호
		int end = pageNum * pageSize;
		
		map.put("start", start);
		map.put("end", end);
		
		//현재 페이지에 출력할 게시물을 DB에서 가져온다.
		List<ProjectBoardDTO> boardLists = dao.selectList(map);
		dao.close();
		
		
		//페이지 번호 생성
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, 
				"../community/List.do?boardName="+boardName);
		
		map.put("pagingImg", pagingImg); //페이지 번호
		map.put("totalCount", totalCount); //전체 게시물의 개수
		map.put("pageSize", pageSize); //페이지 당 게시물 수
		map.put("pageNum", pageNum); //페이지 번호
		
		//request 영역에 저장
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.setAttribute("bCRUD", "list");
		req.setAttribute("boardName", boardName);
		
		//List 페이지로 포워드
		if(boardName.equals("emp"))
			req.getRequestDispatcher("sub01.jsp").forward(req, resp);
		else if(boardName.equals("prt"))
			req.getRequestDispatcher("sub02.jsp").forward(req, resp);	
	}
}
















