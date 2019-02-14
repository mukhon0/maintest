<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

<form method="post" action="loginAf.jsp">

<!-- <div style="padding: 100px 0 0 250px;"> -->
<div style="padding: 200px 0px 0 400px;">
<div id="login-box">

<h2>Login Page</h2>
홍길동 홈페이지에 오신 것을 환영합니다 
<br>
<br>

<div id="login-box-name" style="margin-top:20px;">User Id:</div>
<div id="login-box-field" style="margin-top:20px;">
<input name="id" class="form-login" title="Username" size="30" maxlength="50" />
</div>
<div id="login-box-name">Password:</div>
<div id="login-box-field">
<input name="pwd" type="password" class="form-login" title="Password" value="" size="30" maxlength="48" />
</div>
<br>

<span class="login-box-options">
New User?  <a href="regi.jsp" style="margin-left:30px;">Register Here</a>
</span>
<br/>
<br/>
<input style="margin-left:100px;" type="submit" value="Login" />
</div>
</div>

</form>
</html>