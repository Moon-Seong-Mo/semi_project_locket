package product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import product.model.service.ProductService;

/**
 * Servlet implementation class SuperDeleteServlet
 */
@WebServlet("/superDelete.do")
public class SuperDeleteServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuperDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      int pId = Integer.parseInt(request.getParameter("pId"));
      
      int result = new ProductService().superDelete(pId);
      
      String page = null;
      if(result > 0) {
         page = "list.pro";
      } else {
         page = "WEB-INF/views/common/alertPage.jsp";
         request.setAttribute("msg", "관리자 권한 삭제 중 오류 발생 다시 시도해 주십시오");
         request.setAttribute("path", request.getHeader("referer"));
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