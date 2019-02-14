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

<%
String seqq = request.getParameter("seq");
int seq = Integer.parseInt(seqq.trim());

iCalendarDao dao = CalendarDao.getInstance();
boolean isS = dao.delete(seq);
if(isS){
	%>
	<script type="text/javascript">
	alert("일정 삭제를 성공했습니다");
	location.href = 'calendar.jsp';
	</script>
	<%
}else{	
	%>
	<script type="text/javascript">
	alert("일정을 삭제하지 못했습니다");
	location.href = 'calendar.jsp';
	</script>
	<%
}	
%>
</body>
</html>