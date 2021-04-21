package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;
import product.model.service.ProductService;

/**
 * Servlet implementation class MypageServlet
 */
@WebServlet("/myPage.do")
public class MypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String loginId = ((Member) request.getSession().getAttribute("loginMember")).getId();
        
        Member m = new MemberService().getMemberInfo(loginId);
        
        int dCount = new ProductService().countDeal(loginId);
        
        request.setAttribute("memberInfo", m);
        request.setAttribute("dCount", dCount);
        
        request.getRequestDispatcher("WEB-INF/views/member/myPage.jsp").forward(request, response);
     }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
