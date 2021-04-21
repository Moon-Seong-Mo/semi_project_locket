package product.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReportSendFormServlet
 */
@WebServlet("/reportSendForm.do")
public class ReportSendFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportSendFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String nickname = request.getParameter("writer");
		String writerId = request.getParameter("writerId");
		String path = request.getParameter("path");
		String cate = request.getParameter("cate");
		String cNum = null;
		if(cate.equals("댓글 신고")) {
			cNum = request.getParameter("cNum");
			request.setAttribute("cNum", cNum);
		}
		
		request.setAttribute("wId", writerId);
		request.setAttribute("nickname", nickname);
		request.setAttribute("path", path);
		request.setAttribute("cate", cate);
		request.getRequestDispatcher("WEB-INF/views/product/reportSendForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
