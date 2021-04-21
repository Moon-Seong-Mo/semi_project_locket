package product.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.service.ProductService;
import product.model.vo.Product;
import product.model.vo.Product_File;

/**
 * Servlet implementation class ProductUpdateFormServlet
 */
@WebServlet("/productUpdateForm.do")
public class ProductUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductUpdateFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pId = Integer.parseInt(request.getParameter("pId"));
		
		ProductService pservice = new ProductService();
		
		Product product = pservice.selectDetailProduct(pId);	
		ArrayList<Product_File> pfList = pservice.detailPFile(pId);
		
		ArrayList<String> locationList = new ProductService().selectLocation();
		
		String page = null;
		if(product != null && pfList != null) {
			page = "WEB-INF/views/product/product_update.jsp";
			request.setAttribute("product", product);
			request.setAttribute("pfList", pfList);
			request.setAttribute("locationList", locationList);
			
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "중고물품 조회에 실패하였습니다.");
			request.setAttribute("path", "list.pro");
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
