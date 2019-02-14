package Pds.df;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Pds.Pdsdao;
import Pds.iPdsDao;

public class FileDownLoader extends HttpServlet {

	private ServletConfig mConfig = null;
	private static final int BUFFER_SIZE = 8192;
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		mConfig = config;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Get 등록");
		
		String filename = req.getParameter("filename");
		
		// download 수 증가 (DB) 싱글턴이라 접근 가능
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		String filePath = "";
		
		// tomcat
		filePath = mConfig.getServletContext().getRealPath("/upload");
		
		// 폴더
	//	filePath = "d:\\tmp";
	
		filePath = filePath + "\\" + filename;
		
		File f = new File(filePath);
		System.out.println("파일경로 : " + filePath);
	
		if(f.exists() && f.canRead()) {
			
			// window download 설정(다운로드 창) 
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
            resp.setHeader("Content-Transfer-Encoding", "binary;");
            resp.setHeader("Content-Length", "" + f.length());
            resp.setHeader("Pragma", "no-cache;"); 
            resp.setHeader("Expires", "-1;");
			
			// 파일 생성, 기입
            BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
            
            byte buffer[] = new byte[BUFFER_SIZE];
            int read = 0;
            
            while((read = fileInput.read(buffer)) != -1)
            {
               out.write(buffer, 0, read);      
            }
            
            // 다운로드 증가
            iPdsDao dao = Pdsdao.getinstance();
            
            String seqq = req.getParameter("seq");
            int seq = Integer.parseInt(seqq);
            
            dao.downCount(seq);
            
            fileInput.close();
            out.flush();
		}
		else {
			System.out.println("파일이 존재하지 않습니다");
		}
	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		super.doPost(req, resp);
	}

}
