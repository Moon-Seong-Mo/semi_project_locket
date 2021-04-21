package shipping_address.model.dao;

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

import shipping_address.model.vo.Shipping_address;

public class Shipping_addressDAO {
	
	private Properties prop = new Properties();
	
	public Shipping_addressDAO() {
		String fileName = Shipping_addressDAO.class.getResource("/sql/delivery/delivery-query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Shipping_address> selectDeliList(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Shipping_address> list = new ArrayList<Shipping_address>();
		
		String query = prop.getProperty("selectDeliList");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Shipping_address sa = new Shipping_address(rset.getInt("ADD_NUM"), 
														rset.getString("address_name"),
														rset.getString("address"),
														rset.getString("phone"),
														rset.getString("receiver"));

				list.add(sa);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public int updateDeli(Connection conn, String memberId, Shipping_address sa) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertDeli");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			pstmt.setString(2, sa.getAddress_name());
			pstmt.setString(3, sa.getAdderss());
			pstmt.setString(4, sa.getPhone());
			pstmt.setString(5, sa.getReceiver());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteSA(Connection conn, String id, int[] addNums) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteSA");
		
		try {
			for(int sa : addNums) {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, id);
				pstmt.setInt(2, sa);
				
				result += pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = 0;
		} finally {
			close(pstmt);
		}
		
		return result;
	}

}
