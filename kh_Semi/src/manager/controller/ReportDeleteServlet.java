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
 * Servlet implementation class ReportDeleteServlet
 */
@WebServlet("/Reportdelete.do")
public class ReportDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checkId = request.getParameterValues("checkId");
		
		int result = new AdminService().reportdelete(checkId);
		
		String page = "managerreport.do";
		if(!(result > 0)) {
			request.setAttribute("msg", "회원 제명에 실패하였습니다.");
			request.setAttribute("path", page);
			request.getRequestDispatcher(page).forward(request, response);
		} else {
			for(String id : checkId) {
				if(SessionMoniter.sessionMap.containsKey(id)) {
					SessionMoniter.sessionMap.get(id).invalidate();
				}
			}
			response.sendRedirect(page);
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
