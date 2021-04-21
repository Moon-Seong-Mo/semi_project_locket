package product.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import product.model.service.ProductService;
import product.model.vo.PComment;
import product.model.vo.Product;
import product.model.vo.Product_File;
import product.model.vo.WishList;

/**
 * Servlet implementation class ProductDetailServlet
 */
@WebServlet("/pdetail.pro")
public class ProductDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pId = Integer.parseInt(request.getParameter("pId"));
		
		ProductService pservice = new ProductService();
		
		int rank = ((Member) request.getSession().getAttribute("loginMember")).getRankCode();
		int option = Integer.parseInt(request.getParameter("option"));
		
		Product product = null;
		
		if(rank < 99 && option == 0) {
			product = pservice.detailProduct(pId);
		} else {
			product = pservice.detailProductAdmin(pId);
		}
		
		int count = pservice.countDeal(product.getProductWriter());
		
		product.setDealCount(count);
		
		ArrayList<Product_File> pfList = pservice.detailPFile(pId);
		ArrayList<PComment> pcommentList = pservice.selectPComment(pId);
		ArrayList<WishList> wish = pservice.selectWish();
		
		String cNum = request.getParameter("cNum");
		
		String page = null;
		if(product != null && pfList != null) {
			page = "WEB-INF/views/product/product_detail.jsp";
			request.setAttribute("product", product);
			request.setAttribute("pfList", pfList);
			request.setAttribute("commentList", pcommentList);
			request.setAttribute("wish", wish);
			request.setAttribute("cNum", cNum);
			
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
