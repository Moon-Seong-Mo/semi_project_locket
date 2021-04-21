package group.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import group.model.service.GroupService;
import group.model.vo.Attachment;
import group.model.vo.Group;

/**
 * Servlet implementation class BoardUpdateFormServlet
 */
@WebServlet("/updateGroupForm.do")
public class GroupUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupUpdateFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		
		GroupService service = new GroupService();
		
		Group g = service.selectDetail(bnum);
		ArrayList<Attachment> fileList = service.selectFile(bnum);
		
		String page = null;
		if(g != null) {
			page = "WEB-INF/views/group/group_update.jsp";
			request.setAttribute("group", g);
			request.setAttribute("fileList", fileList);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "목록 조회에 실패하였습니다.");
			request.setAttribute("path", "boardList.do");
		}
		
		request.getRequestDispatcher(page).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
