package shipping_address.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import shipping_address.model.service.Shipping_addressService;

/**
 * Servlet implementation class DeleteDeliveryServlet
 */
@WebServlet("/deleteSA.do")
public class DeleteDeliveryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteDeliveryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String id = ((Member)request.getSession().getAttribute("loginMember")).getId();
		String[] saArrs = request.getParameterValues("RowCheck");
		int[] addNums = Arrays.stream(saArrs).mapToInt(Integer::parseInt).toArray();
		
		int result = new Shipping_addressService().deleteSA(id, addNums);
		
		String page = null;
		if(result > 0) {
			page = "deliveryList.do";
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "배송지 삭제에 실패하였습니다.");
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
