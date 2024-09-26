package connect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	//커넥션 풀을 사용한 연결
	public DBConnPool() {
		try {
			//Context 객체를 생성
			Context initCtx = new InitialContext();
		
			//생성한 객체를 통해 초기 Root 디렉토리를 획득
			Context ctx = (Context)initCtx.lookup("java:comp/env");
			//server.xml에 DB에 연결된 정보 획득
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle");
			//커넥션풀에 생성해 놓은 커넥션 객체 사용
			con = source.getConnection();
			// 정상적으로 연결되었다면 성공 메세지를 출력
			System.out.println("DB 커넥션 풀 연결 성공");
		}
		catch(Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
			e.printStackTrace();
		}
	}
	
	//객체를 커넥션 풀에 반납
	public void close() {
		try {
			if(rs !=null) rs.close();
			if(stmt !=null) stmt.close();
			if(psmt !=null) psmt.close();
			if(con !=null) con.close();
			
			System.out.println("DB커넥션 풀 자원 반납");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
