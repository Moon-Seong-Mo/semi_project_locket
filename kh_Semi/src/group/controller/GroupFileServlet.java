package group.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import group.model.service.GroupService;

/**
 * Servlet implementation class BoardFileServlet
 */
@WebServlet("/groupFile.do")
public class GroupFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupFileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int fileNum = Integer.parseInt(request.getParameter("fileNum"));
		
		int result = new GroupService().updateFileCount(fileNum);
		
		PrintWriter out = response.getWriter();
		JSONObject jsonData = new JSONObject();
		if(result > 0) {
			jsonData.put("result", true);
		} else {
			jsonData.put("result", false);
		}
		
		response.setContentType("application/json; charset=UTF-8");
		out.println(jsonData);
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
