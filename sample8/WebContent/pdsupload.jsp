<%@page import="Pds.PdsDto"%>
<%@page import="Pds.Pdsdao"%>
<%@page import="Pds.iPdsDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!

public String processUploadFile(FileItem fileItem, String dir) throws IOException{
   
   String fileName = fileItem.getName();
   long sizeInBytes = fileItem.getSize();
   
   // 파일이 정상일 때
   if(sizeInBytes > 0){   // d:\\tmp\\abc.txt
      
      int idx = fileName.lastIndexOf("\\");
      if(idx == -1){         
         idx = fileName.lastIndexOf("/");
      }
      fileName = fileName.substring(idx + 1);   // abc.txt
      
      try{
         File uploadFile = new File(dir, fileName);
         fileItem.write(uploadFile);   // 실제 올려주는 부분
      }catch(Exception e){}      
   }
   
   return fileName;
}

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdsupload.jsp</title>
</head>
<body>

<%

// tomcat 배포
String fupload = application.getRealPath("/upload");

// 지정 폴더 저장
// String fupload = "d:\\tmp";

System.out.println("파일업로드:" + fupload);


String yourTempDirectory = fupload;

int yourMaxRequestSize = 100 * 1024 * 1024;      // 1M
int yourMaxMemorySize = 100 * 1024;

// form field 의 데이터(String)
String id = "";
String title = "";
String content = "";

// file data
String filename = "";

boolean isMultipart = ServletFileUpload.isMultipartContent(request);

if(isMultipart){
   
   // FileItem 을 생성하는 함수
   DiskFileItemFactory factory = new DiskFileItemFactory();
   
   factory.setSizeThreshold(yourMaxMemorySize);
   factory.setRepository(new File(yourTempDirectory));
   
   ServletFileUpload upload = new ServletFileUpload(factory);
   upload.setSizeMax(yourMaxRequestSize);
      
   // list저장
   List<FileItem> items = upload.parseRequest(request);
   Iterator<FileItem> it = items.iterator();
   
   while(it.hasNext()){
      
      FileItem item = it.next();
      // id, title, content
      if(item.isFormField()){
         if(item.getFieldName().equals("id")){
            id = item.getString("utf-8");
         }
         else if(item.getFieldName().equals("title")){
            title = item.getString("utf-8");
         }
         else if(item.getFieldName().equals("content")){
            content = item.getString("utf-8");
         }
      }
      // file
      else{
         if(item.getFieldName().equals("fileload")){
            filename = processUploadFile(item, fupload);
            System.out.println("fupload:" + fupload);
         }         
      }   
   }
   
   
}else{
   // Multipart Type 아님
}



// DB에 추가
iPdsDao dao = Pdsdao.getinstance();

boolean isS = dao.writePds(new PdsDto(id, title, content, filename));

if(isS){
%>
	<script type="text/javascript">
	alert("파일 업로드 성공!");
	location.href = "pdslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("파일 업로드 실패!");
	location.href = "pdslist.jsp";
	</script>
<%
}
%>

</body>
</html>







