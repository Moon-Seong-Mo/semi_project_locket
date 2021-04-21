package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Board;
import board.model.vo.PageInfo;
import member.model.vo.Member;

/**
 * Servlet implementation class SuperBDelete
 */
@WebServlet("/superBDelete.do")
public class SuperBDelete extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuperBDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");

      int bnum = Integer.parseInt(request.getParameter("bnum"));
      
      int result = new BoardService().superBDelete(bnum);
      
      String page = null;
      if(result > 0) {
         page = "boardList.do";
         response.sendRedirect(page);
      } else {
         page = "WEB-INF/views/common/alertPage.jsp";
         request.setAttribute("msg", "게시글 삭제 중 오류 발생 다시 시도해 주십시오");
         request.setAttribute("path", request.getHeader("referer"));
         request.getRequestDispatcher(page).forward(request, response);
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