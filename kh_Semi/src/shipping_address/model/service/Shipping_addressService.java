package shipping_address.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import shipping_address.model.dao.Shipping_addressDAO;
import shipping_address.model.vo.Shipping_address;

public class Shipping_addressService {

	public ArrayList<Shipping_address> selectDeliList(String memberId) {
		Connection conn = getConnection();
		
		ArrayList<Shipping_address> list = new Shipping_addressDAO().selectDeliList(conn, memberId);
		
		close(conn);
		return list;
	}

	public int insertDeli(String memberId, Shipping_address sa) {
		Connection conn = getConnection();
		
		int result = new Shipping_addressDAO().updateDeli(conn, memberId, sa);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		} 
		close(conn);
		
		return result;
	}

	public int deleteSA(String id, int[] addNums) {
		Connection conn = getConnection();
		
		int result = new Shipping_addressDAO().deleteSA(conn, id, addNums);
		
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		} 
		close(conn);
		
		return result;
	}
	
}
