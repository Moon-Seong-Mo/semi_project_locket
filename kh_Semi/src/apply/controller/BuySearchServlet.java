package apply.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import apply.model.service.ApplyService;
import apply.model.vo.Apply;
import apply.model.vo.PageInfo;

/**
 * Servlet implementation class BuySearchServlet
 */
@WebServlet("/applySearch.do")
public class BuySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuySearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String word = request.getParameter("word");
		String option = request.getParameter("searchOption");
		
		ApplyService aService = new ApplyService();
		
		int listCount; // 총 게시글 개수
		int currentPage; // 현재 페이지
		int pageLimit; // 한 페이지에 표시될 페이지 수
		int boardLimit; // 한 페이지에 보일 게시글 최대 개수
		int maxPage; // 전체 페이지 중 가장 마지막 페이지
		int startPage; // 페이징이 된 페이지 중 시작 페이지
		int endPage; // 페이징이 된 페이지 중 마지막 페이지
		
		listCount = aService.getSerachListCount(word, option);
		
		currentPage = 1;
		if(request.getParameter("currentPage") !=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		pageLimit = 10;
		boardLimit = 10;
		
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
		ArrayList<Apply> list = aService.selectSearchList(word, option, pi);
		
		String page = null;
		if(list != null) {
			page = "WEB-INF/views/group/apply.jsp";
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
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
