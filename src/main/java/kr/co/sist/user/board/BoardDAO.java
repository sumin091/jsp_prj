
package kr.co.sist.user.board;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class BoardDAO {

	private static BoardDAO bDAO;
	private String[] columnNames;

	private BoardDAO() {
		columnNames = new String[] { "title", "content", "id" };
	}

	public static BoardDAO getInstance() {
		if (bDAO == null) {
			bDAO = new BoardDAO();
		} // end if
		return bDAO;
	}

	/*
	 * 총 레코드의 수
	 * 
	 * @param sVO
	 * 
	 * @return
	 * 
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO) throws SQLException {
		int totalCnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectCnt = new StringBuilder();
			selectCnt.append("select count(*) cnt from board ");

			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectCnt.append(" where ").append(columnNames[Integer.parseInt(sVO.getField())])
						.append(" like '%'||?||'%' ");
			} // end if
			pstmt = con.prepareStatement(selectCnt.toString());
			// 5.바인드변수에 값 설정
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
			}
			System.out.println(selectCnt);

			// 6.쿼리문 수행 후 결과얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCnt = rs.getInt("cnt");
			} // end if

		} finally {
			// 7.연결끊기
			db.closeCon(rs, pstmt, con);
		}
		return totalCnt;
	}

	public List<BoardVO> selectBoard(SearchVO sVO) throws SQLException {
		List<BoardVO> list = new ArrayList<BoardVO>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectBoard = new StringBuilder();
			selectBoard.append(" select NUM, TITLE, ID, CNT, rnum, input_date ")
					.append(" from (select NUM, TITLE, ID, CNT, input_date, ")
					.append(" row_number() over(order by input_date desc) rnum ").append(" from board ");

			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectBoard.append(" where instr(").append(columnNames[Integer.parseInt(sVO.getField())])
						.append(", ?) > 0"); /* .append(",?)>0"); */
			} // end if

			selectBoard.append(" ) where rnum between ? and ? ");

			pstmt = con.prepareStatement(selectBoard.toString());

			// 5.바인드변수에 값 설정
			int bindIndex = 0;
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if

			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());

			System.out.println(selectBoard);

			// 6.쿼리문 수행 후 결과얻기
			rs = pstmt.executeQuery();

			BoardVO bVO = null;
			while (rs.next()) {
				bVO = new BoardVO(rs.getInt("num"), rs.getInt("cnt"), rs.getString("title"), null, rs.getString("id"),
						rs.getDate("input_date"));
				list.add(bVO);
			}
		} finally {
			// 7.연결끊기
			db.closeCon(rs, pstmt, con);
		}

		return list;
	}

	public void insertBoard(BoardVO bVO) throws SQLException {

		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			String insertBoard = " insert into board(NUM, TITLE, content, id, CNT) values(seq_board.nextval,?,?,?,?) ";

			pstmt = con.prepareStatement(insertBoard);

			// 바인드 변수 값 설정
			pstmt.setString(1, bVO.getTitle());
			pstmt.setString(2, bVO.getContent());
			pstmt.setString(3, bVO.getId());
			pstmt.setInt(4, bVO.getCnt());

			pstmt.executeUpdate();

		} finally {
			// 7.연결끊기
			db.closeCon(null, pstmt, con);
		}

	}// insertBoard

	public BoardVO selectDetailBoard(int seq /* , String id */) throws SQLException {
		BoardVO bVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectBoard = new StringBuilder();
			selectBoard.append(" select TITLE, ID, content, CNT, input_date ")
			.append(" from board ")
			.append(" where num=? ");

			pstmt = con.prepareStatement(selectBoard.toString());

			// 5.바인드변수에 값 설정

			pstmt.setInt(1, seq);

			// 6.쿼리문 수행 후 결과얻기
			rs = pstmt.executeQuery();

			if (rs.next()) {
				StringBuilder content = new StringBuilder();
				String temp = "";

				// content는 clob 데이터 형이여서 별도의 Stream을 연결하여 검색
				BufferedReader br = null;
				try {
					br = new BufferedReader(rs.getClob("content").getCharacterStream());
					while ((temp = br.readLine()) != null) {
						content.append(temp).append("\n");
					}//end while
					br.close();
				} catch (IOException ie) {
					ie.printStackTrace();
				}//end catch

				bVO = new BoardVO(seq, rs.getInt("cnt"), rs.getString("title")
						,content.toString(),rs.getString("id"), rs.getDate("input_date"));
			}
		} finally {
			// 7.연결끊기
			db.closeCon(rs, pstmt, con);
		}

		return bVO;
	}//selectDetailBoard
	
	public int updateBoard(BoardVO bVO) throws SQLException {
		int cnt=0;
		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder updateBoard = new StringBuilder();
			updateBoard.append(" update board ")
			.append(" set title=?, content=?, cnt=? ")
			.append(" where num=? and id=? ");

			pstmt = con.prepareStatement(updateBoard.toString());

			// 바인드 변수 값 설정
			pstmt.setString(1, bVO.getTitle());
			pstmt.setString(2, bVO.getContent());
			pstmt.setInt(3, bVO.getCnt());
			pstmt.setInt(4, bVO.getNum());
			pstmt.setString(5, bVO.getId());
			
			//System.out.println(updateBoard);
			//System.out.println(bVO);
			cnt=pstmt.executeUpdate();

		} finally {
			// 7.연결끊기
			db.closeCon(null, pstmt, con);
		}
		return cnt;
	}// updateBoard
	
	public int deleteBoard(BoardVO bVO) throws SQLException {
		int cnt=0;
		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder deleteBoard = new StringBuilder();
			deleteBoard.append(" delete board ")
			.append(" where num=? and id=? ");

			pstmt = con.prepareStatement(deleteBoard.toString());

			// 바인드 변수 값 설정
			pstmt.setInt(1, bVO.getNum());
			pstmt.setString(2, bVO.getId());

			cnt=pstmt.executeUpdate();

		} finally {
			// 7.연결끊기
			db.closeCon(null, pstmt, con);
		}
		return cnt;
	}// deleteBoard
	
	public int updateCnt(int num) throws SQLException {
		int cnt=0;
		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection db = DbConnection.getInstance();

		try {
			// 1.JNDI 사용객체 생성
			// 2.DataSource 얻기
			// 3.Connection 얻기
			con = db.getConn("jdbc/dbcp");
			// 4.쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder updateCnt = new StringBuilder();
			updateCnt.append(" update board set cnt= cnt+1 ")
			.append(" where num=? ");

			pstmt = con.prepareStatement(updateCnt.toString());

			// 바인드 변수 값 설정
			pstmt.setInt(1, num);

			cnt=pstmt.executeUpdate();

		} finally {
			// 7.연결끊기
			db.closeCon(null, pstmt, con);
		}
		return cnt;
	}// updateBoard
}// class
