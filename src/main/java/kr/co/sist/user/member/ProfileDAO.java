package kr.co.sist.user.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConnection;

public class ProfileDAO {
	private static ProfileDAO pfDAO;

	private ProfileDAO() {

	}

	public static ProfileDAO getInstance() {
		if (pfDAO == null) {
			pfDAO = new ProfileDAO();
		}
		return pfDAO;
	}

	public ProfileVO selectProfile(String id) throws SQLException {
		ProfileVO pVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection db = DbConnection.getInstance();
		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 DataSource 얻기
			// 3.Connection얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기
			StringBuilder selectProfile = new StringBuilder();
			selectProfile.append(" select name, img ")
			.append(" from web_member ")
			.append(" where id=? ");

			pstmt = con.prepareStatement(selectProfile.toString());

			// 5.바인드변수에 값 설정

			pstmt.setString(1, id);

			// 6.쿼리문 수행후 결과 얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pVO = new ProfileVO();
				pVO.setId(id);
				pVO.setName(rs.getString("name"));// 암호화 => 복호화
				pVO.setImg(rs.getString("img"));// 암호화 => 복호화
			} // end if
		} finally {
			// 6.연결끊기
			db.closeCon(rs, pstmt, con);
		} // end finally
		return pVO;
	}//selectProfile
	
	public int updateImg(ProfileVO pVO) throws SQLException{
		int cnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		DbConnection db=DbConnection.getInstance();
		try {
			//1.JNDI 사용객체 생성
			//2.DataSource 얻기
			//3.Connection 얻기
			con=db.getConn("jdbc/dbcp");
			//4.쿼리문 생성객체 얻기
			pstmt=con.prepareStatement("update web_member set img=? where id=? ");
			//5.바인드 변수에 값 설정
			pstmt.setString(1, pVO.getImg());
			pstmt.setString(2, pVO.getId());
			//6.뭐리문 수행 후 결과 얻기
			cnt=pstmt.executeUpdate();
			
		}finally {
			//7.연결끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return cnt;
	}//
	
	
	public int updateInfo(ProfileVO pVO) throws SQLException{
		int cnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		DbConnection db=DbConnection.getInstance();
		try {
			//1.JNDI 사용객체 생성
			//2.DataSource 얻기
			//3.Connection 얻기
			con=db.getConn("jdbc/dbcp");
			//4.쿼리문 생성객체 얻기
			pstmt=con.prepareStatement("update web_member set name=? where id=? ");
			//5.바인드 변수에 값 설정
			pstmt.setString(1, pVO.getName());
			pstmt.setString(2, pVO.getId());
			//6.뭐리문 수행 후 결과 얻기
			cnt=pstmt.executeUpdate();
			
		}finally {
			//7.연결끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return cnt;
	}//updateInfo
}

