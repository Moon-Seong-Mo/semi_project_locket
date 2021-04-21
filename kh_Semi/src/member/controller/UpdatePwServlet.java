package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class UpdatePwServlet
 */
@WebServlet("/updatePw.do")
public class UpdatePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePwServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String userId = ((Member)(request.getSession().getAttribute("loginMember"))).getId();
		String userPw = request.getParameter("userPw");
		String newPw = request.getParameter("newPw");
		
		Member myInfo = new Member(userId, userPw);
		
		int result = new MemberService().updatePw(myInfo, newPw);
		
		String page = "WEB-INF/views/common/alertPage.jsp";
		String msg = null;
		String path = null;
		if(result > 0) {
			msg = "비밀번호가 수정되었습니다.";
			path = "javascript:self.close();";
		} else {
			msg = "비밀번호 수정에 실패했습니다. 현재 비밀번호를 확인하세요.";
			path = request.getHeader("referer");
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("path", path);
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
