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
 * Servlet implementation class JoinServlet
 */
@WebServlet("/join.do")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JoinServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("userId");
		String pw = request.getParameter("userPw");
		String pwHint = request.getParameter("pwHint");
		String pwAns = request.getParameter("pwAns");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String nickName = request.getParameter("nickname");
		String mCheck = request.getParameter("mCheck");
		
		Member joinMember = new Member(id, pw, pwHint, pwAns, gender, email, phone, nickName, mCheck);

		int result = new MemberService().joinMember(joinMember);
		
		if (result > 0) {
			request.setAttribute("msg", "회원가입이 완료되었습니다 로그인 후 사용하여 주십시오");
			request.setAttribute("path", request.getContextPath());
			
		} else {
			request.setAttribute("msg", "회원가입 진행 중 오류 발생 다시 시도해 주십시오");
			request.setAttribute("path", request.getHeader("referer"));
		}
		
		request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
