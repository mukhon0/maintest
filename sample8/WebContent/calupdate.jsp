<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dao.iCalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsdetail.jsp</title>


</head>
<body>


<h1>일정 수정 하기</h1>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

iCalendarDao dao = CalendarDao.getInstance();

CalendarDto dto = dao.getCal(seq);

Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);
int tmin = cal.get(Calendar.MINUTE);

%> 
<form action="calupdateAf.jsp">

<div class="center">
<input type="hidden" name="seq" value="<%= dto.getSeq() %>">
<table border="2">
<col width="200"><col width="500">

<tr>
	<td>작성자</td>
	<td>
		<%=dto.getId() %>
	</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<input type="text" name ="title" value="<%=dto.getTitle() %>">
	</td>
</tr>
<tr>
	<td>작성일</td>
	<td>
		<%=dto.getWdate() %>
	</td>
</tr>
<tr>
	<td>약속일</td>
	<td>
		<select name="year">
		<%	
			for(int i = tyear - 5; i < tyear + 6; i++){
				%>	
				<option <%=dto.getRdate().substring(0, 4).equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>년	
			
		<select name="month">
		<%	
			for(int i = 1; i <= 12; i++){
				%>	
				<option <%=dto.getRdate().substring(4, 6).equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>월
				
		<select name="day">
		<%	
			for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
				%>	
				<option <%=dto.getRdate().substring(6, 8).equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>일
		
		<select name="hour">
		<%	
			for(int i = 0; i < 24; i++){
				%>	
				<option <%=(thour + "").equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>시
		
		<select name="min">
		<%	
			for(int i = 0; i < 60; i++){
				%>	
				<option <%=(tmin + "").equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>분	
	</td>
</tr>
<tr>
	<td>내용</td>
<td>
<textarea rows="10" cols="50" 
name="content"><%=dto.getContent() %>	
</textarea>
	</td>
</tr>
</table>


<input type="submit" value="수정">


</div>

</form>


 

</body>
</html>











