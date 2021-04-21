package group.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import apply.model.service.ApplyService;
import apply.model.vo.Apply;
import group.model.service.GroupService;
import group.model.vo.Attachment;
import group.model.vo.Group;
import member.model.vo.Member;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/groupDetail.do")
public class GroupDetailServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      int bNum = Integer.parseInt(request.getParameter("bnum"));
      String userId = ((Member) request.getSession().getAttribute("loginMember")).getId();
      GroupService service = new GroupService();
      
      Group g = service.selectDetail(bNum);

	  Calendar c = Calendar.getInstance();
	  String y = String.valueOf(c.get(Calendar.YEAR));
	  String m = String.valueOf(c.get(Calendar.MONTH) + 1);
	  String d = String.valueOf(c.get(Calendar.DAY_OF_MONTH));
	
	  boolean checkDate = false;
	  
      if(g != null && (g.getStartDate().compareTo(Date.valueOf(y + "-" + m + "-" + d)) <= 0 && g.getEndDate().compareTo(Date.valueOf(y + "-" + m + "-" + d)) >= 0)) {
    	  checkDate = true;
      } else {
    	  checkDate = false;
      }
      
      ArrayList<Attachment> fileList = service.selectFile(bNum);
      
      ApplyService aService = new ApplyService();
      
      Apply a = aService.selectUserApplyInfo(userId, bNum);
      
      int applyCount = aService.selectApplyList(bNum);
      
      String page = null;
      if(g != null) {
         page = "WEB-INF/views/group/group_detail.jsp";
         request.setAttribute("group", g);
         request.setAttribute("fileList", fileList);
         request.setAttribute("apply", a);
         request.setAttribute("applyCount", applyCount);
         request.setAttribute("checkDate", checkDate);
      } else {
          page = "WEB-INF/views/common/alertPage.jsp";
          request.setAttribute("msg", "물품 조회에 실패하였습니다.");
          request.setAttribute("path", "groupList.do");
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