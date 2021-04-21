package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Comment;
import member.model.vo.Member;

/**
 * Servlet implementation class CommentWriteServlet
 */
@WebServlet("/commentWrite.do")
public class CommentWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentWriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int bNum = Integer.parseInt(request.getParameter("bNum"));
		String id = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String comment = request.getParameter("comment");
		
		Comment c = new Comment(bNum, id, comment);
		
		int result = new BoardService().insertComment(c);
		
		String page = null;
		if(result > 0) {
			page = "boardDetail.do?bnum=" + bNum;
			response.sendRedirect(page);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "댓글 작성에 실패하였습니다. 다시 시도해 주세요");
			request.setAttribute("path", "javascript:history.back();");
			request.getRequestDispatcher(page).forward(request, response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
