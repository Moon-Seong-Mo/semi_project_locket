package product.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import product.model.service.ProductService;
import product.model.vo.PComment;

/**
 * Servlet implementation class PCommentWriteServlet
 */
@WebServlet("/PCommentWrite.pro")
public class PCommentWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PCommentWriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		String id = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String comment = request.getParameter("comment");
		
		PComment pc = new PComment(pId, id, comment);
		
		int result = new ProductService().insertComment(pc);
		
		String page = null;
		if(result > 0) {
			page = "pdetail.pro?option=0&pId=" + pId;
			response.sendRedirect(page);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "댓글 작성에 실패하였습니다. 다시 시도해 주세요");
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
