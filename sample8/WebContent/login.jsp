<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #8ac007;
	padding: 10px;
}
</style>

</head>
<body>

<%-- login view

	ID:			input	
	Password:	input
		쿠키에 저장
	회원가입:button, <a   
	로그인:button, <img  

회원관리 : 로그인, 회원가입
게시판: 게시글출력, detail, add, delete, update, answer
	  (일반, 답변&게시판) 	댓글&답글
일정관리: 달력, detail, add, delete, update
자료실: 파일업로드, 다운로드, add, delete, update

 --%>

<h1>Login</h1>
<p>환영합니다</p>

<div class="center">

<form action="loginAf.jsp" method="post">

<table border="1">
<tr>
	<td>아이디</td>
	<td>
		<input type="text" name="id" size="20">
	</td>
</tr>
<tr>
	<td>패스워드</td>
	<td>
		<input type="password" name="pwd" size="20">
	</td>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="로그인">
		<button type="button" onclick="location.href='regi.jsp'">회원가입</button>
	</td>
</tr>
</table>

</form>

</div> 

</body>
</html>


