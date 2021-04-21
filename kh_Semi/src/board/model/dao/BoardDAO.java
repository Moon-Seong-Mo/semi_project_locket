package board.model.dao;

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

import board.model.vo.Attachment;
import board.model.vo.Board;
import board.model.vo.Comment;
import board.model.vo.PageInfo;

public class BoardDAO {
	private Properties prop = new Properties();
	
	public BoardDAO() {
		String path = BoardDAO.class.getResource("/sql/board/board-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getListCount(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;

		String query = prop.getProperty("getListCount");

		try {
			stmt = conn.createStatement();

			rs = stmt.executeQuery(query);

			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}

		return result;
	}

	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Board> list = new ArrayList<Board>();

		String query = prop.getProperty("selectList");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board b = new Board(rs.getInt("BOARD_NUM"), 
									rs.getString("MEMBER_ID"), 
									rs.getString("MEMBERNAME"),
									rs.getString("TITLE"), 
									rs.getInt("VIEWS"), 
									rs.getTimestamp("CREATE_DATE"),
									rs.getTimestamp("MODIFY_DATE"));

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

	public ArrayList<Board> selectSearchList(Connection conn, String word, String option, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Board> list = new ArrayList<Board>();

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
				Board b = new Board(rs.getInt("BOARD_NUM"), 
									rs.getString("MEMBER_ID"), 
									rs.getString("MEMBERNAME"),
									rs.getString("TITLE"), 
									rs.getInt("VIEWS"), 
									rs.getTimestamp("CREATE_DATE"),
									rs.getTimestamp("MODIFY_DATE"));

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


	public Board selectDetail(Connection conn, int bNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Board b = null;
		
		String query = prop.getProperty("selectDetail");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b = new Board(rs.getInt("BOARD_NUM"), 
						rs.getInt("BOARD_LEVEL"),
						rs.getString("TITLE"), 
						rs.getString("BOARD_C"),
						rs.getString("MEMBER_ID"),
						rs.getString("MEMBERNAME"), 
						rs.getString("RANK_NAME"),
						rs.getInt("VIEWS"),
						rs.getTimestamp("CREATE_DATE"),
						rs.getTimestamp("MODIFY_DATE"),
						rs.getString("P_IMAGE"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	finally {
			close(rs);
			close(pstmt);
		}
		
		return b;
	}

	public int insertBoard(Connection conn, Board b, boolean notice) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertBoard");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setInt(2, notice ? 1 : 0);
			pstmt.setString(3, b.getBoardTitle());
			pstmt.setString(4, b.getBoardContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int updateBoard(Connection conn, Board b) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateBoard");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardContent());
			pstmt.setInt(3, b.getBoardNum());
			pstmt.setString(4, b.getBoardWriter());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteBoard(Connection conn, int bnum, String userId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteBoard");
		
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

	public int updateFile(Connection conn, int boardNum, ArrayList<Attachment> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateFile");
		
		try {
			for(int i = 0; i < fileList.size(); i++) {
				Attachment at = fileList.get(i);
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, boardNum);
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

	public int insertComment(Connection conn, Comment c) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertComment");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, c.getBoardNum());
			pstmt.setString(2, c.getMemberId());
			pstmt.setString(3, c.getComment());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Comment> selectComment(Connection conn, int bNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Comment> list = null;
		
		String query = prop.getProperty("selectComment");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);
			
			list = new ArrayList<Comment>();
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				list.add(new Comment(rs.getInt("COMMENT_NUM"),
									 rs.getInt("BOARD_NUM"),
									 rs.getInt("COMMENT_LEVEL"),
									 rs.getString("MEMBER_ID"),
									 rs.getString("MEMBERNAME"),
									 rs.getString("COMMENT_C"),
									 rs.getTimestamp("WR_DATE"),
									 rs.getTimestamp("MODIFY_DATE"),
									 rs.getString("STATUS"),
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

	public ArrayList<Board> selectNotice(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<Board> list = null;
		
		String query = prop.getProperty("selectNotice");
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(query);
			
			list = new ArrayList<Board>();
			while(rs.next()) {
				Board b = new Board(rs.getInt("BOARD_NUM"), 
						rs.getString("MEMBER_ID"), 
						rs.getString("MEMBERNAME"),
						rs.getString("TITLE"), 
						rs.getInt("VIEWS"), 
						rs.getTimestamp("CREATE_DATE"),
						rs.getTimestamp("MODIFY_DATE"));

				list.add(b);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return list;
	}

	public int superBDelete(Connection conn, int bnum) {
	      PreparedStatement pstmt = null;
	      int result = 0;
	      
	      String query = prop.getProperty("superBDelete");
	      //UPDATE BOARD SET STATUS = 'N' WHERE BOARD_NUM = ?
	      
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

}
