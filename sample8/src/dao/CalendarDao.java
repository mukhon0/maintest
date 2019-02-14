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

public class CalendarDao implements iCalendarDao {
	
	private static CalendarDao calDao = new CalendarDao();
	
	private CalendarDao() {
	}
	
	public static CalendarDao getInstance() {
		return calDao;
	}

	@Override
	public List<CalendarDto> getCalendarList(String id, String yyyyMM) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE " +
				" FROM (SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) ORDER BY RDATE ASC) RN, " +
					"	SEQ, ID, TITLE, CONTENT, RDATE, WDATE " +
				" FROM CALENDAR " +
				" WHERE ID=? AND SUBSTR(RDATE, 1, 6)=?) " +
				" WHERE RN BETWEEN 1 AND 5 "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getCalendarList suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			System.out.println("2/6 getCalendarList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList suc");
			
			while(rs.next()) {
				CalendarDto dto = new CalendarDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				
				list.add(dto);
			}
			System.out.println("4/6 getCalendarList suc");
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}		
		
		return list;
	}

	@Override
	public boolean addCalendar(CalendarDto cal) {
		
		String sql = " INSERT INTO CALENDAR(SEQ, ID, TITLE, CONTENT, RDATE, WDATE) "
				+ " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 addCalendar suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			System.out.println("2/6 addCalendar suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 addCalendar suc");
			
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}

	@Override
	public CalendarDto getCal(int seq) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE ,WDATE "
				   + " FROM CALENDAR "
				   + " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto cal = null;
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);			
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
				cal = new CalendarDto(rs.getInt(1),
									  rs.getString(2), 
								  	  rs.getString(3),
								  	  rs.getString(4),
								  	  rs.getString(5), 
								  	  rs.getString(6)
								  	  );
										
			}
			System.out.println("4/6 getBbs Success");			
			
		} catch (SQLException e) {
			System.out.println("getBbs Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
				
		return cal;
	}

	@Override
	public boolean delete(int seq) {
		
		String sql = " DELETE FROM CALENDAR "
				   + " WHERE seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);				
		}
		
		return count>0?true:false;
	}

	@Override
	public boolean update(CalendarDto dto) {
		
		String sql = " UPDATE CALENDAR SET TITLE=? , "
				   + " CONTENT=? , RDATE=? "
				   + " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null; 
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getRdate());
			psmt.setInt(4, dto.getSeq());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}

	@Override
	public List<CalendarDto> getdaylist(String date) {
		
		String sql = " SELECT * FROM CALENDAR WHERE SUBSTR(RDATE, 1, 8)=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, date.substring(0, 8).trim());
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				CalendarDto dto = new CalendarDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				
				list.add(dto);
			}
			System.out.println("4/6 getCalendarList suc");
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}		
		
		return list;
	}	
	

}






