<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDto user = (MemberDto)session.getAttribute("login");
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 
	주의점 : 1. 같은 파일명으로 사용시 주의 필요! (다른사용자의 같은파일이름이 있다면 파일이 덮어쓰기 된다.)
				해결) 파일명을 DATE() 클래스를 이용하여 시간으로 파일을 저장하고 불러내고, 
			 		 다운로드시에 저장된 파일명을 호출하여 가져온다.
		  
		   2. 한글파일명은 문자가 깨짐
		   
		  		ex) bbslist.jsp -> 1232123213.jsp   upload
		  		
		  		DB의 column에서 취득 후					download
		  		1232123213.jsp  -> bbslist.jsp
 --%>
 
<h2>자료 올리기</h2>

<div align="center">
<%-- multipart : byte, String 다 받아주는 방식 --%> 
<%-- 파일보낼땐 String byte 둘다 보내기때문에 보내지지 않는다. --%>
<form action="pdsupload.jsp" method="post" enctype="multipart/form-data">

<table border="1" bgcolor="white">
<col width="200"><col width="500">

<tr>
	<td>아이디</td>
	<td><%=user.getId() %>
		<input type="hidden" name="id" value="<%=user.getId() %>">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" size="50">
	</td>
</tr>

<tr>
	<td>파일업로드</td>
	<td>
		<%-- 이건 request.get ~ 으로 받아낼 수 없다. --%>
		<input type="file" name="fileload" style="width: 400px">
	</td>
</tr>

<tr>
	<td>내용</td>
	<td>
		<textarea rows="20" cols="50" name="content"></textarea>
	</td>
</tr>

<tr align="center">
	<td colspan="2">
		<input type="submit" value="올리기">
	</td>
</tr>

</table>

</form>
 </div>
 
 
 
</body>
</html>

