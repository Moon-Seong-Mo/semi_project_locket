package manager.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import manager.model.vo.Report;
import member.model.vo.Member;
import message.model.vo.PageInfo;

public class AdminDAO {
	
	private Properties prop = new Properties();
	
	public AdminDAO() {
		String fileName = AdminDAO.class.getResource("/sql/manager/manager-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int deleteMember(Connection conn, String[] checkId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteMember");
		
		try {
			for(String id : checkId) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, id);
				result += pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int stopMember(Connection conn, String[] checkId, int term) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("stopMember");
		
		try {
			for(String id : checkId) {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, term);
				pstmt.setString(2, id);
				result += pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	// 리스트 갯수
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

	public ArrayList<Report> selectReport(Connection conn, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Report> list = null;
		int startRow = (pi.getCurrentPage() -1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		String query = prop.getProperty("getReport");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<Report>();
			
			while(rset.next()) {
				list.add (new Report(rset.getInt("R_NUM"),
									rset.getString("R_CATEGORY"),
									rset.getString("MEMBER_ID"),
									rset.getString("MEMBER_ID2"),
									rset.getString("R_REASON"),
									rset.getDate("R_DATE"),
									rset.getString("R_PATH")));			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return list; 
	}
	

	public ArrayList<Report> Reportcatagory(Connection conn, String option) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Report> list = new ArrayList<Report>();
		
		String query = prop.getProperty("Reportcatagory");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, option);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Report r = new Report(rset.getInt("R_NUM"),
									  rset.getString("R_CATEGORY"),
									  rset.getString("MEMBER_ID"),
									  rset.getString("MEMBER_ID2"),
									  rset.getString("R_REASON"),
									  rset.getDate("DATE"),
									  rset.getString("PATH"));	
				list.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int reportdelete(Connection conn, String[] checkId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteMember");
		
		try {
			for(String id : checkId) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, id);
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int getListSearchCount(Connection conn, Date sDate, Date eDate) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		String query = prop.getProperty("getListSearchCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setDate(1, sDate);
			pstmt.setDate(2, eDate);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(rs);
		}
		
		return result;
	}

	public ArrayList<Member> selectSearchMember(Connection conn, Date sDate, Date eDate) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<Member> list = null;
		
		String query = prop.getProperty("selectSearchMember");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setDate(1, sDate);
			pstmt.setDate(2, eDate);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Member>();
			
			while(rs.next()) {
				list.add(new Member(rs.getString("MEMBER_ID"),
									rs.getString("MEMBERNAME"),
									rs.getString("RANK_NAME"),
									rs.getDate("JOIN_DATE"),
									rs.getString("INCHECK"),
									rs.getString("S_CHECK")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int insertReport(Connection conn, Report r) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertReport");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, r.getCategory());
			pstmt.setString(2, r.getMemberId());
			pstmt.setString(3, r.getMemberId2());
			pstmt.setString(4, r.getReason());
			pstmt.setString(5, r.getPath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int getReportCount(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		String query = prop.getProperty("getReportCount");
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(query);
			
			if(rs.next()) {
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

	public int getReportOptionCount(Connection conn, String option) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		String query = prop.getProperty("getReportOptionCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, option);
			
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

	public ArrayList<Report> selectOptionReport(Connection conn, PageInfo pi, String option) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Report> list = null;
		int startRow = (pi.getCurrentPage() -1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		String query = prop.getProperty("selectOptionReport");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, option);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<Report>();
			
			while(rset.next()) {
				Report r = new Report(rset.getInt("R_NUM"),
						  rset.getString("R_CATEGORY"),
						  rset.getString("MEMBER_ID"),
						  rset.getString("MEMBER_ID2"),
						  rset.getString("R_REASON"),
						  rset.getDate("R_DATE"),
						  rset.getString("R_PATH"));	
				list.add(r);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}

	public int setReportStatus(Connection conn, String[] checkId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("setReportStatus");
		
		try {
			for(String id : checkId) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, id);
				
				result += pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

}
