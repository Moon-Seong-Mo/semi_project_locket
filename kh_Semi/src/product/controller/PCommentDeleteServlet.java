package product.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import product.model.service.ProductService;

/**
 * Servlet implementation class PCommentDeleteServlet
 */
@WebServlet("/PCommentDelete.pro")
public class PCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PCommentDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		int cNum = Integer.parseInt(request.getParameter("cNum"));
		String id = ((Member)request.getSession().getAttribute("loginMember")).getId();
		
		int result = new ProductService().deleteComment(cNum, id);
		
		String page = null;
		if(result > 0) {
			page = "pdetail.pro?option=0&pId=" + pId;
			response.sendRedirect(page);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "댓글 삭제에 실패하였습니다. 다시 시도해 주세요");
			request.setAttribute("path", "javascript:history.back();");
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
