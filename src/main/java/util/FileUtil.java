package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	//파일 업로드
	public static MultipartRequest uploadFile(HttpServletRequest req, String saveDirectory, 
						int maxPostSize) {
		try {
			/*
			파일 업로드 & 서버 저장. 객체의 참조값 반환
			req : request내장객체
			saveDirectory : 디렉토리의 물리적경로, 
			maxPostSize : 파일제한용량, 
			"UTF-8" : 인코딩방식)
			*/
			return new MultipartRequest(req, saveDirectory, maxPostSize, "UTF-8");
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//파일 검색 & 다운로드
	public static void download(HttpServletRequest req, HttpServletResponse resp,
			String directory, String sfileName, String ofileName) {
		
		//디렉토리의 물리적 경로 획득
		String sDirectory = req.getServletContext().getRealPath(directory);
		
		try {
			//서버에 저장된 파일을 찾아 객체 생성
			File file = new File(sDirectory, sfileName);
			//입력스트림 생성
			InputStream iStream = new FileInputStream(file);
			
			//웹브라우저에 따라 한글 파일명 인코딩을 다르게 처리(파일명 깨짐 방지)
			String client = req.getHeader("User-Agent");
			//인터넷 익스플로러가 아닌 경우
			if(client.indexOf("WOW64") == -1) { 
				ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
			}
			//인터넷 익스플로러 일때
			else {
				ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
			}
			
			//다운로드를 위한 response 헤더 설정
			resp.reset();
			resp.setContentType("application/octet-stream");
			resp.setHeader("Content-Disposition", 
							"attachment; filename=\"" + ofileName + "\"");
			
			//response 내장 객체를 통해 새로운 출력스트림을 생성
			OutputStream oStream = resp.getOutputStream();
			
			//출력 스트림에 파일 내용 출력(read => write)
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while((readBuffer = iStream.read(b)) > 0) {
				oStream.write(b, 0, readBuffer);
			}
			//입출력 스트림을 닫아준다.
			iStream.close();
			oStream.close();
		}
		catch(FileNotFoundException e) {
			System.out.println("파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
		catch(Exception e) {
			System.out.println("파일 다운로드 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//서버에 해당 파일이 존재하는지 확인하고 삭제 처리
	public static void deleteFile(HttpServletRequest req, 
			String directory, String filename) {
		//물리적 경로 획득
		String sDirectory = req.getServletContext().getRealPath(directory);
		
		File file = new File(sDirectory + File.separator + filename);
		if(file.exists()) {
		file.delete();	//존재한다면 삭제
		}
	}
}
