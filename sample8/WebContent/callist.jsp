<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dao.iCalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
%>

<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String s = year + two(month) + two(day);

iCalendarDao dao = CalendarDao.getInstance();

List<CalendarDto> list = dao.getdaylist(s);


%>

<table border="1">
<tr>
<th>일정명</th><th>작성일</th><th>약속일</th><th>내용</th>
</tr>
<% 
for(int i = 0; i < list.size(); i++){
%>
<tr>
<td><%=list.get(i).getTitle() %></td><td><%=list.get(i).getWdate() %></td>
<td><%=list.get(i).getRdate() %></td><td><%=list.get(i).getContent() %></td>
</tr>
<%
}
%>


</table>


</body>
</html>




