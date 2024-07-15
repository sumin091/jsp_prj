
package kr.co.sist.user.car;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class CarDAO {

	private static CarDAO cDAO;

	private CarDAO() {
		
	}

	public static CarDAO getInstance() {
		if (cDAO == null) {
			cDAO = new CarDAO();
		} // end if
		return cDAO;
	}

	
	public List<String> selectMaker (String country) throws SQLException{
	      List<String> list = new ArrayList<String>();
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      DbConnection db = DbConnection.getInstance();
	      try {
	         con =db.getConn("jdbc/dbcp");
	         StringBuilder selectBoard = new StringBuilder();
	         selectBoard.append("   select maker from car_country   ")
	               .append("   where country =? ");
	         
	         
	         pstmt = con.prepareStatement(selectBoard.toString());
	         
	         // 5. 바인드 변수에 값 설정
	         pstmt.setString(1, country);
	         
	         // 6. 쿼리문 수행 후 결과 얻기
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            list.add(rs.getString("maker"));
	         } // end while
	      }finally {
	         db.closeCon(rs, pstmt, con);
	      }
	      return list;
	   }//selectBoard

	
}// class
