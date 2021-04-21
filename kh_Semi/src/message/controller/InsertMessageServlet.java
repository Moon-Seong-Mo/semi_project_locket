package message.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import member.model.vo.Member;
import message.model.service.messageService;
import message.model.vo.Message;

/**
 * Servlet implementation class InsertMessage
 */
@WebServlet("/insertMessage.do")
public class InsertMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String sendName = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		
		Message message = new Message();
		message.setMemberId(id);
		message.setSendId(sendName);
		message.setMContent(content);
		
		int result = new messageService().insertMessage(message);
		
		String page = "WEB-INF/views/common/alertPage.jsp";
		if(result > 0) {
			request.setAttribute("msg", "쪽지를 보냈습니다.");
			request.setAttribute("path", "javascript:self.close();");
		} else {
			request.setAttribute("msg", "쪽지보내기에 실패하였습니다. 닉네임을 확인해주세요");
			request.setAttribute("path", "javascript:history.back(-1);");
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
