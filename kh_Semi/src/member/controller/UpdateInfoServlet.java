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
 * Servlet implementation class UpdateInfoServlet
 */
@WebServlet("/updateInfo.do")
public class UpdateInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String pwHint = request.getParameter("pwHint");
		String pwAns = request.getParameter("pwAns");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String nickName = request.getParameter("nickname");
		String bank = request.getParameter("bank");
		String accountNum = request.getParameter("banknum");
		String paymentPw = request.getParameter("bankpw");
		
		Member updateInfo = new Member(pwHint, pwAns, email, phone, nickName);

		int result = new MemberService().updateInfo(userId, updateInfo);
		
		if (result > 0) {
			Member loginMember = (Member) request.getSession().getAttribute("loginMember");
			loginMember.setNickName(nickName);
			
			request.setAttribute("msg", "회원정보 수정이 완료되었습니다.");
			request.setAttribute("path", request.getContextPath() + "/myPage.do");
			
		} else {
			request.setAttribute("msg", "회원정보 수정 중 오류 발생 다시 시도해 주세요");
			request.setAttribute("path", request.getHeader("referer"));
		}
		request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
