package menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBconnection {
	private static DBconnection dbcon;
	
	
	private DBconnection() {
		
	}
	
	public static DBconnection getInstance() {
		if(dbcon == null) {
			dbcon = new DBconnection();
		}
		return dbcon;
	}
	
	public Connection getConnection(String id, String pass) throws SQLException{
		
		Connection conn=null;
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			
		}catch(ClassNotFoundException ce) {
			ce.printStackTrace();
		}
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		conn=DriverManager.getConnection(url,id,pass);
		
		
		return conn;
	}
	
	public void dbClose(Connection con, PreparedStatement pstmt, ResultSet rs) throws SQLException {
		try {
			if(rs != null) {rs.close();}
			if(pstmt != null) {pstmt.close();}
			
		}finally {
			if(con != null) {con.close();}
		}
	}

	
}
