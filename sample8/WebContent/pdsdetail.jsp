<%@page import="Pds.PdsDto"%>
<%@page import="Pds.Pdsdao"%>
<%@page import="Pds.iPdsDao"%>
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
int seq = Integer.parseInt(seqq);

iPdsDao dao = Pdsdao.getinstance();
PdsDto dto = dao.detailPds(seq);

// 조회수
dao.readCount(seq);
%>

<table border="1">
<col width="50"><col width="100"><col width="400"><col width="50">
<col width="50"><col width="50"><col width="100">

<tr bgcolor="#00ff00" align="center">
	<td>번호</td>
	<td>작성자</td>
	<td>제목</td>
	<td>다운로드</td>
	<td>조회수</td>
	<td>다운로드수</td>
	<td>작성일</td>
</tr>
<tr>
	<td><%=dto.getSeq() %></td> 
	<td><%=dto.getId() %></td>
	<td><%=dto.getTitle() %></td>
	<td>
		<!-- 서블렛을 사용. -->
			<input type="button" name="btnDown" value="파일"
				onclick="location.href='filedown?filename=<%=dto.getFilename() %>& seq=<%=dto.getSeq() %>'">
	</td>
	<td><%=dto.getReadcount() %></td>
	<td><%=dto.getDowncount() %></td>
	<td><%=dto.getRegdate() %></td>
</tr>
</table>

<img src="./upload/<%=dto.getFilename() %>">


</body>
</html>