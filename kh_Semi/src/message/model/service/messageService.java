package message.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.vo.Member;
import message.model.dao.messageDAO;
import message.model.vo.Message;
import message.model.vo.PageInfo;

public class messageService {

	public ArrayList<Message> selectMessage(String loginId,PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Message> list = new messageDAO().selectMessage(conn, loginId, pi);
		
		close(conn);
		
		return list;
	}

	public int insertMessage(Message message) {
		Connection conn = getConnection();
		
		int result = new messageDAO().insertMessage(conn, message);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		return result;
	}

	public ArrayList<Member> selectSearchUser(String searchName) {
		Connection conn = getConnection();
		
		ArrayList<Member> list = new messageDAO().selectSearchUser(conn, searchName);
		
		close(conn);
		
		return list;
	}

	public Message selectDetail(int mNum) {
		Connection conn = getConnection();

		messageDAO mDAO = new messageDAO();

		Message m = mDAO.selectDetail(conn, mNum);

		close(conn);

		return m;
		
	}
	
	// 페이징 처리
	
	public int getListCount(String loginId) {
		Connection conn = getConnection();
		int result = new messageDAO().getListCount(conn, loginId); 
		
		close(conn);
		return result;
	}

	public int deleteMessage(String memberId, int[] selNum) {
		Connection conn = getConnection();
		
		int result = new messageDAO().deleteMessage(conn, memberId, selNum);
		
		close(conn);
		
		return result;
	}
	
	








	
	
	
	
	
	
	
	
	
}
