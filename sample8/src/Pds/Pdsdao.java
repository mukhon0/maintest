package Pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class Pdsdao implements iPdsDao {

	private static Pdsdao pds = new Pdsdao();
	
	public Pdsdao() {
	}
	
	public static Pdsdao getinstance() {
		return pds;
	}

	@Override
	public List<PdsDto> getPdsList() {

		String sql =  " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
					+ " READCOUNT, DOWNCOUNT, REGDATE "
					+ " FROM PDS "
					+ " ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("Pds 연결성공");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("Pds sql 연결");
			
			rs = psmt.executeQuery();
			System.out.println("Pds 쿼리 초기화");
			
			while(rs.next()) {
				
				int i = 1;
				
				PdsDto dto = new PdsDto(rs.getInt(i++),	// seq, 
										rs.getString(i++),	// id, 
										rs.getString(i++),	// title, 
										rs.getString(i++),	// content, 
										rs.getString(i++),	// filename, 
										rs.getInt(i++),	// readcount, 
										rs.getInt(i++),	// downcount, 
										rs.getString(i++)	// regdate)
						);
				list.add(dto);
			}
			System.out.println("Pds list 추가 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
		return list;
	}

	@Override
	public boolean writePds(PdsDto pds) {
		
		String sql = " INSERT INTO PDS(SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE) "
			   + " VALUES(SEQ_PDS.NEXTVAL, ?, ?, ?, ?, 0, 0, SYSDATE) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("Pds write 연결 1");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			System.out.println("Pds write 연결 2");
			
			count = psmt.executeUpdate();
			System.out.println("Pds write 연결 3");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Pds write 연결 4");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
		
		
		return count>0?true:false;
	}

	@Override
	public PdsDto detailPds(int seq) {
		
		String sql = " SELECT * FROM PDS WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsDto pds = null;
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);			
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
				pds = new PdsDto(rs.getInt(1),		// seq, 
								 rs.getString(2),	// id, 
								 rs.getString(3),	// title, 
								 rs.getString(4),
								 rs.getString(5),	// filename, 
								 rs.getInt(6),		// readcount, 
								 rs.getInt(7),		// downcount, 
								 rs.getString(8)	// regdate
								 );		
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return pds;
	}

	@Override
	public void readCount(int seq) {

		String sql = " UPDATE PDS SET " + " READCOUNT=READCOUNT+1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		
	}

	@Override
	public void downCount(int seq) {

		String sql = " UPDATE PDS SET DOWNCOUNT=DOWNCOUNT+1 WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
	}
	
}
