package util;

public class BoardPage {

	/*
	totalCount : 전체 게시물의 개수
	pageSize : 한 페이지에 출력할 게시물의 개수
	blockPage : 한 블럭당 출력할 페이지 번호의 개수
	pageNum : 현재 진입한 목록의 페이지 번호
	reqUrl : 현재 목록을 실행한 JSP파일의 경로 혹은 요청명
	*/
	public static String pagingStr(int totalCount, int pageSize, int blockPage, 
							int pageNum, String reqUrl) {

		String pagingStr = "";
		
		//전체 페이지수
		int totalPages = (int)(Math.ceil(((double)totalCount / pageSize)));
		
		//현재 블럭의 첫번째 페이지 번호
		int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
		
		//이전블럭으로 바로가기 링크. (첫번째 블록일때는 나올수 없게 설정)
		if(pageTemp !=1) {
			pagingStr += "<a href='" + reqUrl + "&pageNum=1'>[첫페이지]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "&pageNum=" + (pageTemp - 1)
						+ "'>[이전블록]</a>";
		}
		
		//각 페이지로 바로가기 링크 생성(blockPage수 만큼)
		int blockCount = 1;		
		while(blockCount <= blockPage && pageTemp <= totalPages) {
			//현재 페이지에는 링크를 걸지 않음(<a>태그를 안씌움)
			if(pageTemp == pageNum) {
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			}
			else {
				pagingStr += "&nbsp;<a href='" + reqUrl + "&pageNum=" + pageTemp
							+ "'>" + pageTemp + "</a>&nbsp;";
			}
			pageTemp++;
			blockCount++;
		}
		
		//다음 블럭으로 바로가기 링크(마지막 블록일때는 나오지 않게 설정)
		if(pageTemp <= totalPages) {
			pagingStr += "<a href='" + reqUrl + "&pageNum=" + pageTemp + "'>[다음블록]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "&pageNum=" 
						+ totalPages + "'>[마지막페이지]</a>";
		}
		return pagingStr;
	}	
}
 