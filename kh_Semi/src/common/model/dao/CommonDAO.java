package common.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import board.model.vo.Board;
import common.model.vo.ProductMain;
import common.model.vo.RankInfo;
import group.model.vo.Group;
import product.model.vo.Product;

public class CommonDAO {
   
   private Properties prop = new Properties();

   public CommonDAO() {
      String path = CommonDAO.class.getResource("/sql/common/common-query.properties").getPath();
      try {
         prop.load(new FileReader(path));
      } catch (FileNotFoundException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }
   }

   public ArrayList<Product> selectSearchPList(Connection conn, String word) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Product> list = new ArrayList<Product>();

      String query = prop.getProperty("selectSearchPList");
//      selectSearchPList=SELECT * FROM (SELECT ROWNUM RNUM, P.* FROM (SELECT PRODUCT_NUM, MEMBER_ID, MEMBERNAME, TITLE, PRICE, PRODUCT_COUNT FROM PRODUCT JOIN MEMBER USING(MEMBER_ID) WHERE STATUS = 'Y' AND TITLE LIKE '%' || ? || '%' ORDER BY PRODUCT_NUM DESC) P) PRODUCT WHERE RNUM BETWEEN 1 AND 10
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, word);
         
         rs = pstmt.executeQuery();
         
         while (rs.next()) {
            Product p = new Product(rs.getInt("PRODUCT_NUM"), 
                              rs.getString("MEMBERNAME"), 
                              rs.getString("TITLE"), 
                              rs.getInt("PRICE"),
                              rs.getInt("PRODUCT_COUNT"));

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

   public ArrayList<Board> selectSearchBList(Connection conn, String word) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Board> list = new ArrayList<Board>();

      String query = prop.getProperty("selectSearchBList");
//      selectSearchBList=SELECT * FROM (SELECT ROWNUM RNUM, B.* FROM (SELECT BOARD_NUM, TITLE, MEMBERNAME, VIEWS,CREATE_DATE FROM BOARD JOIN MEMBER USING(MEMBER_ID) WHERE STATUS = 'Y' AND TITLE LIKE '%' || ? || '%' AND BOARD_LEVEL = 0 ORDER BY BOARD_NUM DESC) B) BOARD WHERE RNUM BETWEEN 1 AND 10
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, word);
         rs = pstmt.executeQuery();
         
         while (rs.next()) {
            Board b = new Board(rs.getInt("BOARD_NUM"), 
                           rs.getString("TITLE"), 
                           rs.getString("MEMBERNAME"),
                           rs.getInt("VIEWS"),
                           rs.getTimestamp("CREATE_DATE"));

            list.add(b);
         }

      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         close(rs);
         close(pstmt);
      }
      
      return list;
   }

   public ArrayList<Group> selectSearchGList(Connection conn, String word) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Group> list = new ArrayList<Group>();

      String query = prop.getProperty("selectSearchGList");
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, word);
         rs = pstmt.executeQuery();
         
         while (rs.next()) {
            Group g = new Group(rs.getInt("GROUP_NUM"), 
            					rs.getString("TITLE"), 
            					rs.getInt("VIEWS"),
            					rs.getDate("G_DATE"),
            					rs.getString("MEMBERNAME"));

            list.add(g);
         }

      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         close(rs);
         close(pstmt);
      }
      
      return list;
   }

   public ArrayList<RankInfo> selectTOM(Connection conn, int first, int last) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RankInfo> list = null;
		
		String query = prop.getProperty("selectTOM");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, first);
			pstmt.setInt(2, last);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<RankInfo>();
			
			while(rs.next()) {
				list.add(new RankInfo(rs.getInt("RNUM"), rs.getString("MEMBER"), rs.getString("MEMBERNAME"), rs.getInt("COUNT")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

   public ArrayList<ProductMain> selectPopularItem(Connection conn, int count) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductMain> list = null;
		
		String query = prop.getProperty("selectPopularItem");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, count);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<ProductMain>();
			
			while(rs.next()) {
				list.add(new ProductMain(rs.getInt("PRODUCT_NUM"),
										 rs.getString("CATEGORY"),
										 rs.getString("TITLE"),
										 rs.getInt("PRICE"),
										 rs.getString("CHANGE_NAME")));
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