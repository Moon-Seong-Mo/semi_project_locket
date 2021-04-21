package apply.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import apply.model.dao.ApplyDAO;
import apply.model.vo.Apply;
import apply.model.vo.PageInfo;
import member.model.vo.Member;

public class ApplyService {

	public String createMerchantUid() {
		Connection conn = getConnection();
		ApplyDAO applyDao = new ApplyDAO();
		return applyDao.createMerchantUid(conn);
	}

	public int insertApplyInfo(Apply a) {
		Connection conn = getConnection();
		
		int result = new ApplyDAO().insertApplyInfo(conn, a);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		return result;
	}
	
	public int getListCount() {
		Connection conn = getConnection();
		ApplyDAO applyDao = new ApplyDAO();
		return applyDao.getListCount(conn);
	}
	
	public ArrayList<Apply> selectList_C(PageInfo pi, String id) {
		Connection conn = getConnection();
		
		ArrayList<Apply> list = new ApplyDAO().selectList_C(conn, pi, id);
		
		close(conn);
		
		return list;
	}
	
	public ArrayList<Apply> selectList_A(PageInfo pi, int gNum) {
		Connection conn = getConnection();
		
		ArrayList<Apply> list = new ApplyDAO().selectList_A(conn, pi, gNum);
		
		close(conn);
		
		return list;
	}

	public int getSerachListCount(String word, String option) {
		Connection conn =getConnection();
		
		int result = new ApplyDAO().getSerachListCount(conn, word, option);
		
		close(conn);
		
		return result;
	}

	public ArrayList<Apply> selectSearchList(String word, String option, PageInfo pi) {
		Connection conn =getConnection();
		
		ArrayList<Apply> list = new ApplyDAO().selectSearchList(conn, word, option, pi);
		
		close(conn);
		return list;
	}
// --------------------------------------------------------------------------------------------------------------
	public Member selectMember(String memberId) {
		Connection conn = getConnection();
		
		Member buyMember = new ApplyDAO().selectMember(conn, memberId);
		
		close(conn);
		
		return buyMember;
	}

	public Apply selectUserApplyInfo(String userId, int bNum) {
		Connection conn = getConnection();
		
		Apply a = new ApplyDAO().selectUserApplyInfo(conn, userId, bNum);
		
		close(conn);
		
		return a;
	}

	public int selectApplyList(int bNum) {
		Connection conn = getConnection();
		
		int count = new ApplyDAO().selectApplyList(conn, bNum);
		
		close(conn);
		
		return count;
	}

	public int getGroupListCount(int gNum) {
		Connection conn = getConnection();
		
		int count = new ApplyDAO().getGroupListCount(conn, gNum);
		
		close(conn);
		
		return count;
	}

	public int getUserListCount(String id) {
		Connection conn = getConnection();
		
		int count = new ApplyDAO().getUserListCount(conn, id);
		
		close(conn);
		
		return count;
	}

	
}
