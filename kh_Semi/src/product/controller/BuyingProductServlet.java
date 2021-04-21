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
 * Servlet implementation class BuyingProductServlet
 */
@WebServlet("/buyingP.do")
public class BuyingProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyingProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String user = request.getParameter("userId");
		String receiver = request.getParameter("writerId");
		int pId = Integer.parseInt(request.getParameter("pId"));
		String pTitle = request.getParameter("pTitle");
		
		int result = new ProductService().insertBuying(user, pId, pTitle, receiver);
		
		String page = "WEB-INF/views/common/alertPage.jsp";
		String msg = null;
		String path = null;
		if(result > 0) {
			msg = "거래 신청이 완료되었습니다";
			path = "javascript:self.close();";
		} else if(result == 0 ) {
			msg = "이미 신청한 상품입니다!";
			path = "javascript:self.close();";
		} else {
			msg = "거래 신청에 실패했습니다.";
			path = "javascript:self.close();";
		}	
		request.setAttribute("msg", msg);
		request.setAttribute("path", path);
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
