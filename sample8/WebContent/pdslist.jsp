<%@page import="Pds.PdsDto"%>
<%@page import="java.util.List"%>
<%@page import="Pds.Pdsdao"%>
<%@page import="Pds.iPdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
iPdsDao dao = Pdsdao.getinstance();
List<PdsDto> list = dao.getPdsList();

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>자료실</h2>

<div align="center">

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
<% 
for(int i = 0; i < list.size(); i++){
	PdsDto pds = list.get(i);
	
	String bgcolor = "";
	if(i % 2 == 0){
		bgcolor= "#ddeebb";
	}else{
		bgcolor= "#ddddcc";
	}
	%>
	<tr bgcolor="<%=bgcolor%>" align="center" height="5">
		<td><%=i+1 %></td>
		<td><%=pds.getId() %></td>
		<td align="left">
			<a href="pdsdetail.jsp?seq=<%=pds.getSeq() %>">
				<%=pds.getTitle() %>
			</a>
		</td>
		<td>
		<!-- 서블렛을 사용. -->
			<input type="button" name="btnDown" value="파일"
				onclick="location.href='filedown?filename=<%=pds.getFilename() %>&seq=<%=pds.getSeq() %>'">
		</td>
		<td><%=pds.getReadcount() %></td>
		<td><%=pds.getDowncount() %></td>
		<td><%=pds.getRegdate() %></td>
	</tr>
	<%
}
%>
</table>

</div>

<a href="pdswrite.jsp">자료 올리기</a>












</body>
</html>