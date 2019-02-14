package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;
import dto.CalendarDto;

public class BbsDao implements iBbsDao {

	private static BbsDao bbs = new BbsDao();

	private BbsDao() {
	}

	public static BbsDao getInstance() {
		return bbs;
	}

	@Override
	public List<BbsDto> getBbsList(String searchWord, String choice) {

		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, " + " TITLE, CONTENT, WDATE, PARENT, " + " DEL, READCOUNT "
				+ " FROM BBS ";

		// 검색어
		String sqlWord = "";
		if (choice.equals("title")) {
			sqlWord = " WHERE TITLE LIKE '%" + searchWord.trim() + "%'";
		} else if (choice.equals("writer")) {
			sqlWord = " WHERE ID='" + searchWord.trim() + "'";
		} else if (choice.equals("content")) {

		}
		sql += sqlWord;

		sql += " ORDER BY REF DESC, STEP ASC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsList suc");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList suc");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList suc");

			while (rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), // seq,
						rs.getString(2), // id,
						rs.getInt(3), // ref,
						rs.getInt(4), // step,
						rs.getInt(5), // depth,
						rs.getString(6), // title,
						rs.getString(7), // content,
						rs.getString(8), // wdate,
						rs.getInt(9), // parent,
						rs.getInt(10), // del,
						rs.getInt(11) // readcount
				);
				list.add(dto);
			}
			System.out.println("4/6 getBbsList suc");

		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

	@Override
	public boolean writeBbs(BbsDto bbs) {
		String sql = " INSERT INTO BBS " + " (SEQ, ID, " + " REF, STEP, DEPTH, " + " TITLE, CONTENT, WDATE, PARENT, "
				+ " DEL, READCOUNT) " + " VALUES(SEQ_BBS.NEXTVAL, ?, " + " (SELECT NVL(MAX(REF), 0)+1 FROM BBS), " // ref
				+ " 0, 0, " // step, depth
				+ " ?, ?, SYSDATE, 0, " + " 0, 0) ";

		int count = 0;

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 writeBbs Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 writeBbs Success");

			psmt.setString(1, bbs.getId());
			psmt.setString(2, bbs.getTitle());
			psmt.setString(3, bbs.getContent());

			count = psmt.executeUpdate();
			System.out.println("3/6 writeBbs Success");

		} catch (Exception e) {
			System.out.println("writeBbs Fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	@Override
	public BbsDto getBbs(int seq) {

		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, " + " TITLE, CONTENT, WDATE, PARENT, " + " DEL, READCOUNT "
				+ " FROM BBS " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		BbsDto dto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbs Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getBbs Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbs Success");

			if (rs.next()) {

				dto = new BbsDto(rs.getInt(1), // seq,
						rs.getString(2), // id,
						rs.getInt(3), // ref,
						rs.getInt(4), // step,
						rs.getInt(5), // depth,
						rs.getString(6), // title,
						rs.getString(7), // content,
						rs.getString(8), // wdate,
						rs.getInt(9), // parent,
						rs.getInt(10), // del,
						rs.getInt(11) // readcount
				);
			}
			System.out.println("4/6 getBbs Success");

		} catch (SQLException e) {
			System.out.println("getBbs Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;
	}

	@Override
	public void readcount(int seq) {
		String sql = " UPDATE BBS SET " + " READCOUNT=READCOUNT+1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("2/6 S readcount");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S readcount");

			psmt.executeUpdate();
			System.out.println("4/6 S readcount");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
	}

	@Override
	public boolean answer(int seq, BbsDto bbs) {

		// update
		String sql1 = " UPDATE BBS " + " SET STEP=STEP+1 " + " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=?) "
				+ "		AND STEP > (SELECT STEP FROM BBS WHERE SEQ=?)";

		// insert
		String sql2 = " INSERT INTO BBS " + " (SEQ, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) " + " VALUES(SEQ_BBS.NEXTVAL, ?, "
				+ "		(SELECT REF FROM BBS WHERE SEQ=?),	" // REF
				+ "     (SELECT STEP FROM BBS WHERE SEQ=?) + 1," // STEP
				+ "     (SELECT DEPTH FROM BBS WHERE SEQ=?) + 1, " // DEPTH
				+ "		?, ?, SYSDATE, ?, 0, 0) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answer Suc");

			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 answer Suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 answer Suc");

			// 초기화
			psmt.clearParameters();

			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, bbs.getId());
			psmt.setInt(2, seq); // ref
			psmt.setInt(3, seq); // step
			psmt.setInt(4, seq); // depth
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			psmt.setInt(7, seq);
			System.out.println("4/6 answer Suc");

			count = psmt.executeUpdate();
			conn.commit();
			System.out.println("5/6 answer Suc");

		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			System.out.println("answer Fail");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
			System.out.println("6/6 answer Suc");
		}

		return count > 0 ? true : false;
	}

	@Override
	public boolean updateBbs(int seq, String title, String content) {
		String sql = " UPDATE BBS SET " + " TITLE=?, CONTENT=? " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("2/6 S updateBbs");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);

			System.out.println("3/6 S updateBbs");

			count = psmt.executeUpdate();
			System.out.println("4/6 S updateBbs");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
			System.out.println("5/6 S updateBbs");
		}

		return count > 0 ? true : false;
	}

	@Override
	public boolean deleteBbs(int seq) {
		String sql = " UPDATE BBS SET " + " DEL=1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("2/6 S deleteBbs");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S deleteBbs");

			count = psmt.executeUpdate();
			System.out.println("4/6 S deleteBbs");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	

}
