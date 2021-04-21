package manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.AdminService;
import manager.model.vo.Report;
import message.model.vo.PageInfo;

/**
 * Servlet implementation class ReplyReport
 */
@WebServlet("/category.do")
public class ReportCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String option = request.getParameter("category");
		
		// 페이징 처리 변수
				int listCount;	  
				int currentPage;  
				int pageLimit;    
				int boardLimit;	  
				int maxPage;	  
				int startPage;	  
				int endPage;	  
				
			    listCount = new AdminService().getReportOptionCount(option);
			    
			    currentPage = 1;
			    if(request.getParameter("currentPage") != null) {
			    	currentPage = Integer.parseInt(request.getParameter("currentPage"));
			    }
			    
			    pageLimit = 10;		// 한페이지 게시글 갯수
			    boardLimit = 10;	// 페이지갯수
				
			    // maxPage 계산 (전체 게시글 갯수에서 나누고 나머지를 가지고 따져야함)
			    maxPage = (int)Math.ceil((double)listCount/boardLimit);
			    
			    // startPage 계산 (시작페이지를 맞춰 현재 페이지를 맞춤 현재페이지에 커런트페이지 -1 )
			    startPage = pageLimit * ((currentPage - 1)/pageLimit) + 1;
			    
			    // endPage 계산
			    endPage = startPage + pageLimit - 1;
			    if(maxPage < endPage) {
			    	endPage = maxPage;
			    }
			    
			    PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
				ArrayList<Report> Rlist = new AdminService().selectOptionReport(pi, option);
				String page = null;
				
				if(Rlist != null) {
					request.setAttribute("reportList", Rlist);
					request.setAttribute("pi", pi);
					request.setAttribute("option", option);
					page = "WEB-INF/views/manager/manager_report.jsp";
				} else {
					page = "WEB-INF/views/common/alertPage.jsp";
					request.setAttribute("msg", "신고관리 조회를 실패 하였습니다.");
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
