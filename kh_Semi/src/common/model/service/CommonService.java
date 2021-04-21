package common.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import board.model.vo.Board;
import common.model.dao.CommonDAO;
import common.model.vo.ProductMain;
import common.model.vo.RankInfo;
import group.model.vo.Group;
import product.model.vo.Product;

public class CommonService {

	public ArrayList<Product> selectSearchPList(String word) {
		Connection conn = getConnection();

		ArrayList<Product> list = new CommonDAO().selectSearchPList(conn, word);

		close(conn);

		return list;
	}

	public ArrayList<Board> selectSearchBList(String word) {
		Connection conn = getConnection();

		ArrayList<Board> list = new CommonDAO().selectSearchBList(conn, word);

		close(conn);

		return list;
	}

	public ArrayList<Group> selectSearchGList(String word) {
		Connection conn = getConnection();

		ArrayList<Group> list = new CommonDAO().selectSearchGList(conn, word);

		close(conn);

		return list;
	}

	public ArrayList<RankInfo> selectTOM(int first, int last) {
		Connection conn = getConnection();

		ArrayList<RankInfo> list = new CommonDAO().selectTOM(conn, first, last);

		close(conn);

		return list;
	}

	public ArrayList<ProductMain> selectPopularItem(int count) {
		Connection conn = getConnection();

		ArrayList<ProductMain> list = new CommonDAO().selectPopularItem(conn, count);

		close(conn);

		return list;
	}
}