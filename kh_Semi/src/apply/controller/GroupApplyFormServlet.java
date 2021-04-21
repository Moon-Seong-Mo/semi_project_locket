package apply.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import apply.model.service.ApplyService;
import group.model.service.GroupService;
import group.model.vo.Group;
import member.model.vo.Member;
import shipping_address.model.service.Shipping_addressService;
import shipping_address.model.vo.Shipping_address;

/**
 * Servlet implementation class GroupApplyFormServlet
 */
@WebServlet("/applyForm.do")
public class GroupApplyFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupApplyFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bNum = Integer.parseInt(request.getParameter("bnum"));
		Group g = new GroupService().selectApply(bNum);
		
		String memberId = ((Member)request.getSession().getAttribute("loginMember")).getId();
		ArrayList<Shipping_address> list = new Shipping_addressService().selectDeliList(memberId);
		
//		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		Member buyMember = new ApplyService().selectMember(memberId);
		
		String page = null;
		if(g != null) {
			if(list != null && list.size() > 0) {
				page = "WEB-INF/views/group/apply.jsp";
				request.setAttribute("group", g);
	//			request.setAttribute("loginMember", loginMember);
				request.setAttribute("buyMember", buyMember);
			} else {
				page = "WEB-INF/views/common/alertPage.jsp";
				request.setAttribute("msg", "등록된 배송지가 없습니다. 배송지를 먼저 등록해주세요");
				request.setAttribute("path", "javascript:self.close();");
			}
			
			request.setAttribute("list", list);
		} else {
			page = "WEB-INF/views/common/alertPage.jsp";
			request.setAttribute("msg", "결제신청 실패");
			request.setAttribute("path", "groupDetail.do");
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
