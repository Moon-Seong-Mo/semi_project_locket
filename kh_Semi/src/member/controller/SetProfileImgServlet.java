package member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import board.model.vo.Attachment;
import common.MyFileRenamePolicy;
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class SetProfileImgServlet
 */
@WebServlet("/setProfileImg.do")
public class SetProfileImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetProfileImgServlet() {
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
			String savePath = root + "userProfile_uploadFiles\\";
			
			File f = new File(savePath);
			if(!f.exists()) {
				f.mkdirs();
			}
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
		
			String loginId = ((Member)request.getSession().getAttribute("loginMember")).getId();
			
			ArrayList<String> saveFiles = new ArrayList<String>();
		
			Enumeration<String> files = multiRequest.getFileNames();
			
			while(files.hasMoreElements()) {
				String name = files.nextElement();
				
				if(multiRequest.getFilesystemName(name) != null) {
					saveFiles.add(multiRequest.getFilesystemName(name));
				}
			}
			
			ArrayList<Attachment> fileList = new ArrayList<Attachment>();
			for(int i = saveFiles.size() - 1; i >= 0; i--) {
				Attachment at = new Attachment();
				at.setFilePath(savePath);
				at.setChangeName(saveFiles.get(i));

				fileList.add(at);
			}
			
			int result = new MemberService().updateProfileImg(loginId, fileList.get(0));
			
			String page = "WEB-INF/views/common/alertPage.jsp";
			String msg = null;
			String path = null;
			if(result > 0) {
				((Member)request.getSession().getAttribute("loginMember")).setpImage(fileList.get(0).getFilePath() + fileList.get(0).getChangeName());
				msg = "프로필 사진이 수정되었습니다.";
				path = "javascript:self.close();";
			} else {
				msg = "프로필 사진 수정에 실패했습니다. 다시 시도해주세요.";
				path = request.getHeader("referer");
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("path", path);
			request.getRequestDispatcher(page).forward(request, response);
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
