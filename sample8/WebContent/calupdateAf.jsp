<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dao.iCalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
%>    
    
<%!
public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

String title = request.getParameter("title");
String content = request.getParameter("content");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String hour = request.getParameter("hour");
String min = request.getParameter("min");

String rdate = year + two(month) + two(day) + two(hour) + two(min);


iCalendarDao dao = CalendarDao.getInstance();

CalendarDto dto = new CalendarDto(seq, title, content, rdate);

boolean isS = dao.update(dto);

if(isS){
%>
	<script type="text/javascript">
	alert("성공적으로 일정을 수정하였습니다");
	location.href="calendar.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("일정이 수정되지 않았습니다");
	location.href="calendar.jsp";
	</script>
<%
}
%>
</body>
</html>