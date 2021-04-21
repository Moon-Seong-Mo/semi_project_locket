package product.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import product.model.service.ProductService;

/**
 * Servlet implementation class RDealOkayServlet
 */
@WebServlet("/RDealOkay.do")
public class RDealOkayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RDealOkayServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String memberId = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String[] dealId = request.getParameterValues("dealId");
		String[] selDeal = request.getParameterValues("selDeal");
		int[] selNum = Arrays.stream(selDeal).mapToInt(Integer::parseInt).toArray();
		
		ProductService service = new ProductService();
		
		int result = service.okayRDeal(memberId, selNum, dealId);
		
		String page = null;
		if(result > 0) {
			page = "receiveP.do";
		} else {
			page = "WEB-INF/view/common/alertPage.jsp";
			request.setAttribute("msg", "거래 승낙에 실패");
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
