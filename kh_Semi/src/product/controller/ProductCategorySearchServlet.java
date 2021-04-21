package product.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.vo.PageInfo;
import product.model.service.ProductService;
import product.model.vo.Product;
import product.model.vo.Product_File;

/**
 * Servlet implementation class ProductCategorySearchServlet
 */
@WebServlet("/categorySearch.pro")
public class ProductCategorySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductCategorySearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String location1 = request.getParameter("location1");
		String location2 = request.getParameter("location2");
		String location3 = request.getParameter("location3");
		String option = request.getParameter("categorySearch");
		
		String word = request.getParameter("word");
		String option2 = request.getParameter("searchOption");
		
		ProductService pService = new ProductService();
		
		int listCount = 0; // 총 게시글 개수
		int currentPage; // 현재 페이지
		int pageLimit; // 한 페이지에 표시될 페이지 수
		int boardLimit; // 한 페이지에 보일 게시글 최대 개수
		int maxPage; // 전체 페이지 중 가장 마지막 페이지
		int startPage; // 페이징이 된 페이지 중 시작 페이지
		int endPage; // 페이징이 된 페이지 중 마지막 페이지
		
		listCount = pService.getSearchListCount(option, location1, location2, location3, option2, word);
		
		currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		pageLimit = 5;
		boardLimit = 9;
		
		maxPage = (int) Math.ceil((double) listCount / boardLimit);
		
		startPage = pageLimit * ((currentPage - 1) / pageLimit) + 1;
		
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
		ArrayList<Product> plist = null;
		
		ArrayList<String> locationList = pService.selectLocation();
		ArrayList<String> locationList2 = null;
		ArrayList<String> locationList3 = null;
		
		plist = pService.selectSearchList(location1, location2, location3, option, option2, word, pi);
		
		if(location1.equals("0")) {
		}else if(!location1.equals("0") && location2.equals("0")) {
			locationList2 = pService.selectSiGunGu(location1);
		} else if(!location2.equals("0") && location3.equals("0")) {
			locationList2 = pService.selectSiGunGu(location1);
			locationList3 = pService.selectDong(location1, location2);
		} else if(!location3.equals("0")) {
			locationList2 = pService.selectSiGunGu(location1);
			locationList3 = pService.selectDong(location1, location2);
		}
		
		ArrayList<Product_File> pfList = pService.selectPList();
		
		String page = null;
		if(plist != null) {
			page = "WEB-INF/views/product/product_list.jsp";
			request.setAttribute("locationList", locationList);
			request.setAttribute("locationList2", locationList2);
			request.setAttribute("locationList3", locationList3);
			request.setAttribute("location1", location1);
			request.setAttribute("location2", location2);
			request.setAttribute("location3", location3);
			
			request.setAttribute("pList", plist);
			request.setAttribute("pfList", pfList);
			request.setAttribute("pi", pi);
			request.setAttribute("option", option);
			
			request.setAttribute("option2", option2);
			request.setAttribute("word", word);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "게시판 조회에 실패하였습니다.");
			request.setAttribute("path", request.getContextPath());
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
