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
 * Servlet implementation class DeleteWishlistServlet
 */
@WebServlet("/deleteWishlist.do")
public class DeleteWishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteWishlistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pId = Integer.parseInt(request.getParameter("pId"));
		String user = ((Member)request.getSession().getAttribute("loginMember")).getId();
		
		int result = new ProductService().deleteWishlist(user, pId);
		
		String page = null;
		String msg = null;
		if(result > 0) {
			msg = "배송지가 추가되었습니다.";
			page = "myWishlist.do";
		} else {
			msg = "배송지 등록에 실패했습니다.";
			page = "WEB-INF/views/common/alertPage.jsp";
		}	
		request.setAttribute("msg", msg);
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
