package member.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.SessionMoniter;
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("idInput");
		String pw = request.getParameter("pwInput");
		
		Member member = new Member(id, pw);
		
		MemberService service = new MemberService();
		
		Member loginMember = service.loginMember(member);
		
		if(loginMember != null) {
			if(loginMember.getInCheck().equals("Y")) {
				if(loginMember.getsCheck().equals("Y")) {
					
					Calendar c = Calendar.getInstance();
					String y = String.valueOf(c.get(Calendar.YEAR));
					String m = String.valueOf(c.get(Calendar.MONTH) + 1);
					String d = String.valueOf(c.get(Calendar.DAY_OF_MONTH));
					
					
					if(loginMember.getmDate().compareTo(Date.valueOf(y + "-" + m + "-" + d)) < 0) {
						int result = service.updateStopMember(loginMember.getId());
						
						if(result > 0) {
							if(!SessionMoniter.sessionMap.containsKey(id)) {
								HttpSession session = request.getSession();
								session.setAttribute("loginMember", loginMember);
								session.setMaxInactiveInterval(1800);
								response.sendRedirect(request.getContextPath());
							} else {
								SessionMoniter.sessionMap.get(id).invalidate();
								request.setAttribute("msg", "이미 로그인 된 회원입니다.");
								request.setAttribute("path", request.getHeader("referer"));
								request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
							}
						} else {
							request.setAttribute("msg", "로그인 중 오류 발생");
							request.setAttribute("path", request.getHeader("referer"));
							request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
						}
					} else {
						request.setAttribute("msg", "정지된 회원입니다");
						request.setAttribute("path", request.getHeader("referer"));
						request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
					}
				} else {
					if(!SessionMoniter.sessionMap.containsKey(id)) {
						HttpSession session = request.getSession();
						session.setAttribute("loginMember", loginMember);
						session.setMaxInactiveInterval(1800);
						response.sendRedirect(request.getContextPath());
					} else {
						SessionMoniter.sessionMap.get(id).invalidate();
						request.setAttribute("msg", "이미 로그인 된 회원입니다.");
						request.setAttribute("path", request.getHeader("referer"));
						request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
					}
				}
			} else {
				request.setAttribute("msg", "탈퇴(제명)된 회원입니다.");
				request.setAttribute("path", request.getHeader("referer"));
				request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
			}
			
		} else {
			request.setAttribute("msg", "아이디나 비밀번호를 확인하세요");
			request.setAttribute("path", request.getHeader("referer"));
			request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
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
