package message.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Attachment;
import board.model.vo.Comment;
import message.model.service.messageService;
import message.model.vo.Message;

/**
 * Servlet implementation class MessageDetail
 */
@WebServlet("/messageDetail.do")
public class MessageDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		int mNum = Integer.parseInt(request.getParameter("num"));
		
		messageService service = new messageService();
		
		Message m = service.selectDetail(mNum);
		String page = null;
		if(m != null) {
			page = "WEB-INF/views/message/message_detail.jsp";
			request.setAttribute("message", m);
			
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", " 메세지 조회에 실패하였습니다.");
			request.setAttribute("path", "boardList.do");
		}
		
		request.getRequestDispatcher(page).forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
