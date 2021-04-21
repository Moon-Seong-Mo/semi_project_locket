package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Attachment;
import board.model.vo.Board;
import board.model.vo.Comment;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/boardDetail.do")
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bNum = Integer.parseInt(request.getParameter("bnum"));
		
		BoardService service = new BoardService();
		
		Board b = service.selectDetail(bNum);
		ArrayList<Attachment> fileList = service.selectFile(bNum);
		ArrayList<Comment> commentList = service.selectComment(bNum);
		
		String cNum = request.getParameter("cNum");
		
		String page = null;
		if(b != null) {
			page = "WEB-INF/views/board/board_detail.jsp";
			request.setAttribute("board", b);
			request.setAttribute("fileList", fileList);
			request.setAttribute("commentList", commentList);
			request.setAttribute("cNum", cNum);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "게시글 조회에 실패하였습니다.");
			request.setAttribute("path", "boardList.do");
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
