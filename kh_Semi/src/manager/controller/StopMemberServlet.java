package manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.SessionMoniter;
import manager.model.service.AdminService;

/**
 * Servlet implementation class StopMemberServlet
 */
@WebServlet("/stopMember.do")
public class StopMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StopMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checkId = request.getParameterValues("checkId");
		int term = Integer.parseInt(request.getParameter("term"));
		
		int result = new AdminService().stopMember(checkId, term, 1);
		
		String page = "managerInfo.do";
		if(result > 0) {
			for(String id : checkId) {
				if(SessionMoniter.sessionMap.containsKey(id)) {
					SessionMoniter.sessionMap.get(id).invalidate();
				}
			}
		 	response.sendRedirect(page);
		} else {
			request.setAttribute("msg", "처리 실패");
			request.setAttribute("path", page);
			request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
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
