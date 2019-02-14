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


<h1>상세 일정 보기</h1>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

iCalendarDao dao = CalendarDao.getInstance();

CalendarDto cal = dao.getCal(seq);

%> 

<div class="center">

<table border="2">
<col width="200"><col width="500">

<tr>
	<td>작성자</td>
	<td>
		<%=cal.getId() %>
	</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<%=cal.getTitle() %>
	</td>
</tr>
<tr>
	<td>작성일</td>
	<td>
		<%=cal.getWdate() %>
	</td>
</tr>
<tr>
	<td>약속일</td>
	<td>
		<%=cal.getRdate()%>
	</td>
</tr>
<tr>
	<td>내용</td>
<td>
<textarea rows="10" cols="50" 
name="content"><%=cal.getContent() %>	
</textarea>
	</td>
</tr>
</table>


<button onclick="deletebbs('<%=cal.getSeq() %>')">삭제</button>
<button onclick="updatebbs('<%=cal.getSeq() %>')">수정</button>


</div>

<a href='bbslist.jsp'>글 목록</a>

<script type="text/javascript">
function deletebbs(seq) {
	location.href = "caldelete.jsp?seq=" + seq;
}
function updatebbs(seq) {
	location.href = "calupdate.jsp?seq=" + seq;
}
</script>


 

</body>
</html>











