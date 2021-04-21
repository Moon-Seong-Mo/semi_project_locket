package product.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.AdminService;
import manager.model.vo.Report;

/**
 * Servlet implementation class ReportInsertServlet
 */
@WebServlet("/insertReport.do")
public class ReportInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String opt = request.getParameter("opt");
		String id1 = request.getParameter("id1");
		String id2 = request.getParameter("id2");
		String reportReason = request.getParameter("reportReason");
		String path = request.getParameter("path");
		
		Report r = new Report();
		r.setCategory(opt);
		r.setMemberId(id1);
		r.setMemberId2(id2);
		r.setReason(reportReason);
		r.setPath(path);
		
		int result = new AdminService().insertReport(r);
		
		String page = "WEB-INF/views/common/alertPage.jsp";
		if(result > 0) {
			request.setAttribute("msg", "신고가 완료되었습니다.");
			request.setAttribute("path", "javascript:self.close();");
		} else {
			request.setAttribute("msg", "신고하기에 실패하였습니다.");
			request.setAttribute("path", "javascript:self.close();");
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
