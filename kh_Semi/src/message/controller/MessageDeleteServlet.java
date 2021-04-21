package message.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import message.model.service.messageService;

/**
 * Servlet implementation class MessageDeleteServlet
 */
@WebServlet("/deleteMessage.do")
public class MessageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String memberId = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String[] selmessage = request.getParameterValues("selmessage");
		int[] selNum = Arrays.stream(selmessage).mapToInt(Integer::parseInt).toArray();
		
		int result = new messageService().deleteMessage(memberId, selNum);
		
		String page = null;
		if(result > 0) {
			page = "message.do";
		} else {
			page = "WEB-INF/view/common/alertPage.jsp";
			request.setAttribute("msg", "쪽지 삭제에 실패");
			request.setAttribute("path", "javascript:history.back();");
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
