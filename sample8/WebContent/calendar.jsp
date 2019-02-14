<%@page import="dao.CalendarDao"%>
<%@page import="dao.iCalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
// nvl 함수
public boolean nvl(String msg){
	return msg == null || msg.trim().equals("")?true:false;
}

// 날짜를 클릭하면, 그날의 일정이 모두 보이게하는 callist.jsp로 이동시키는 함수
public String callist(int year, int month, int day){
	String s = "";
	
	s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", 
							"callist.jsp", year, month, day);
	s += String.format("%2d", day); 
	s += "</a>"; 
	
	return s;
}

// 일정을 추가하기 위한 함수로 pen이미지를 클릭하면, calwrite.jsp로 이동
public String showPen(int year, int month, int day){
	String s = "";
	
	String image = "<img src='./image/pen.gif'>";	
	s = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", 
						"calwrite.jsp", year, month, day, image); 
	
	return s;	
}

// 1 ~ 9 -> 01 
public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}

// 각 날짜별로 테이블을 생성하는 함수
public String makeTable(int year, int month, int day, List<CalendarDto> list){
	
	String s = "";
	String dates = (year + "") + two(month + "") + two(day + "");	// 20190211
	
	s += "<table>";
	s += "<col width='98'>";
	
	for(CalendarDto dto : list){		
		if(dto.getRdate().substring(0, 8).equals(dates)){
			
			s += "<tr bgcolor='green'>";
			s += "<td>";
			
			s += "<a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";
			s += "<font style='font-size:8; color:black'>"; 
			s += dot3(dto.getTitle());
			s += "</font>";
			s += "</a>";
			
			s += "</td>";
			s += "</tr>";		
		}		
	}
	s += "</table>";
	
	return s;
}

// 제목이 너무 길면, (미팅약속이...) 으로 처리할 함수
public String dot3(String msg){
	String s = "";
	if(msg.length() >= 4){
		s = msg.substring(0, 4);
		s += "...";
	}else{
		s = msg.trim();
	}	
	return s;
}


%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>달력</h2>

<%
Calendar cal = Calendar.getInstance();
cal.set(Calendar.DATE, 1);		// 1일

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
if(nvl(syear) == false){	// 넘어온 파라메터가 있음
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH) + 1;
if(nvl(smonth) == false){
	month = Integer.parseInt(smonth);
}

if(month < 1){
	month = 12;
	year--;
}
if(month > 12){
	month = 1;
	year++;
}

cal.set(year, month - 1, 1);	// 연월일을 셋팅

// 요일
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

// <<
String pp = String.format("<a href='%s?year=%d&month=%d'>" + 
							"<img src='image/left.gif'></a>", 
							"calendar.jsp", year-1, month);

// <
String p = String.format("<a href='%s?year=%d&month=%d'>" + 
							"<img src='image/prec.gif'></a>", 
							"calendar.jsp", year, month-1);

// >
String n = String.format("<a href='%s?year=%d&month=%d'>" + 
							"<img src='image/next.gif'></a>", 
							"calendar.jsp", year, month+1);

// >>
String nn = String.format("<a href='%s?year=%d&month=%d'>" + 
							"<img src='image/last.gif'></a>", 
							"calendar.jsp", year+1, month);

MemberDto user = (MemberDto)session.getAttribute("login");

iCalendarDao dao = CalendarDao.getInstance();
List<CalendarDto> list 
	= dao.getCalendarList(user.getId(), year + two(month + ""));
%>

<div align="center">
<table border="1">
<col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100">

<tr height="100">
	<td colspan="7" align="center">
		<%=pp %>&nbsp;<%=p %>
		<font color="black" style="font-size: 50px">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
		</font>
		<%=n %>&nbsp;<%=nn %>
	</td>
</tr>

<tr height="100">
	<td align="center">일</td>
	<td align="center">월</td>
	<td align="center">화</td>
	<td align="center">수</td>
	<td align="center">목</td>
	<td align="center">금</td>
	<td align="center">토</td>
</tr>

<tr height="100" align="left" valign="top">
<%
// 위쪽 빈칸
for(int i = 1; i < dayOfWeek; i++){
	%>
	<td>&nbsp;</td>	
	<%
}

// 날짜
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1;i <= lastDay; i++){
	%>
	<td><%=callist(year, month, i) %>&nbsp;<%=showPen(year, month, i) %>
		<%=makeTable(year, month, i, list) %>		
	</td>	
	<%
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastDay){
		%>
		</tr>
		<tr height="100" align="left" valign="top">		
		<%
	}
	
}

// 밑칸
for(int i = 0;i < (7 - (dayOfWeek + lastDay - 1) % 7) % 7; i++){
	%>
	<td>&nbsp;</td>		
	<%
}
%>
</tr>


</table>
</div>


</body>
</html>









