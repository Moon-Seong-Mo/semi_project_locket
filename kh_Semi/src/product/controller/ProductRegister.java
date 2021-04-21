package product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import common.MyFileRenamePolicy;
import member.model.vo.Member;
import product.model.service.ProductService;
import product.model.vo.Product;
import product.model.vo.Product_File;

/**
 * Servlet implementation class ProductRegister
 */
@WebServlet("/register.pro")
public class ProductRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 1024 * 1024 * 10; //10Mbyte로 전송파일 용량 제한
			String root = request.getSession().getServletContext().getRealPath("/");
			String savePath = root + "product_uploadFiles/";
			
			File f = new File(savePath);
			if(!f.exists()) {
				f.mkdirs(); //파일이 없다면 만들어~
			} 
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			//요소들 받아올껀데 단, multiRequest로 받아오기
			
			String writer = ((Member)request.getSession().getAttribute("loginMember")).getId();		
			String category = multiRequest.getParameter("category");
			String title = multiRequest.getParameter("title");
			int price = Integer.parseInt(multiRequest.getParameter("price"));
			String condition = multiRequest.getParameter("condition");
			String delivery = multiRequest.getParameter("delivery");
			String explain = multiRequest.getParameter("explain");
			
			String location1 = multiRequest.getParameter("location1");
			String location2 = multiRequest.getParameter("location2");
			String location3 = multiRequest.getParameter("location3");
			
			ArrayList<String> saveFiles = new ArrayList<String>();    // 바뀐 파일의 이름을 저장할 ArrayList
			ArrayList<String> originFiles = new ArrayList<String>();  // 원본 파일의 이름을 저장할 ArrayList
			
			Enumeration<String> files = multiRequest.getFileNames();  // 폼에서 전송된 파일 리스트의 이름 반환
			while(files.hasMoreElements()) {
				String name = files.nextElement();  // 전송 순서 역순으로 가져옴
				
				if(multiRequest.getFilesystemName(name) != null) { 
					saveFiles.add(multiRequest.getFilesystemName(name));
					originFiles.add(multiRequest.getOriginalFileName(name));
				}
			}			

			Product p = new Product(category, title, price, condition, delivery, explain);
			p.setLocation1(location1);
			p.setLocation2(location2);
			p.setLocation3(location3);
			
			ArrayList<Product_File> fileList = new ArrayList<Product_File>();
			for(int i = originFiles.size() -1; i >= 0; i--) {
				Product_File pt = new Product_File();
				pt.setFilePath(savePath);
				pt.setOriginName(originFiles.get(i));
				pt.setChangeName(saveFiles.get(i));
				
				if(i == originFiles.size() - 1) {
					//만약 4개가 들어왔는데 제일 마지막꺼 (index =3)인 것이 썸네일인거니까 그것만 level 0으로!!!
					pt.setFileLevel(0);
				} else {
					pt.setFileLevel(1);
				}		
				fileList.add(pt);
			}
	
			int result = new ProductService().registerProduct(writer, p, fileList);
			
			if(result > 0) {
				response.sendRedirect("list.pro");
			} else {
				for(int i = 0; i < saveFiles.size(); i++) {
					File failedFile = new File(savePath + saveFiles.get(i));
					failedFile.delete();
				}		
				request.setAttribute("msg", "사진 게시판 등록에 실패하였습니다.");
				request.getRequestDispatcher("WEB-INF/views/common/alertPage.jsp").forward(request, response);
			}
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
