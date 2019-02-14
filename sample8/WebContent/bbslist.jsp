<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dao.iBbsDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!

// 댓글용 함수
public String arrow(int depth){	// depth = 0(부모글), depth = 1 ~ (댓글)
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
	
	String ts = "";
	
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0?"":ts + rs;
}


%>    

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	%>
	<script type="text/javascript">
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>	
	<%
	return;
}

mem = (MemberDto)ologin;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist</title>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/style1.css">
</head>
<body>

<%

String searchWord = request.getParameter("searchWord");
String choice = request.getParameter("choice");

System.out.println("searchWord = " + searchWord);
System.out.println("choice = " + choice);

if(choice == null || choice.equals("")){
	choice = "sel";
}

// 검색어를 지정하지 않고 choice가 넘어 왔을 경우
if(choice.equals("sel")){
	searchWord = "";
}

if(searchWord == null){
	searchWord = "";
	choice = "sel";
}

iBbsDao dao = BbsDao.getInstance();
List<BbsDto> list = dao.getBbsList(searchWord, choice);
%>


<h2>환영합니다 <%=mem.getId() %>님 반갑습니다</h2>

<h1>게시판</h1>

<a href="calendar.jsp">일정관리</a>

<a href="pdslist.jsp">자료실</a>

<div align="right">
	<a href="logout.jsp">로그아웃</a>
</div>

<hr>

<div align="center">

<table border="1">
<col width="70"><col width="500"><col width="150">

<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>

<%
if(list == null || list.size() == 0){
	%>	
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>	
	</tr>	
	<%
}else{
	for(int i = 0;i < list.size(); i++){
		BbsDto bbs = list.get(i);
	%>
	
		<tr>
			<th><%=i + 1 %></th>	
			<td class="title">
				<%=arrow(bbs.getDepth()) %>
				<%if(bbs.getDel() == 1){ %>
					이 글은 작성자에 의해서 삭제되었습니다.
				<%}else{ %>
					<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
						<%=bbs.getTitle() %>
					</a>
				<%} %>
			</td>
			<td align="center"><%=bbs.getId() %></td>
		</tr>
	<%
	}
}
%>

</table> 

</div>

<!-- search -->
<div align="center">

<select id="choice">
<option value="sel">선택</option>
<option value="title">제목</option>
<option value="writer">작성자</option>
<option value="content">내용</option>
</select>

<input type="text" id="search" value="">
<button name="search" onclick="searchBbs()">검색</button>
</div>

<hr>
<a href="bbswrite.jsp">글쓰기</a>

<script type="text/javascript">
function searchBbs() {
	alert("searchBbs");
	var choice = document.getElementById("choice").value;
	var word = $("#search").val();
//	alert("choice = " + choice);
//	alert("word = " + word);

	if(word == ""){
		alert("choice = " + choice);
		document.getElementById("choice").value = 'sel';
	}
	
	location.href = "bbslist.jsp?searchWord=" + word + "&choice=" + choice;
	
}


</script>



</body>
</html>





