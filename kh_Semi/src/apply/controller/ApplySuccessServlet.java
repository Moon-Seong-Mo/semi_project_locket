package apply.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import apply.model.service.ApplyService;
import apply.model.vo.Apply;

/**
 * Servlet implementation class ApplySuccessServlet
 */
@WebServlet("/applySuccess.do")
public class ApplySuccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplySuccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int gNum = Integer.parseInt(request.getParameter("gNum"));
		String buyMemberId = request.getParameter("buyMemberId");
		String buyer_addr = request.getParameter("buyer_addr");
		int amount = Integer.parseInt(request.getParameter("amount"));
		String uid = request.getParameter("merchantUID");
		
		Apply a = new Apply(gNum, buyMemberId, buyer_addr, amount, uid);
		
		int result = new ApplyService().insertApplyInfo(a);
		
		JSONObject applyObj = new JSONObject();
		applyObj.put("result", result);
		
		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println(applyObj);
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
