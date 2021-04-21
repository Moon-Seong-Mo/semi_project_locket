package shipping_address.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import shipping_address.model.service.Shipping_addressService;
import shipping_address.model.vo.Shipping_address;

/**
 * Servlet implementation class UpdateDeliveryServlet
 */
@WebServlet("/updateAdd.do")
public class UpdateDeliveryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDeliveryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String memberId = ((Member)request.getSession().getAttribute("loginMember")).getId();
		
		String receiver = request.getParameter("receiver");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String phone = request.getParameter("phone");
		String addname = request.getParameter("addname");
		
		String address = address1 + "/" + address2;
		
		Shipping_address sa = new Shipping_address(addname, address, phone, receiver);
		
		int result = new Shipping_addressService().insertDeli(memberId, sa);
		
		String page = "WEB-INF/views/common/alertPage.jsp";
		String msg = null;
		String path = null;
		if(result > 0) {
			msg = "배송지가 추가되었습니다.";
			path = "javascript:self.close();";
		} else {
			msg = "배송지 등록에 실패했습니다.";
			path = "javascript:self.close();";
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
