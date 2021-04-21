package member.model.dao;

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

import board.model.vo.Attachment;
import member.model.vo.Member;

public class MemberDAO {

	private Properties prop = new Properties();

	public MemberDAO() {
		String fileName = MemberDAO.class.getResource("/sql/member/member-query.properties").getPath();

		try {
			prop.load(new FileReader(fileName));

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int checkId(Connection conn, String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int result = 0;

		String query = prop.getProperty("checkId");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);

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

	public int checkName(Connection conn, String name) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int result = 0;

		String query = prop.getProperty("checkName");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, name);

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

	public int joinMember(Connection conn, Member joinMember) {
		PreparedStatement pstmt = null;
		int result = 0;

		String query = prop.getProperty("joinMember");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, joinMember.getId());
			pstmt.setString(2, joinMember.getPw());
			pstmt.setString(3, joinMember.getPwHint());
			pstmt.setString(4, joinMember.getPwAns());
			pstmt.setString(5, joinMember.getGender());
			pstmt.setString(6, joinMember.getEmail());
			pstmt.setString(7, joinMember.getPhone());
			pstmt.setString(8, joinMember.getNickName());
			pstmt.setString(9, joinMember.getmCheck());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Member loginMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		Member loginMember = null;

		String query = prop.getProperty("loginMember");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				loginMember = new Member(rs.getString("MEMBER_ID"), 
										 rs.getString("MEMBERNAME"),
										 rs.getInt("RANK_CODE"),
										 rs.getString("RANK_NAME"),
										 rs.getString("P_IMAGE"),
										 rs.getString("S_CHECK"),
										 rs.getDate("M_DATE"));
				loginMember.setInCheck(rs.getString("INCHECK"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return loginMember;
	}

	public Member getMemberInfo(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Member memberInfo = null;
		
		String query = prop.getProperty("getMemberInfo");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberInfo = new Member(rs.getString("PW_HINT"),
										rs.getString("PW_HINT_ANS"),
										rs.getString("EMAIL"),
										rs.getString("PHONE"),
										rs.getString("MEMBERNAME"),
										rs.getString("RANK_NAME"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return memberInfo;
	}

	public int updateInfo(Connection conn, String userId, Member updateInfo) {
		PreparedStatement pstmt = null;
		int result = 0;

		String query = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, updateInfo.getPwHint());
			pstmt.setString(2, updateInfo.getPwAns());
			pstmt.setString(3, updateInfo.getEmail());
			pstmt.setString(4, updateInfo.getPhone());
			pstmt.setString(5, updateInfo.getNickName());
			pstmt.setString(6, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updatePw(Connection conn, Member myInfo, String newPw) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updatePw");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newPw);
			pstmt.setString(2, myInfo.getId());
			pstmt.setString(3, myInfo.getPw());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
				
		return result;
	}

	public ArrayList<Member> selectMember(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		
		ArrayList<Member> list = null;
		
		String query = prop.getProperty("selectMember");
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(query);
			
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
			close(stmt);
		}
		
		return list;
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

	public int updateStopMember(Connection conn, String id) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateStopMember");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateProfileImg(Connection conn, String loginId, Attachment profileImg) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateProfileImg");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, profileImg.getFilePath() + profileImg.getChangeName());
			pstmt.setString(2, loginId);
			
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

	public ArrayList<String> findId(Connection conn, String option, String word) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> result = null;
		
		String query = prop.getProperty("findId");
		query = query.replaceFirst("\\?", option);
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, word);
			
			rs = pstmt.executeQuery();
			
			result = new ArrayList<String>();
			
			while(rs.next()) {
				result.add(rs.getString("MEMBER_ID"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return result;
	}

	public String findPW(Connection conn, String userId, String pwHint, String pwAns) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		String query = prop.getProperty("findPW");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, pwHint);
			pstmt.setString(3, pwAns);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("MEMBER_PW");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}
}
