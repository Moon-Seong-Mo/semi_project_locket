package apply.model.dao;

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

import apply.model.vo.Apply;
import apply.model.vo.PageInfo;
import member.model.vo.Member;

public class ApplyDAO {
	private Properties prop = new Properties();

	public ApplyDAO() {
		String path = ApplyDAO.class.getResource("/sql/apply/apply-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String createMerchantUid(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		String merchantUid = null;

		String query = prop.getProperty("createMerchantUid");
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);

			if (rset.next()) {
				merchantUid = rset.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}

		return merchantUid;
	}

	public int insertApplyInfo(Connection conn, Apply a) {
		PreparedStatement pstmt = null;
		int result = 0;

		String query = prop.getProperty("insertApplyInfo");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, a.getgNum());
			pstmt.setString(2, a.getMemberId());
			pstmt.setInt(3, a.getAmount());
			pstmt.setString(4, a.getMerchant_uid());
			pstmt.setString(5, a.getAddress());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int getListCount(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("getListCount");

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

	public ArrayList<Apply> selectList_C(Connection conn, PageInfo pi, String id) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Apply> list = new ArrayList<Apply>();

		String query = prop.getProperty("selectList_C");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			

			rset = pstmt.executeQuery();

			while (rset.next()) {
				Apply a = new Apply(rset.getInt("group_num"), rset.getString("title"), rset.getString("membername"),
						rset.getString("address"), rset.getInt("amount"), rset.getDate("apply_date"),
						rset.getString("merchant_uid"), rset.getInt("NUM"));

				list.add(a);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public ArrayList<Apply> selectList_A(Connection conn, PageInfo pi, int gNum) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Apply> list = new ArrayList<Apply>();

		String query = prop.getProperty("selectList_A");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, gNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			

			rset = pstmt.executeQuery();

			while (rset.next()) {
				Apply a = new Apply(rset.getInt("group_num"), rset.getInt("amount"), rset.getString("membername"),
						rset.getDate("apply_date"), rset.getString("merchant_uid"));
				a.setAmountNum(rset.getInt("NUM"));
				a.setAddress(rset.getString("ADDRESS"));
				
				list.add(a);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public int getSerachListCount(Connection conn, String word, String option) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("getSerachListCount");
		query = query.replaceFirst("\\?", option);

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, word);

			rset = pstmt.executeQuery();

			if (rset.next()) {
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

	public ArrayList<Apply> selectSearchList(Connection conn, String word, String option, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Apply> list = new ArrayList<Apply>();

		String query = prop.getProperty("selectSearchList");
		query = query.replaceFirst("\\?", option);

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, word);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				Apply a = new Apply(rset.getInt("group_num"), rset.getString("member_id"), rset.getInt("amount"),
						rset.getDate("apply_date"), rset.getString("merchant_uid"));

				list.add(a);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

//	--------------------------------------------------------------------------------------------------------------
	public Member selectMember(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member buyMember = null;
		String query = prop.getProperty("selectApplyMember");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);

			rset = pstmt.executeQuery();
			if (rset.next()) {
				buyMember = new Member(rset.getString("MEMBER_ID"), rset.getString("MEMBERNAME"),
						rset.getString("EMAIL"), rset.getString("PHONE"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return buyMember;
	}

	public Apply selectUserApplyInfo(Connection conn, String userId, int bNum) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Apply a = null;
		String query = prop.getProperty("selectApply");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setInt(2, bNum);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				a = new Apply(rset.getInt("group_num"), rset.getString("member_id"), rset.getInt("amount"),
						rset.getDate("apply_date"), rset.getString("merchant_uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return a;
	}

	public int selectApplyList(Connection conn, int bNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		String query = prop.getProperty("selectApplyList");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
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

	public int getGroupListCount(Connection conn, int gNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		String query = prop.getProperty("getGroupListCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, gNum);
			
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

	public int getUserListCount(Connection conn, String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		String query = prop.getProperty("getUserListCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			
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

}
