package product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BuyingProductFormServlet
 */
@WebServlet("/buyingProductForm.do")
public class BuyingProductFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyingProductFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		String pTitle = request.getParameter("pTitle");
		String writer = request.getParameter("writer");
		String writerId = request.getParameter("writerId");
		int price = Integer.parseInt(request.getParameter("pPrice"));
		
		request.setAttribute("pId", pId);
		request.setAttribute("pTitle", pTitle);
		request.setAttribute("www", writer);
		request.setAttribute("wId", writerId);
		request.setAttribute("price", price);
		request.getRequestDispatcher("WEB-INF/views/product/buyingProduct.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
