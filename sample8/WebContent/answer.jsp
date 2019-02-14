<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dao.iBbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>answer.jspe</title>
</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

iBbsDao dao = BbsDao.getInstance();
BbsDto bbs = dao.getBbs(seq);

request.setAttribute("_bbs", bbs);
%>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;
%>

<h1>부모글</h1>

<table border="2">
<col width="200"><col width="500">

<tr>
	<td>작성자</td>
	<td>${_bbs.id }</td>
</tr>
<tr>
	<td>제목</td>
	<td>${_bbs.title }</td>
</tr>
<tr>
	<td>작성일</td>
	<td>${_bbs.wdate }</td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=bbs.getReadcount() %></td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="50"><%=bbs.getContent() %></textarea>
	</td>
</tr>
</table>

<br>
<hr>
<br>

<h1>댓글</h1>

<form action="answerAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
<table border="1">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" readonly="readonly" size="50" 
			value="<%=mem.getId() %>">
	</td>
</tr>	
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50">		
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="10" cols="50" name="content"></textarea>		
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="댓글 등록">
	</td>
</tr>
</table>
</form>

</body>
</html>










