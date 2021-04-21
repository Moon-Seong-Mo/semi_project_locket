package common.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.vo.Board;
import common.model.service.CommonService;
import group.model.vo.Group;
import product.model.vo.Product;

/**
 * Servlet implementation class AllSearchServlet
 */
@WebServlet("/allSearch.all")
public class AllSearchServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AllSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      String word = request.getParameter("word");
      
      CommonService cService = new CommonService();
   
      ArrayList<Product> plist = cService.selectSearchPList(word);
      ArrayList<Board> blist = cService.selectSearchBList(word);
      ArrayList<Group> glist = cService.selectSearchGList(word);
      
      String page = null;
      if(plist != null || blist != null || glist != null) {
         page = "WEB-INF/views/common/allSearch.jsp";
         request.setAttribute("bList", blist);
         request.setAttribute("pList", plist);
         request.setAttribute("gList", glist);
      } else {
         page = "WEB-INF/views/common/alertPage.jsp";
         request.setAttribute("msg", "전체 검색에 실패하였습니다.");
         request.setAttribute("path", request.getContextPath());
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