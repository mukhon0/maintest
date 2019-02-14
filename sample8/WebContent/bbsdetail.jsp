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
<title>bbsdetail.jsp</title>

<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #8ac007;
	padding: 10px;
}
input {
	size: 50;
}
</style>

</head>
<body>

<%--
작성자
제목
작성일
조회수
정보		ref-step-depth
내용

버튼 목록, (삭제, 수정) ->  작성자 == login id 
댓글
 --%>

<h1>상세 글 보기</h1>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

iBbsDao dao = BbsDao.getInstance();
// 조회수를 증가
dao.readcount(seq);

BbsDto bbs = dao.getBbs(seq);
%> 

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>

<div class="center">

<table border="2">
<col width="200"><col width="500">

<tr>
	<td>작성자</td>
	<td>
		<%=bbs.getId() %>
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<%=bbs.getTitle() %>
	</td>
</tr>
<tr>
	<td>작성일</td>
	<td>
		<%=bbs.getWdate() %>
	</td>
</tr>
<tr>
	<td>조회수</td>
	<td>
		<%=bbs.getReadcount() %>
	</td>
</tr>
<tr>
	<td>정보</td>
	<td>
		<%=bbs.getRef() %>-<%=bbs.getStep() %>-<%=bbs.getDepth() %>
	</td>
</tr>
<tr>
	<td>내용</td>
<td>
<textarea rows="10" cols="50" 
name="content"><%=bbs.getContent() %>	
</textarea>
	</td>
</tr>
</table>

<form action="answer.jsp" method="post">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
<input type="submit" value="댓글">
</form>


<%
if(bbs.getId().equals(mem.getId())){
%>
<button onclick="deletebbs('<%=bbs.getSeq() %>')">삭제</button>
<button onclick="updatebbs('<%=bbs.getSeq() %>')">수정</button>
<%
}
%>

</div>

<a href='bbslist.jsp'>글 목록</a>

<script type="text/javascript">
function deletebbs(seq) {
	alert(seq);	
	location.href = "bbsdelete.jsp?seq=" + seq;
}
function updatebbs(seq) {
	alert(seq);	
	location.href = "bbsupdate.jsp?seq=" + seq;
}
</script>


 

</body>
</html>











