package group.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import group.model.vo.Attachment;
import group.model.vo.Group;
import group.model.vo.PageInfo;
	

public class GroupDAO {
	
	private Properties prop = new Properties();
	
	public GroupDAO() {
		String fileName = GroupDAO.class.getResource("/sql/group/group_buy-query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getListCount(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getListCount");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
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

	public ArrayList<Group> selectList(Connection conn, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Group> list = new ArrayList<Group>();
		
		String query = prop.getProperty("selectList");
		
		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		
		int endRow = startRow + pi.getBoardLimit() - 1;
	
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Group g = new Group(rset.getInt("GROUP_NUM"), 
									rset.getString("TITLE"),
									rset.getInt("VIEWS"),
									rset.getString("EXPLAIN"),
									rset.getString("MEMBER_ID"),
									rset.getString("MEMBERNAME"),
									rset.getDate("G_DATE"),
									rset.getDate("START_DATE"),
									rset.getDate("END_DATE")
									);
				list.add(g);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		 
		return list;
	}

	public int getSearchListCount(Connection conn, String word, String option) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String query = prop.getProperty("getSearchListCount");
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

	public ArrayList<Group> selectSearchList(Connection conn, String word, String option, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Group> list = new ArrayList<Group>();

		String query = prop.getProperty("selectSearchList");
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
				Group g = new Group(rs.getInt("GROUP_NUM"),
									rs.getString("TITLE"), 
									rs.getInt("VIEWS"),
								    rs.getString("MEMBER_ID"),
								    rs.getDate("START_DATE"),
								    rs.getDate("END_DATE"),
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

	public int updateCount(Connection conn, int bNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public Group selectDetail(Connection conn, int bNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Group g = null;
		
		String query = prop.getProperty("selectDetail");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				g = new Group(rs.getInt("GROUP_NUM"), 
						rs.getString("TITLE"), 
						rs.getInt("VIEWS"),
						rs.getString("EXPLAIN"),
						rs.getInt("PRICE"), 
						rs.getDate("G_DATE"),
						rs.getDate("START_DATE"),
						rs.getDate("END_DATE"),
						rs.getString("MEMBERNAME"),
						rs.getString("MEMBER_ID"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	finally {
			close(rs);
			close(pstmt);
		}
		
		return g;
	}

	public int insertGroup(Connection conn, Group g) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertGroup");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, g.getMemberId());
			pstmt.setString(2, g.getGroupTitle());
			pstmt.setString(3, g.getExplain());
			pstmt.setInt(4, g.getPrice());
			pstmt.setDate(5, g.getStartDate());
			pstmt.setDate(6, g.getEndDate());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int updateGroup(Connection conn, Group g) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateGroup");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, g.getGroupTitle());
			pstmt.setString(2, g.getExplain());
			pstmt.setInt(3, g.getPrice());
			pstmt.setDate(4, g.getStartDate());
			pstmt.setDate(5, g.getEndDate());
			pstmt.setInt(6, g.getGroupNum());
			pstmt.setString(7, g.getMemberId());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteGroup(Connection conn, int bnum, String userId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteGroup");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bnum);
			pstmt.setString(2, userId);
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}
	
	public int insertFile(Connection conn, ArrayList<Attachment> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertAttachment");
		
		try {
			for(int i = 0; i < fileList.size(); i++) {
				Attachment at = fileList.get(i);
				
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, at.getOriginName());
				pstmt.setString(2, at.getChangeName());
				pstmt.setString(3, at.getFilePath());
				pstmt.setInt(4, at.getFileLevel());
				
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

	

	public ArrayList<Attachment> selectFile(Connection conn, int bnum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Attachment> list = null;
		
		String query = prop.getProperty("selectFile");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bnum);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Attachment>();
			
			while(rs.next()) {
				Attachment at = new Attachment();
				at.setFileId(rs.getInt("FILE_ID"));
				at.setOriginName(rs.getString("ORIGIN_NAME"));
				at.setChangeName(rs.getString("CHANGE_NAME"));
				at.setFilePath(rs.getString("FILE_PATH"));
				at.setUploadTime(rs.getDate("UPLOAD_DATE"));
				
				list.add(at);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
	
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	public int organizeFiles(Connection conn, int bNum, ArrayList<String> exFile) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("organizeFiles");
		
		if(exFile.size() > 0) {
			query += " AND FILE_ID NOT IN(" + String.join(", ", exFile) + ")";
		}
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateFile(Connection conn, int groupNum, ArrayList<Attachment> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateFile");
		
		try {
			for(int i = 0; i < fileList.size(); i++) {
				Attachment at = fileList.get(i);
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, groupNum);
				pstmt.setString(2, at.getOriginName());
				pstmt.setString(3, at.getChangeName());
				pstmt.setString(4, at.getFilePath());
				pstmt.setInt(5, at.getFileLevel());
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteFile(Connection conn, int bnum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("organizeFiles");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bnum);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int updateFileCount(Connection conn, int fileNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateFileCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, fileNum);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	 public Group selectApply(Connection conn, int bNum) {
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      Group g = null;
	      
	      String query = prop.getProperty("selectApply");
	      
	      try {
	         pstmt = conn.prepareStatement(query);
	         pstmt.setInt(1, bNum);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            g = new Group(rs.getInt("group_num"),
	                          rs.getString("title"),
	                          rs.getInt("price"));
	         }
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         close(rs);
	         close(pstmt);
	      }
	      
	      return g;
	   }

}
