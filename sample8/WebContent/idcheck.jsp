<%@page import="dao.MemberDao"%>
<%@page import="dao.iMemberDao"%>
<%
String id = request.getParameter("id");
System.out.println("id = " + id);

iMemberDao dao = MemberDao.getInstance();
boolean isS = dao.getId(id);

if(isS){
	out.print("NO");
}else{	
	out.print("OK");
}
%>