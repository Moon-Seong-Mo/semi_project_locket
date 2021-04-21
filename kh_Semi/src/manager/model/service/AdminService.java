package manager.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import manager.model.dao.AdminDAO;
import manager.model.vo.Report;
import member.model.vo.Member;
import message.model.vo.PageInfo;

public class AdminService {

	public int deleteMember(String[] checkId) {
		Connection conn = getConnection();

		int result = new AdminDAO().deleteMember(conn, checkId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public int stopMember(String[] checkId, int term, int option) {
		Connection conn = getConnection();

		AdminDAO aDAO = new AdminDAO();
		
		int result = aDAO.stopMember(conn, checkId, term);
		
		if(option == 1) {
			if(result > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} else if(option == 2) {
			if (result > 0) {
				int result2 = aDAO.setReportStatus(conn, checkId);
				
				if(result2 > 0) {
					commit(conn);
				} else {
					rollback(conn);
				}
				
			} else {
				rollback(conn);
			}
		}
		close(conn);

		return result;
	}
	
	public ArrayList<Report> selectReport(PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Report> list = new AdminDAO().selectReport(conn, pi);
		 
		close(conn);
		
		return list;
	}

	//페이징 처리
	public int getListCount() {
		Connection conn = getConnection();
		int result = new AdminDAO().getListCount(conn); 
		
		close(conn);
		return result;
	}

	public ArrayList<Report> Reportcatagory(String option) {
		Connection conn = getConnection();
		
		ArrayList<Report> list = new AdminDAO().Reportcatagory(conn, option);
		return list;
	}

	public int reportdelete(String[] checkId) {
		Connection conn = getConnection();
		
		AdminDAO aDAO = new AdminDAO();
		
		int result = aDAO.reportdelete(conn, checkId);
		
		if(result > 0) {
			int result2 = aDAO.setReportStatus(conn, checkId);
			
			if(result2 > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int getListSearchCount(Date sDate, Date eDate) {
		Connection conn = getConnection();
		
		int result = new AdminDAO().getListSearchCount(conn, sDate, eDate);
		
		close(conn);
		
		return result;
	}

	public ArrayList<Member> selectSearchMember(Date sDate, Date eDate) {
		Connection conn = getConnection();
		
		ArrayList<Member> list = new AdminDAO().selectSearchMember(conn, sDate, eDate);
		
		close(conn);
		
		return list;
	}

	public int insertReport(Report r) {
		Connection conn = getConnection();
		
		int result = new AdminDAO().insertReport(conn, r);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int getReportCount() {
		Connection conn = getConnection();
		
		int count = new AdminDAO().getReportCount(conn);
		
		close(conn);
		
		return count;
	}

	public int getReportOptionCount(String option) {
		Connection conn = getConnection();
		
		int count = new AdminDAO().getReportOptionCount(conn, option);
		
		close(conn);
				
		return count;
	}

	public ArrayList<Report> selectOptionReport(PageInfo pi, String option) {
		Connection conn = getConnection();
		
		ArrayList<Report> list = new AdminDAO().selectOptionReport(conn, pi, option);
		
		close(conn);
		
		return list;
	}



}
