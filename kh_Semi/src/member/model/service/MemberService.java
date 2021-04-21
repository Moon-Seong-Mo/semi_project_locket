package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import board.model.vo.Attachment;
import member.model.dao.MemberDAO;
import member.model.vo.Member;
import message.model.vo.PageInfo;

public class MemberService {

	public int checkId(String id) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();

		int result = mDAO.checkId(conn, id);

		close(conn);

		return result;
	}

	public int checkName(String name) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();

		int result = mDAO.checkName(conn, name);

		close(conn);

		return result;
	}

	public int joinMember(Member joinMember) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();

		int join = mDAO.joinMember(conn, joinMember);

		if (join > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return join;
	}

	public Member loginMember(Member member) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();
		
		Member loginMember = mDAO.loginMember(conn, member);
		
		close(conn);
		
		return loginMember;
	}

	public Member getMemberInfo(String loginId) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();
		
		Member memberInfo = mDAO.getMemberInfo(conn, loginId);
		
		close(conn);
		
		return memberInfo;
	}

	public int updateInfo(String userId, Member updateInfo) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();

		int result = mDAO.updateInfo(conn, userId, updateInfo);
		
		close(conn);
		
		return result;
	}

	public int updatePw(Member myInfo, String newPw) {
		Connection conn = getConnection();

		MemberDAO mDAO = new MemberDAO();

		int result = mDAO.updatePw(conn, myInfo, newPw);
		
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);
		
		return result;
	}

	public ArrayList<Member> selectMember(PageInfo pi) {
		Connection conn = getConnection();
		
		ArrayList<Member> list = new MemberDAO().selectMember(conn);
		
		close(conn);
		
		return list;
	}

	public ArrayList<Member> selectSearchMember(Date sDate, Date eDate) {
		Connection conn = getConnection();
		
		ArrayList<Member> list = new MemberDAO().selectSearchMember(conn, sDate, eDate);
		
		close(conn);
		
		return list;
	}

	public int updateStopMember(String id) {
		Connection conn = getConnection();
		
		int result = new MemberDAO().updateStopMember(conn, id);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int updateProfileImg(String loginId, Attachment profileImg) {
		Connection conn = getConnection();
		
		int result = new MemberDAO().updateProfileImg(conn, loginId, profileImg);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int getListCount() {
	      Connection conn = getConnection();
	      int result = new MemberDAO().getListCount(conn); 
	      
	      close(conn);
	      return result;
	   }
	
	public ArrayList<String> findId(String option, String word) {
		Connection conn = getConnection();
		
		ArrayList<String> result = new MemberDAO().findId(conn, option, word);
		
		close(conn);
		
		return result;
	}

	public String findPW(String userId, String pwHint, String pwAns) {
		Connection conn = getConnection();
		
		String result = new MemberDAO().findPW(conn, userId, pwHint, pwAns);
		
		close(conn);
		
		return result;
	}


}
