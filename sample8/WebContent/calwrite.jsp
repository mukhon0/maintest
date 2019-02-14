<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calwrite.jspe</title>
</head>
<body>

<h3>일정 쓰기</h3>

<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

MemberDto user = (MemberDto)session.getAttribute("login");

Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);
int tmin = cal.get(Calendar.MINUTE);
%>

<div align="center">

<form action="calwriteAf.jsp" method="post">

<table border="1">
<col width="200"><col width="500">

<tr>
	<td>아이디</td>
	<td>
		<%=user.getId() %>
		<input type="hidden" name="id" value="<%=user.getId() %>">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" size="60" name="title">
	</td>
</tr>

<tr>
	<td>일정</td>
	<td>
		<select name="year">
		<%	
			for(int i = tyear - 5; i < tyear + 6; i++){
				%>	
				<option <%=year.equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>년	
			
		<select name="month">
		<%	
			for(int i = 1; i <= 12; i++){
				%>	
				<option <%=month.equals(i+"")?"selected='selected'":"" %>
					value="<%=i %>"><%=i %></option>				
				<%
			}		
		%>
		</select>월
				
		<select name="day" id="day">
		<%	
			for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH) ; i++){
				%>	
				<option <%=day.equals(i+"")?"selected='selected'":"" %>
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
		<textarea rows="20" cols="60" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="일정쓰기">
	</td>
</tr>



</table>

</form>

</div>

<script type="text/javascript">

if(month == 2){
	
}
else if(month % 2 == 0){
	
}
else if(month % 2 == 0){
	
}

month
var day = document.getElementById("day");
alert(day);

</script>


</body>
</html>






