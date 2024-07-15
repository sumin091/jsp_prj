package menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

	private static MenuDAO menuDAO;
	
	private MenuDAO() {
		
	}
	
	public static MenuDAO getInstance() {
		if(menuDAO == null) {
			menuDAO = new MenuDAO();
		}
		return menuDAO;
	}
	
	public List<MenuVO> selectAll() throws SQLException{
		List<MenuVO> list= new ArrayList<MenuVO>();
		
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		DBconnection dbcon= DBconnection.getInstance();
		
		try {
			String id="scott";
			String pass="tiger";
			
			
			con=dbcon.getConnection(id, pass);
			
			String selectMenu=" select * from title_bar ";
			
			pstmt=con.prepareStatement(selectMenu);
			
			rs=pstmt.executeQuery();			
			
			while(rs.next()) {
				MenuVO menuVO= new MenuVO(rs.getString("title"),rs.getString("sub_title"));
				list.add(menuVO);
			}
			
		}finally {
			dbcon.dbClose(con, pstmt, rs);
		}
		return list;
	}
	
	public MenuVO selectOne(String title) throws SQLException {
		MenuVO menuVO=null;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		
		DBconnection dbcon= DBconnection.getInstance();
		
		try {
			String id="scott";
			String pass="tiger";
			
			
			con=dbcon.getConnection(id, pass);
			//String selectMenu=" select sub_title from title_bar where title=? ";
			
			StringBuilder sb= new StringBuilder();
			sb.append(" select sub_title from title_bar where title=? ");
			
			
			pstmt=con.prepareStatement(sb.toString());
			
			pstmt.setString(1, title);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				menuVO= new MenuVO(rs.getString("title"),rs.getString("sub_title"));
			}
			
		}finally {
			dbcon.dbClose(con, pstmt, rs);
		}
		return menuVO;
	}
	
	public int updateMenu(MenuVO menuVO) throws SQLException {
				
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result = 0;
		
		DBconnection dbcon= DBconnection.getInstance();
				
		try {
			String id="scott";
			String pass="tiger";
			
			con=dbcon.getConnection(id, pass);
			
			String updateMenu= " update title_bar set sub_title=? where title=? ";
			
			
			pstmt=con.prepareStatement(updateMenu);
			pstmt.setString(1, "title");
			pstmt.setString(2, "sub_title");
			
			result = pstmt.executeUpdate();
		}finally {
			dbcon.dbClose(con, pstmt, rs);
		}
		return result;
		
	}
	
	public void deleteMenu(String sub_title) throws SQLException {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DBconnection dbcon= DBconnection.getInstance();
		
		try {
			String id="soctt";
			String pass="tiger";
			
			con=dbcon.getConnection(id, pass);
			
			String deleteMenu=" delete from title_bar where sub_title=? ";
			
			pstmt=con.prepareStatement(deleteMenu);
			
			pstmt.setString(1, "sub_title");
			
			
			
		}finally {
			dbcon.dbClose(con, pstmt, null);
		}
	}
	

}
