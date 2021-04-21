package group.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;


import group.model.dao.GroupDAO;
import group.model.vo.Group;
import group.model.vo.Attachment;
import group.model.vo.PageInfo;

public class GroupService {

	public int getListCount() {
		Connection conn = getConnection();
		
		int result = new GroupDAO().getListCount(conn);
		
		close(conn);
		return result;
	}

	public ArrayList<Group> selectList(PageInfo pi) {
		Connection conn = getConnection();
		ArrayList<Group> list = new GroupDAO().selectList(conn, pi);
		close(conn);
		return list;
	}

	public int getSearchListCount(String word, String option) {
		Connection conn = getConnection();

		int result = new GroupDAO().getSearchListCount(conn, word, option);

		close(conn);

		return result;
	}

	public ArrayList<Group> selectSearchList(String word, String option, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Group> list = new GroupDAO().selectSearchList(conn, word, option, pi);

		close(conn);

		return list;
	}
	
	public Group selectDetail(int bNum) {
		Connection conn = getConnection();
		
		GroupDAO gDAO = new GroupDAO();

		int result = gDAO.updateCount(conn, bNum);

		Group g = null;

		if (result > 0) {
			g = gDAO.selectDetail(conn, bNum);

			if (g != null) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} else {
			rollback(conn);
		}

		close(conn);

		return g;
	}

	public int insertGroup(Group g, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();
		
		GroupDAO gDAO = new GroupDAO();

		int result1 = gDAO.insertGroup(conn, g);
		int result2 = gDAO.insertFile(conn, fileList);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}

		close(conn);

		return result1;
	}
	
	public int deleteGroup(int bnum, String userId) {
		Connection conn = getConnection();
		
		GroupDAO gDAO = new GroupDAO();

		int result1 = gDAO.deleteGroup(conn, bnum, userId);
		int result2 = gDAO.deleteFile(conn, bnum);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}
		
		close(conn);

		return result1;
	}
	
	public int updateGroup(Group g, ArrayList<String> exFile, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();

		GroupDAO gDAO = new GroupDAO();
		
		int result1 = gDAO.updateGroup(conn, g);
		int result2 = gDAO.organizeFiles(conn, g.getGroupNum(), exFile);
		int result3 = gDAO.updateFile(conn, g.getGroupNum(), fileList);

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
		
		ArrayList<Attachment> list = new GroupDAO().selectFile(conn, bnum);
		
		close(conn);
		
		return list;
	}
	
	public int updateFileCount(int fileNum) {
		Connection conn = getConnection();
		
		int result = new GroupDAO().updateFileCount(conn, fileNum);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	  public Group selectApply(int bNum) {
		 Connection conn = getConnection();	      
		 Group g = new GroupDAO().selectApply(conn, bNum);
		      
		 	close(conn);
		      
		 	return g;
	}
	
}
