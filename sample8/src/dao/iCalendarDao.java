package dao;

import java.util.List;

import dto.CalendarDto;

public interface iCalendarDao {

	public List<CalendarDto> getCalendarList(String id, String yyyyMM);
	
	public boolean addCalendar(CalendarDto cal);
	
	public CalendarDto getCal(int seq);
	
	public boolean delete(int seq);
	
	public boolean update(CalendarDto cal);
	
	public List<CalendarDto> getdaylist(String date);
}
