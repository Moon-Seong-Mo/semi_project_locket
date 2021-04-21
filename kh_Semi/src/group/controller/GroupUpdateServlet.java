package group.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import common.MyFileRenamePolicy;
import group.model.service.GroupService;
import group.model.vo.Attachment;
import group.model.vo.Group;
import member.model.vo.Member;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/groupUpdate.do")
public class GroupUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 1024 * 1024 * 10; // 10Mbyte로 전송파일 용량 제한
			String root = request.getSession().getServletContext().getRealPath("/");
			String savePath = root + "group_uploadFiles\\";
			
			File f = new File(savePath);
			if(!f.exists()) {
				f.mkdirs();
			}
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
		
			String loginId = ((Member)request.getSession().getAttribute("loginMember")).getId();
			int bNum = Integer.parseInt(multiRequest.getParameter("bnum"));
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			String sd = multiRequest.getParameter("startdate");
			String ed = multiRequest.getParameter("enddate");
			int price = Integer.parseInt(multiRequest.getParameter("price"));
			
			Date startDate = Date.valueOf(sd);
			Date endDate = Date.valueOf(ed);
			
			ArrayList<String> saveFiles = new ArrayList<String>();
			ArrayList<String> originFiles = new ArrayList<String>();
		
			Enumeration<String> files = multiRequest.getFileNames();
			
			while(files.hasMoreElements()) {
				String name = files.nextElement();
				
				if(multiRequest.getFilesystemName(name) != null) {
					saveFiles.add(multiRequest.getFilesystemName(name));
					originFiles.add(multiRequest.getOriginalFileName(name));
				}
			}
			
			Group g = new Group(bNum, title, content, loginId, price, startDate, endDate);
			
			ArrayList<Attachment> fileList = new ArrayList<Attachment>();
			for(int i = originFiles.size() - 1; i >= 0; i--) {
				Attachment at = new Attachment();
				at.setFilePath(savePath);
				at.setOriginName(originFiles.get(i));
				at.setChangeName(saveFiles.get(i));
				
				at.setFileLevel(0);

				fileList.add(at);
			}
			
			int exFileCount = Integer.parseInt(multiRequest.getParameter("exfileCount"));
			int count = 0;
			ArrayList<String> exFile = new ArrayList<String>();
			for(int i = 0; ; i++) {
				if(count == exFileCount) {
					break;
				}
				
				String file = multiRequest.getParameter("setFile_" + i);
				if(file == null) {
					continue;
				}
				
				exFile.add(file);
				count++;
			}
			
			int result = new GroupService().updateGroup(g, exFile, fileList);
			
			String page = null;
			if(result > 0) {
				page = "groupList.do?bnum=" + bNum;
				response.sendRedirect(page);
			} else {
				page = "WEB-INF/views/common/alertPage.jsp";
				request.setAttribute("msg", "물품 수정에 실패하였습니다.");
				request.setAttribute("path", request.getHeader("referer"));
				request.getRequestDispatcher(page).forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
