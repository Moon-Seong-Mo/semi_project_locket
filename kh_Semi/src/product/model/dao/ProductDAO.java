package product.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Properties;

import board.model.vo.PageInfo;
import product.model.vo.Deal;
import product.model.vo.PComment;
import product.model.vo.Product;
import product.model.vo.Product_File;
import product.model.vo.WishList;

public class ProductDAO {
	
	private Properties prop = new Properties();
	
	public ProductDAO() {
		String fileName = ProductDAO.class.getResource("/sql/product/product-query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int getMyListCount(Connection conn, String writer) {
		PreparedStatement pstmt = null; 
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getMyListCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			
			pstmt.setString(1, writer);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int registerProduct(Connection conn, String writer, Product p) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("registerPro");

		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, writer);
			pstmt.setString(2, p.getCategory());
			pstmt.setString(3, p.getTitle());
			pstmt.setInt(4, p.getPrice());
			pstmt.setString(5, p.getCondition());
			pstmt.setString(6, p.getDelivery());
			pstmt.setString(7, p.getExplain());
			pstmt.setString(8, p.getLocation1());
			pstmt.setString(9, p.getLocation2());
			pstmt.setString(10, p.getLocation3());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int registerProduct(Connection conn, ArrayList<Product_File> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("registerPF");
		//registerPF=INSERT INTO PRODUCT_FILE VALUES(SEQ_PFCOUNT.NEXTVAL, SEQ_PCOUNT.CURRVAL, ?, ?, ?, ?, DEFAULT)
		try {
			for(int i = 0; i < fileList.size(); i++) {
				Product_File pf = fileList.get(i);
				
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, pf.getOriginName());
				pstmt.setString(2, pf.getChangeName());
				pstmt.setString(3, pf.getFilePath());
				pstmt.setInt(4, pf.getFileLevel());
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} close(pstmt);
		
		return result;
	}

	public ArrayList selectMyPList(Connection conn, String writer, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Product> list = new ArrayList<Product>();
		
		String query = prop.getProperty("selectMyPList");
		//SELECT * FROM (SELECT ROWNUM RNUM, DESCPRODUCT.* FROM (SELECT PRODUCT_NUM, MEMBER_ID, MEMBERNAME, CATEGORY, TITLE, PRICE, CONDITION, DELIVERY, EXPLAIN,  
		//CREATE_DATE, PRODUCT_COUNT FROM PRODUCT JOIN MEMBER USING(MEMBER_ID) WHERE STATUS = 'Y' AND MEMBER_ID = ? ORDER BY PRODUCT_NUM DESC) DESCPRODUCT) WHERE RNUM BETWEEN ? AND ?
		
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, writer);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product p = new Product(rset.getInt("product_num"),
										rset.getString("member_id"),
										rset.getString("category"),
										rset.getString("title"),
										rset.getInt("price"),
										rset.getString("condition"),
										rset.getString("delivery"),
										rset.getString("explain"),
										rset.getDate("create_date"),
										rset.getInt("product_count"));				
				list.add(p);
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public ArrayList selectMyPFList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<Product_File> list = null;
	
		String query = prop.getProperty("selectPFList");
		//SELECT * FROM PRODUCT_FILE WHERE FILE_LEVEL=0
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			list = new ArrayList<Product_File>();
			
			while(rset.next()) {
				list.add(new Product_File(rset.getInt("product_num"),
										rset.getString("change_name")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}
	
	public int updateCount(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateCount");
		//UPDATE PRODUCT SET PRODUCT_COUNT = PRODUCT_COUNT + 1 WHERE PRODUCT_NUM = ?
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}	
		return result;
	}

	public Product detailProduct(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Product p = new Product();
		
		String query = prop.getProperty("detailProduct");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			
			rset = pstmt.executeQuery();
						
			if(rset.next()) {
				p = new Product(rset.getInt("PRODUCT_NUM"), 
								rset.getString("MEMBER_ID"), 
								rset.getString("P_IMAGE"),
								rset.getString("MEMBERNAME"),					
								rset.getString("CATEGORY"),
								rset.getString("TITLE"), 
								rset.getInt("PRICE"),
								rset.getString("CONDITION"),
								rset.getString("DELIVERY"),
								rset.getString("EXPLAIN"), 
								rset.getDate("CREATE_DATE"),
								rset.getInt("PRODUCT_COUNT"));
				p.setLocation1(rset.getString("LOCATION1"));
				p.setLocation2(rset.getString("LOCATION2"));
				p.setLocation3(rset.getString("LOCATION3"));
				p.setRankName(rset.getString("RANK_NAME"));
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		}	finally {
			close(rset);
			close(pstmt);
		}
		return p;
	}

	public ArrayList<Product_File> detailPFile(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Product_File> list = null;
		
		String query = prop.getProperty("detailPFile");
		//SELECT * FROM PRODUCT_FILE WHERE PRODUCT_NUM = ?
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<Product_File>();
			
			while(rset.next()) {
				Product_File pf = new Product_File();
				pf.setPfId(rset.getInt("PF_ID"));
				pf.setOriginName(rset.getString("ORIGIN_NAME"));
				pf.setChangeName(rset.getString("CHANGE_NAME"));
				pf.setFilePath(rset.getString("FILE_PATH"));
				pf.setFileLevel(rset.getInt("FILE_LEVEL"));
				
				list.add(pf);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int addWishlist(Connection conn, String user, int pId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("addWishlist");
		//INSERT INTO WISHLIST VALUES(?, ?)
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user);
			pstmt.setInt(2, pId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;		
	}

	public ArrayList<WishList> selectWish(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<WishList> wlist = null;
	
		String query = prop.getProperty("selectWish");
		//SELECT * FROM WISHLIST WHERE STATUS='Y'
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			wlist = new ArrayList<WishList>();
			
			while(rset.next()) {
				WishList w = new WishList(rset.getString("MEMBER_ID"), 
						 			   	  rset.getInt("WISH_NUM"));
				
				wlist.add(w);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return wlist;
	}

	public int getProductCount(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("getProductCount");
		//SELECT COUNT(*) FROM PRODUCT WHERE STATUS = 'Y'

		try {
			stmt = conn.createStatement();

			rset = stmt.executeQuery(query);

			if (rset.next()) {
				result = rset.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return result;
	}

	public ArrayList selectPList(Connection conn, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Product> list = new ArrayList<Product>();
		
		String query = prop.getProperty("selectPList");
		//SELECT * FROM PLIST WHERE RNUM BETWEEN ? AND ?
		
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product p = new Product(rset.getInt("product_num"),
										rset.getString("member_id"),
										rset.getString("category"),
										rset.getString("title"),
										rset.getInt("price"),
										rset.getString("condition"),
										rset.getString("delivery"),
										rset.getString("explain"),
										rset.getDate("create_date"),
										rset.getInt("product_count"));
				p.setRankCode(rset.getInt("RANK_CODE"));
				p.setLocation1(rset.getString("LOCATION1"));
				p.setLocation2(rset.getString("LOCATION2"));
				p.setLocation3(rset.getString("LOCATION3"));
				
				list.add(p);
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public ArrayList selectPFList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<Product_File> list = null;

		String query = prop.getProperty("selectPFList");
		//SELECT * FROM PRODUCT_FILE WHERE FILE_LEVEL=0
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			list = new ArrayList<Product_File>();
			
			while(rset.next()) {
				list.add(new Product_File(rset.getInt("product_num"),
										rset.getString("change_name")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

	public ArrayList selectWList(Connection conn, String user, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Product> list = new ArrayList<Product>();
		
		String query = prop.getProperty("selectWList");
		//SELECT * FROM (SELECT ROWNUM RNUM,  DESCPRODUCT.* FROM (SELECT PRODUCT_NUM, WISHLIST.MEMBER_ID, CATEGORY, TITLE, PRICE, CONDITION, DELIVERY, EXPLAIN, CREATE_DATE, PRODUCT_COUNT FROM PRODUCT JOIN WISHLIST ON(WISH_NUM = PRODUCT_NUM) 
		//WHERE WISHLIST.MEMBER_ID = ? ORDER BY PRODUCT_NUM DESC) DESCPRODUCT) WHERE RNUM BETWEEN ? AND ?
		
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product p = new Product(rset.getInt("product_num"),
										rset.getString("member_id"),
										rset.getString("category"),
										rset.getString("title"),
										rset.getInt("price"),
										rset.getString("condition"),
										rset.getString("delivery"),
										rset.getString("explain"),
										rset.getDate("create_date"),
										rset.getInt("product_count"));				
				list.add(p);
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int deleteWishlist(Connection conn, String user, int pId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteWishlist");
		//DELETE FROM WISHLIST WHERE MEMBER_ID = ? AND WISH_NUM = ?
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user);
			pstmt.setInt(2, pId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int getWishCount(Connection conn, String user) {
		PreparedStatement pstmt = null; 
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getWishCount");
		//SELECT COUNT(*) FROM WISHLIST WHERE MEMBER_ID =?
		try {
			pstmt = conn.prepareStatement(query);
					
			pstmt.setString(1, user);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}
	
	//여기서부터 복붙
	public ArrayList<PComment> selectPComment(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<PComment> list = null;
		
		String query = prop.getProperty("selectComment");
		//SELECT PC.*, M.P_IMAGE FROM PRODUCT_COMMENT PC JOIN MEMBER M ON(PC.MEMBER_ID = M.MEMBER_ID) WHERE PRODUCT_NUM = ? AND STATUS = 'Y'
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			list = new ArrayList<PComment>();
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				list.add(new PComment(rs.getInt("COMMENT_NUM"),
									 rs.getInt("O_NUM"),
									 rs.getString("MEMBER_ID"),
									 rs.getString("COMMENT_C"),
									 rs.getTimestamp("WR_DATE"),
									 rs.getString("MEMBERNAME"),
									 rs.getString("P_IMAGE")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	public int insertComment(Connection conn, PComment pc) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertComment");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pc.getO_Num());
			pstmt.setString(2, pc.getMemberId());
			pstmt.setString(3, pc.getComment());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteComment(Connection conn, int cNum, String id) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteComment");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cNum);
			pstmt.setString(2, id);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteProduct(Connection conn, int pId, String userId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteProduct");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			pstmt.setString(2, userId);
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int deleteFile(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("organizeFiles");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int organizeFiles(Connection conn, int pId, ArrayList<String> exFile) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("organizeFiles");
		
		if(exFile.size() > 0) {
			query += " AND FILE_ID NOT IN(" + String.join(", ", exFile) + ")";
		}
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	//중고물품 검색창으로 검색
	public int getSearchListCount(Connection conn, String word, String option) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String query = prop.getProperty("getSearchListCount");
//		getSearchListCount=SELECT COUNT(*) FROM PRODUCT JOIN MEMBER USING(MEMBER_ID) WHERE ? LIKE '%' || ? || '%' AND STATUS = 'Y'
		query = query.replaceFirst("\\?", option);
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, word);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Product> selectSearchList(Connection conn, String word, String option, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Product> list = new ArrayList<Product>();

		String query = prop.getProperty("selectSearchList");
//		selectSearchList=SELECT RNUM, PRODUCT.* FROM (SELECT ROWNUM RNUM, P.* FROM (SELECT PRODUCT_NUM, MEMBER_ID, MEMBERNAME, TITLE, PRICE, PRODUCT_COUNT FROM PRODUCT JOIN MEMBER USING(MEMBER_ID) WHERE STATUS = 'Y' AND ? LIKE '%' || ? || '%' ORDER BY PRODUCT_NUM DESC) P) PRODUCT  WHERE RNUM BETWEEN ? AND ?
		query = query.replaceFirst("\\?", option);

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, word);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Product p = new Product(rs.getInt("PRODUCT_NUM"), 
									rs.getString("TITLE"), 
									rs.getInt("PRICE"),
									rs.getInt("PRODUCT_COUNT"));
				p.setRankCode(rs.getInt("RANK_CODE"));
				p.setLocation1(rs.getString("LOCATION1"));
				p.setLocation2(rs.getString("LOCATION2"));
				p.setLocation3(rs.getString("LOCATION3"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int deleteFiles(Connection conn, String[] changeFiles) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteFiles");
		
		try {
			if(changeFiles != null) {
				for(String fileNum : changeFiles) {
					pstmt = conn.prepareStatement(query);
					pstmt.setInt(1, Integer.parseInt(fileNum));
					
					result += pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateProduct(Connection conn, String writer, Product p) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateProduct");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, p.getCategory());
			pstmt.setString(2, p.getTitle());
			pstmt.setInt(3, p.getPrice());
			pstmt.setString(4, p.getCondition());
			pstmt.setString(5, p.getDelivery());
			pstmt.setString(6, p.getExplain());
			pstmt.setString(7, p.getLocation1());
			pstmt.setString(8, p.getLocation2());
			pstmt.setString(9, p.getLocation3());
			pstmt.setInt(10, p.getProductId());
			pstmt.setString(11, writer);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateProductFile(Connection conn, int pId, ArrayList<Product_File> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateProductFile");
		
		try {
			for(Product_File pf : fileList) {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, pId);
				pstmt.setString(2, pf.getOriginName());
				pstmt.setString(3, pf.getChangeName());
				pstmt.setString(4, pf.getFilePath());
				pstmt.setInt(5, pf.getFileLevel());
				
				result += pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int insertBuying(Connection conn, String user, int pId, String pTitle, String receiver) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertBuying");
		//INSERT INTO DEAL VALUES(?, ?, ?, ?, SYSDATE, DEFAULT)
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, user);
			pstmt.setInt(2, pId);	
			pstmt.setString(3, pTitle);
			pstmt.setString(4, receiver);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			result = 0;
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	//내가 신청한 리스트 조회
	public ArrayList<Deal> selectADeal(Connection conn, String loginId, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Deal> Dlist = null;
		
		String query = prop.getProperty("getADeal");
		//SELECT * FROM DEAL WHERE MEMBER = ? AND STATUS = 'Y' (더 길다 원래)

		int startRow = (pi.getCurrentPage() -1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			Dlist = new ArrayList<Deal>();
			
			while(rset.next()) {
				Dlist.add(new Deal(rset.getString("MEMBERNAME"),
								   rset.getInt("PRODUCT_NUM"),
								   rset.getString("PRODUCT_TITLE"),
								   rset.getString("RECEIVER"),
								   rset.getDate("SEND_DATE"),
								   rset.getString("STATUS")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return Dlist;
	}
	
	//나에게 온 리스트 조회
	public ArrayList<Deal> selectRDeal(Connection conn, String loginId, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Deal> Dlist = null;
		
		String query = prop.getProperty("getRDeal");
		//SELECT * FROM DEAL WHERE RECEIVER = ? AND STATUS = 'Y' (더 길다 원래)

		int startRow = (pi.getCurrentPage() -1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			Dlist = new ArrayList<Deal>();
			
			while(rset.next()) {
				Dlist.add(new Deal(rset.getString("MEMBERNAME"),
								   rset.getInt("PRODUCT_NUM"),
								   rset.getString("PRODUCT_TITLE"),
								   rset.getString("MEMBER"),
								   rset.getDate("SEND_DATE"),
								   rset.getString("STATUS")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return Dlist;
	}

	public int getADealCount(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getADealCount");
		//SELECT COUNT(*) FROM DEAL WHERE MEMBER = ? AND STATUS='Y'
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}
	
	public int getRDealCount(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getRDealCount");
		//SELECT COUNT(*) FROM DEAL WHERE RECEIVER = ? AND STATUS='Y'
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}	
		return result;
	}

	public int refuseRDeal(Connection conn, String[] dealIid, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("refuseRDeal");
		
		
		try {
			for(int i = 0; i < selNum.length; i++) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, dealIid[i]);
				pstmt.setInt(2, selNum[i]);
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	//나에게 신청온거 승낙
	public int okayRDeal(Connection conn, String[] dealId, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("okayRDeal");
		//UPDATE DEAL SET STATUS = 'N' WHERE RECEIVER = ? AND PRODUCT_NUM = ?
		
		try {
			for(int i = 0; i < dealId.length; i++) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, dealId[i]);
				pstmt.setInt(2, selNum[i]);
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int cancelADeal(Connection conn, String memberId, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("cancelADeal");
		//DELETE FROM DEAL WHERE MEMBER = ? AND PRODUCT_NUM = ?
		
		try {
			for(int dealNum : selNum) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, memberId);
				pstmt.setInt(2, dealNum);
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		return result;
	}

	public int countDeal(Connection conn, String memberId) {
		PreparedStatement pstmt = null; 
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("countDeal");
		//SELECT COUNT(*) FROM DEAL WHERE (RECEIVER = ? AND STATUS='N') OR (MEMBER = ? AND STATUS = 'N')
		try {
			pstmt = conn.prepareStatement(query);
					
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int changePstatus(Connection conn, String[] dealId, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("changePstatus");
		
		try {
			for(int i = 0; i < dealId.length; i++) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, dealId[i]);
				pstmt.setInt(2, selNum[i]);
				pstmt.setInt(3, selNum[i]);
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int checkMemberRank(Connection conn, String memberId, String[] dealId) {
		CallableStatement cstmt = null;
		int result = 0;
		
		String procedure = prop.getProperty("checkMemberRank");
		
		try {
			for(String dId : dealId) {
				cstmt = conn.prepareCall(procedure);
				cstmt.setString(1, memberId);
				cstmt.setString(2, dId);
				cstmt.registerOutParameter(3, Types.NUMERIC);
				
				cstmt.execute();
				
				result = cstmt.getInt(3);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(cstmt);
		}
		
		
		return result;
	}

	public int changeCstatue(Connection conn, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("cancelDeal");
		
		try {
			for(int dealNum : selNum) {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, dealNum);
				
				result += pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int superDelete(Connection conn, int pId) {
	      PreparedStatement pstmt = null;
	      int result = 0;
	      
	      String query = prop.getProperty("superDelete");
	      //DELETE FROM PRODUCT WHERE PRODUCT_NUM = ?
	      
	      try {
	         pstmt = conn.prepareStatement(query);
	         pstmt.setInt(1, pId);
	         
	         result = pstmt.executeUpdate();
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         close(pstmt);
	      }      
	      return result;
	   }

	public ArrayList<String> selectLocation(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<String> list = null;
		
		String query = prop.getProperty("selectLocation");
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(query);
			list = new ArrayList<String>();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return list;
	}
	
	public ArrayList<String> selectSiGunGu(Connection conn, String sido) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<String> list = null;
		
		String query = prop.getProperty("selectSiGunGu");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, sido);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<String>();
			
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}

	public ArrayList<String> selectDong(Connection conn, String sido, String sigungu) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<String> list = null;
		
		String query = prop.getProperty("selectDong");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, sido);
			pstmt.setString(2, sigungu);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<String>();
			
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}

	public Product detailProductAdmin(Connection conn, int pId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Product p = new Product();
		
		String query = prop.getProperty("detailProductAdmin");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			
			rset = pstmt.executeQuery();
						
			if(rset.next()) {
				p = new Product(rset.getInt("PRODUCT_NUM"), 
								rset.getString("MEMBER_ID"), 
								rset.getString("P_IMAGE"),
								rset.getString("MEMBERNAME"),					
								rset.getString("CATEGORY"),
								rset.getString("TITLE"), 
								rset.getInt("PRICE"),
								rset.getString("CONDITION"),
								rset.getString("DELIVERY"),
								rset.getString("EXPLAIN"), 
								rset.getDate("CREATE_DATE"),
								rset.getInt("PRODUCT_COUNT"));
				p.setLocation1(rset.getString("LOCATION1"));
				p.setLocation2(rset.getString("LOCATION2"));
				p.setLocation3(rset.getString("LOCATION3"));
				p.setRankName(rset.getString("RANK_NAME"));
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return p;
	}
	
	public int getSearchListCount(Connection conn, String option, String location1, String location2, String location3,
			String option2, String word) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		String query = prop.getProperty("getSearchListCount");
		
		if(location1 != null && !location1.equals("0")) {
			query = query.replaceFirst("\\?", "LOCATION1 = ? ?");
			
			if(location2 != null && !location2.equals("0")) {
				query = query.replaceFirst("\\? \\?", "? AND LOCATION2 = ? ?");
				
				if(location3 != null && !location3.equals("0")) {
					query = query.replaceFirst("\\? \\?", "? AND LOCATION3 = ? ?");
				} else {
					query = query.replaceFirst("\\? \\?", "? ?");
				}
			} else {
				query = query.replaceFirst("\\? \\?", "? ?");
			}
		} else {
			query = query.replaceFirst("\\?", "? ?");
		}
		
		if(option != null && !option.equals("0")) {
			query = query.replaceFirst("\\? \\?", "? AND CATEGORY = ? ?");
		}
		
		if(word != null && !word.equals("")) {
			query = query.replaceFirst("\\? \\?", "? AND " + option2 + " LIKE '%' || ? || '%'");
		} else {
			query = query.replaceFirst("\\? \\?", "?");
		}
		
		query = query.replaceFirst("WHERE \\? AND", "WHERE");
		query = query.replaceFirst("WHERE \\?", "WHERE");
		query = query.replaceFirst("\\? STATUS", "? AND STATUS");
		query = query.replaceFirst("' STATUS", "' AND STATUS");
		
		int i = 1;
		try {
			pstmt = conn.prepareStatement(query);
			
			if(location1 != null && !location1.equals("0")) {
				pstmt.setString(i++, location1);
				if(location2 != null && !location2.equals("0")) {
					pstmt.setString(i++, location2);
					if(location3 != null && !location3.equals("0")) {
						pstmt.setString(i++, location3);
					}
				}
			}
			
			if(option != null && !option.equals("0")) {
				pstmt.setString(i++, option);
			}
			
			if(word != null && !word.equals("")) {
				pstmt.setString(i++, word);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return count;
	}

	public ArrayList<Product> selectSearchList(Connection conn, String location1, String location2, String location3,
			String option, String option2, String word, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Product> list = null;
		
		String query = prop.getProperty("selectSearchList");
		
		if(location1 != null && !location1.equals("0")) {
			query = query.replaceFirst("\\?", "LOCATION1 = ? ?");
			
			if(location2 != null && !location2.equals("0")) {
				query = query.replaceFirst("\\? \\?", "? AND LOCATION2 = ? ?");
				
				if(location3 != null && !location3.equals("0")) {
					query = query.replaceFirst("\\? \\?", "? AND LOCATION3 = ? ?");
				} else {
					query = query.replaceFirst("\\? \\?", "? ?");
				}
			} else {
				query = query.replaceFirst("\\? \\?", "? ?");
			}
		} else {
			query = query.replaceFirst("\\?", "? ?");
		}
		
		if(option != null && !option.equals("0")) {
			query = query.replaceFirst("\\? \\?", "? AND CATEGORY = ? ?");
		}
		
		if(word != null && !word.equals("")) {
			query = query.replaceFirst("\\? \\?", "? AND " + option2 + " LIKE '%' || ? || '%'");
		} else {
			query = query.replaceFirst("\\? \\?", "?");
		}
		
		query = query.replaceFirst("WHERE \\? AND", "WHERE");
		query = query.replaceFirst("WHERE \\?", "WHERE");
		query = query.replaceFirst("\\? STATUS", "? AND STATUS");
		query = query.replaceFirst("' STATUS", "' AND STATUS");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		int i = 1;
		try {
			pstmt = conn.prepareStatement(query);
			if(location1 != null && !location1.equals("0")) {
				pstmt.setString(i++, location1);
				if(location2 != null && !location2.equals("0")) {
					pstmt.setString(i++, location2);
					if(location3 != null && !location3.equals("0")) {
						pstmt.setString(i++, location3);
					}
				}
			}
			
			if(option != null && !option.equals("0")) {
				pstmt.setString(i++, option);
			}
			
			if(word != null && !word.equals("")) {
				pstmt.setString(i++, word);
			}
			
			pstmt.setInt(i++, startRow);
			pstmt.setInt(i++, endRow);
			
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Product>();
			while(rs.next()) {
				Product p = new Product(rs.getInt("PRODUCT_NUM"), 
						rs.getString("TITLE"), 
						rs.getInt("PRICE"),
						rs.getInt("PRODUCT_COUNT"));
				p.setRankCode(rs.getInt("RANK_CODE"));
				p.setLocation1(rs.getString("LOCATION1"));
				p.setLocation2(rs.getString("LOCATION2"));
				p.setLocation3(rs.getString("LOCATION3"));
				
				list.add(p);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

}
