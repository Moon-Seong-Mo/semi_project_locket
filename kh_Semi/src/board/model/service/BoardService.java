package board.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import board.model.dao.BoardDAO;
import board.model.vo.Attachment;
import board.model.vo.Board;
import board.model.vo.Comment;
import board.model.vo.PageInfo;

public class BoardService {

	public int getListCount() {
		Connection conn = getConnection();

		int result = new BoardDAO().getListCount(conn);

		close(conn);

		return result;
	}

	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDAO().selectList(conn, pi);

		close(conn);

		return list;
	}

	public int getSearchListCount(String word, String option) {
		Connection conn = getConnection();

		int result = new BoardDAO().getSearchListCount(conn, word, option);

		close(conn);

		return result;
	}

	public ArrayList<Board> selectSearchList(String word, String option, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDAO().selectSearchList(conn, word, option, pi);

		close(conn);

		return list;
	}

	public Board selectDetail(int bNum) {
		Connection conn = getConnection();

		BoardDAO bDAO = new BoardDAO();

		int result = bDAO.updateCount(conn, bNum);

		Board b = null;

		if (result > 0) {
			b = bDAO.selectDetail(conn, bNum);

			if (b != null) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} else {
			rollback(conn);
		}

		close(conn);

		return b;
	}

	public int insertBoard(Board b, ArrayList<Attachment> fileList, boolean notice) {
		Connection conn = getConnection();
		
		BoardDAO bDAO = new BoardDAO();
		
		int result1 = bDAO.insertBoard(conn, b, notice);
		int result2 = bDAO.insertFile(conn, fileList);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}

		close(conn);

		return result1;
	}

	public int deleteBoard(int bnum, String userId) {
		Connection conn = getConnection();
		
		BoardDAO bDAO = new BoardDAO();

		int result1 = bDAO.deleteBoard(conn, bnum, userId);
		int result2 = bDAO.deleteFile(conn, bnum);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}
		
		close(conn);

		return result1;
	}

	public int updateBoard(Board b, ArrayList<String> exFile, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();

		BoardDAO bDAO = new BoardDAO();
		
		int result1 = bDAO.updateBoard(conn, b);
		int result2 = bDAO.organizeFiles(conn, b.getBoardNum(), exFile);
		int result3 = bDAO.updateFile(conn, b.getBoardNum(), fileList);

		if (result1 > 0 && result2 != -1 && result3 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}
		
		close(conn);
		
		return result1;
	}

	public ArrayList<Attachment> selectFile(int bnum) {
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new BoardDAO().selectFile(conn, bnum);
		
		close(conn);
		
		return list;
	}

	public int updateFileCount(int fileNum) {
		Connection conn = getConnection();
		
		int result = new BoardDAO().updateFileCount(conn, fileNum);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int insertComment(Comment c) {
		Connection conn = getConnection();
		
		int result = new BoardDAO().insertComment(conn, c);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<Comment> selectComment(int bNum) {
		Connection conn = getConnection();
		
		ArrayList<Comment> list = new BoardDAO().selectComment(conn, bNum);
		
		close(conn);
		
		return list;
	}

	public int deleteComment(int cNum, String id) {
		Connection conn = getConnection();
		
		int result = new BoardDAO().deleteComment(conn, cNum, id);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<Board> selectNotice() {
		Connection conn = getConnection();
		
		ArrayList<Board> list = new BoardDAO().selectNotice(conn);
		
		close(conn);
		
		return list;
	}

	public int superBDelete(int bnum) {
	      Connection conn = getConnection();

	      int result = new BoardDAO().superBDelete(conn, bnum);

	      if (result > 0) {
	         commit(conn);
	      } else {
	         rollback(conn);
	      }      
	      close(conn);

	      return result;
	   }


}
