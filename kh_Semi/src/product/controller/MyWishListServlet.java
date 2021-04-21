package product.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.vo.PageInfo;
import member.model.vo.Member;
import product.model.service.ProductService;
import product.model.vo.Product;
import product.model.vo.Product_File;

/**
 * Servlet implementation class MyWishListServlet
 */
@WebServlet("/myWishlist.do")
public class MyWishListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyWishListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = ((Member)request.getSession().getAttribute("loginMember")).getId();		
		
		ProductService service = new ProductService();
		
		//페이징
		int listCount;   // 총 게시글 개수
		int currentPage; //현재 페이지 
		int pageLimit;   // 한 페이지에 표시될 페이지 수
		int boardLimit;  // 한 페이지에 보일 게시글 최대 개수
		int maxPage;     // 전체 페이지 중 가장 마지막 페이지
		int startPage;   // 페이징이 된 페이지 중 시작 페이지
		int endPage;     // 페이징이 된 페이지 중 마지막 페이지
		
		listCount = service.getWListCount(user);
		
		currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		pageLimit = 3;
		boardLimit = 6;
		
		// maxPage 계산
		maxPage = (int) Math.ceil((double) listCount / boardLimit);
		
		// startPage 계산
		startPage = pageLimit * ((currentPage - 1) / pageLimit) + 1;
		
		// endPage 계산
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);	
		
		//게시물 불러오기
		ArrayList<Product> wList = service.selectWList(user, pi);
		ArrayList<Product_File> wfList = service.selectWFList(2);
		
		String page = null;
		if(wList != null && wfList != null) {
			request.setAttribute("wList", wList);
			request.setAttribute("wfList", wfList);
			request.setAttribute("pi", pi);
			page = "WEB-INF/views/member/my_wishlist.jsp";
		} else {
			request.setAttribute("msg", "찜목록 조회에 실패하였습니다.");
			page = "WEB-INF/views/common/alertPage.jsp";
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
