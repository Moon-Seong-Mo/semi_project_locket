package message.model.dao;

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

import member.model.vo.Member;
import message.model.vo.Message;
import message.model.vo.PageInfo;

public class messageDAO {
	
	private Properties prop = new Properties();
	public messageDAO() {
		String fileName = messageDAO.class.getResource("/sql/message/message-query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public ArrayList<Message> selectMessage(Connection conn, String loginId, PageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Message> Mlist = null;
		int startRow = (pi.getCurrentPage() -1) * pi.getBoardLimit() + 1;
		int endRow = startRow + pi.getBoardLimit() - 1;
		
		String query = prop.getProperty("getMessage");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			Mlist = new ArrayList<Message>();
			
			while(rset.next()) {
				Mlist.add(new Message(rset.getInt("MESSAGE_NUM"),
									  rset.getString("MEMBER_ID"),
									  rset.getString("MEMBERNAME"),
									  rset.getString("MESSAGE_C"),
									  rset.getDate("SEND_DATE")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return Mlist;
	}
	public int insertMessage(Connection conn, Message message) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertMessage");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, message.getMemberId());
			pstmt.setString(2, message.getSendId());
			pstmt.setString(3, message.getMContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	public ArrayList<Member> selectSearchUser(Connection conn, String searchName) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Member> list = null;
		
		String query = prop.getProperty("selectSearchUser");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, searchName);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Member>();
			
			while(rs.next()) {
				Member m = new Member();
				m.setId(rs.getString("MEMBER_ID"));
				m.setNickName(rs.getString("MEMBERNAME"));
				
				list.add(m);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int updateCount(Connection conn, int mNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("updateCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, mNum);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	public Message selectDetail(Connection conn, int mNum) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		Message m = null;
		
		String query = prop.getProperty("selectDetail");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, mNum);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				m = new Message(rset.getInt("MESSAGE_NUM"),
						  rset.getString("MEMBER_ID"),
						  rset.getString("MEMBERNAME"),
						  rset.getString("SEND_ID"),
						  rset.getString("MESSAGE_C"),
						  rset.getDate("SEND_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return m;
	}
	
	// 페이징 처리
	
	// 리스트 갯수
	public int getListCount(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = prop.getProperty("getListCount");
		
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
	public ArrayList<Message> selectDeliList(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Message> list = new ArrayList<Message>();
		
		String query = prop.getProperty("selectDeliList");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Message m = new Message(rset.getInt("MESSAGE_NUM"),
						  rset.getString("MEMBER_ID"),
						  rset.getString("SEND_ID"),
						  rset.getString("MESSAGE_C"),
						  rset.getDate("SEND_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int deleteMessage(Connection conn, String memberId, int[] selNum) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteMessage");
		
		try {
			for(int messageNum : selNum) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, memberId);
				pstmt.setInt(2, messageNum);
				
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
