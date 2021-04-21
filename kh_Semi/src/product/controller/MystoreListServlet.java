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
 * Servlet implementation class MystoreListServlet
 */
@WebServlet("/myStoreList.do")
public class MystoreListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MystoreListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String writer = ((Member)request.getSession().getAttribute("loginMember")).getId();		
		
		ProductService service = new ProductService();
		
		//페이징
		int listCount;   // 총 게시글 개수
		int currentPage; //현재 페이지 
		int pageLimit;   // 한 페이지에 표시될 페이지 수
		int boardLimit;  // 한 페이지에 보일 게시글 최대 개수
		int maxPage;     // 전체 페이지 중 가장 마지막 페이지
		int startPage;   // 페이징이 된 페이지 중 시작 페이지
		int endPage;     // 페이징이 된 페이지 중 마지막 페이지
		
		listCount = service.getMyListCount(writer);

		currentPage = 1;	
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		pageLimit = 5;
		boardLimit = 6;
		
		maxPage = (int)Math.ceil((double)listCount / boardLimit);
		startPage = pageLimit * ((currentPage - 1) / pageLimit) + 1;
		
		endPage = startPage + pageLimit -1;
		if(maxPage < endPage) {
			endPage = maxPage;  //이건 만약에 페이지가 23까지 있다면... endPage가 30되는거 방지
		}
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);	
		
		//게시물 불러오기
		ArrayList<Product> mypList = service.selectMyPList(writer, pi);
		ArrayList<Product_File> mypfList = service.selectMyPList();
		
		String page = null;
		if(mypList != null && mypfList != null) {
			request.setAttribute("mypList", mypList);
			request.setAttribute("mypfList", mypfList);
			request.setAttribute("pi", pi);
			page = "WEB-INF/views/member/my_store.jsp";
		} else {
			request.setAttribute("msg", "내 상점 조회에 실패하였습니다.");
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
