package product.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import board.model.vo.PageInfo;
import product.model.dao.ProductDAO;
import product.model.vo.Deal;
import product.model.vo.PComment;
import product.model.vo.Product;
import product.model.vo.Product_File;
import product.model.vo.WishList;

public class ProductService {

	public int getMyListCount(String writer) {
		Connection conn = getConnection();
		
		int result = new ProductDAO().getMyListCount(conn, writer);
		
		close(conn);
		return result;
	}

	public int registerProduct(String writer, Product p) {
		Connection conn = getConnection();

		int result = new ProductDAO().registerProduct(conn, writer, p);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	public int registerProduct(ArrayList<Product_File> fileList) {
		Connection conn = getConnection();

		int result = new ProductDAO().registerProduct(conn, fileList);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	public int registerProduct(String writer, Product p, ArrayList<Product_File> fileList) {
		Connection conn = getConnection();

		int result1 = new ProductDAO().registerProduct(conn, writer, p);
		int result2 = new ProductDAO().registerProduct(conn, fileList);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}
		close(conn);

		return result1;
	}

	public ArrayList<Product> selectMyPList(String writer, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectMyPList(conn, writer, pi);

		close(conn);
		return list;
	}

	public ArrayList<Product_File> selectMyPList() {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectMyPFList(conn);

		close(conn);
		return list;
	}

	public int addWishlist(String user, int pId) {
		Connection conn = getConnection();

		int result = new ProductDAO().addWishlist(conn, user, pId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public ArrayList<WishList> selectWish() {
		Connection conn = getConnection();

		ArrayList<WishList> w = new ProductDAO().selectWish(conn);

		if (w != null) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return w;
	}

	public int getProductCount() {
		Connection conn = getConnection();

		int result = new ProductDAO().getProductCount(conn);

		close(conn);

		return result;
	}

	public ArrayList<Product> selectPList(PageInfo pi) {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectPList(conn, pi);

		close(conn);
		return list;
	}

	public ArrayList<Product_File> selectPList() {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectPFList(conn);

		close(conn);
		return list;
	}

	public ArrayList<Product> selectWList(String user, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectWList(conn, user, pi);

		close(conn);
		return list;
	}

	public ArrayList<Product_File> selectWFList(int i) {
		Connection conn = getConnection();

		ArrayList list = null;

		list = new ProductDAO().selectPFList(conn);

		close(conn);
		return list;
	}

	public int deleteWishlist(String user, int pId) {
		Connection conn = getConnection();

		int result = new ProductDAO().deleteWishlist(conn, user, pId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	// wishlist 갯수 가져오기
	public int getWListCount(String user) {
		Connection conn = getConnection();

		int result = new ProductDAO().getWishCount(conn, user);

		close(conn);

		return result;
	}

	// 여기부터 복붙//
	public Product detailProduct(int pId) {
		Connection conn = getConnection();

		ProductDAO pdao = new ProductDAO();

		int result = pdao.updateCount(conn, pId);
		
		Product p = null;

		if (result > 0) {
			p = pdao.detailProduct(conn, pId);

			if (p != null) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} else {
			rollback(conn);
		}
		close(conn);
		return p;
	}

	public Product selectDetailProduct(int pId) {
		Connection conn = getConnection();

		ProductDAO pdao = new ProductDAO();
		Product p = null;

		p = pdao.detailProduct(conn, pId);

		close(conn);

		return p;
	}

	public ArrayList<Product_File> detailPFile(int pId) {
		Connection conn = getConnection();

		ArrayList<Product_File> filelist = new ProductDAO().detailPFile(conn, pId);

		close(conn);

		return filelist;
	}

	public ArrayList<PComment> selectPComment(int pId) {
		Connection conn = getConnection();

		ArrayList<PComment> list = new ProductDAO().selectPComment(conn, pId);

		close(conn);

		return list;
	}

	public int insertComment(PComment pc) {
		Connection conn = getConnection();

		int result = new ProductDAO().insertComment(conn, pc);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	public int deleteComment(int cNum, String id) {
		Connection conn = getConnection();

		int result = new ProductDAO().deleteComment(conn, cNum, id);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	public int deleteProduct(int pId, String userId) {
		Connection conn = getConnection();

		ProductDAO pDAO = new ProductDAO();

		int result1 = pDAO.deleteProduct(conn, pId, userId);
		int result2 = pDAO.deleteFile(conn, pId);

		if (result1 > 0 && result2 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}

		close(conn);

		return result1;
	}

	// 중고물품 검색어로 검색
	public int getSearchListCount(String word, String option) {
		Connection conn = getConnection();

		int result = new ProductDAO().getSearchListCount(conn, word, option);

		close(conn);

		return result;
	}

	public ArrayList<Product> selectSearchList(String word, String option, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Product> list = new ProductDAO().selectSearchList(conn, word, option, pi);

		close(conn);

		return list;
	}

	public int updateProduct(String writer, Product p, ArrayList<Product_File> fileList, String[] changeFiles) {
		Connection conn = getConnection();

		ProductDAO pDAO = new ProductDAO();

		int result1 = pDAO.updateProduct(conn, writer, p);
		int result2 = pDAO.deleteFiles(conn, changeFiles);
		int result3 = pDAO.updateProductFile(conn, p.getProductId(), fileList);

		if (result1 > 0 && result2 != -1 && result3 != -1) {
			commit(conn);
		} else {
			rollback(conn);
			result1 = 0;
		}

		return result1;
	}

	public int insertBuying(String user, int pId, String pTitle, String receiver) {
		Connection conn = getConnection();

		int result = new ProductDAO().insertBuying(conn, user, pId, pTitle, receiver);

		close(conn);

		return result;
	}

	public ArrayList<Deal> selectADeal(String loginId, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Deal> list = new ProductDAO().selectADeal(conn, loginId, pi);

		close(conn);

		return list;
	}

	public ArrayList<Deal> selectRDeal(String loginId, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Deal> list = new ProductDAO().selectRDeal(conn, loginId, pi);

		close(conn);

		return list;
	}

	public int getADealCount(String loginId) {
		Connection conn = getConnection();
		int result = new ProductDAO().getADealCount(conn, loginId);

		close(conn);
		return result;
	}

	public int getRDealCount(String loginId) {
		Connection conn = getConnection();
		int result = new ProductDAO().getADealCount(conn, loginId);

		close(conn);
		return result;
	}

	public int refuseRDeal(String[] dealId, int[] selNum) {
		Connection conn = getConnection();

		int result = new ProductDAO().refuseRDeal(conn, dealId, selNum);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	public int okayRDeal(String memberId, int[] selNum, String[] dealId) {
		Connection conn = getConnection();

		ProductDAO pDAO = new ProductDAO();

		int result1 = pDAO.okayRDeal(conn, dealId, selNum);

		if (result1 > 0) {
			int result2 = pDAO.changeCstatue(conn, selNum);
			if (result2 > -1) {
				int result3 = pDAO.changePstatus(conn, dealId, selNum);
				if (result3 > 0) {
					int result4 = pDAO.checkMemberRank(conn, memberId, dealId);
					if (result4 > 0) {
						commit(conn);
					} else {
						rollback(conn);
					}

				} else {
					rollback(conn);
				}
			} else {
				rollback(conn);
			}

		} else {
			rollback(conn);
		}

		close(conn);

		return result1;
	}

	public int cancelADeal(String memberId, int[] selNum) {
		Connection conn = getConnection();

		int result = new ProductDAO().cancelADeal(conn, memberId, selNum);

		close(conn);

		return result;
	}

	public int countDeal(String memberId) {
		Connection conn = getConnection();

		int result = new ProductDAO().countDeal(conn, memberId);

		close(conn);

		return result;
	}

	public int superDelete(int pId) {
		Connection conn = getConnection();

		ProductDAO pDAO = new ProductDAO();

		int result = pDAO.superDelete(conn, pId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public ArrayList<String> selectLocation() {
		Connection conn = getConnection();

		ArrayList<String> list = new ProductDAO().selectLocation(conn);

		close(conn);

		return list;
	}

	public ArrayList<String> selectSiGunGu(String sido) {
		Connection conn = getConnection();

		ArrayList<String> list = new ProductDAO().selectSiGunGu(conn, sido);

		close(conn);

		return list;
	}

	public ArrayList<String> selectDong(String sido, String sigungu) {
		Connection conn = getConnection();

		ArrayList<String> list = new ProductDAO().selectDong(conn, sido, sigungu);

		close(conn);

		return list;
	}

	public Product detailProductAdmin(int pId) {
		Connection conn = getConnection();

		Product p = new ProductDAO().detailProductAdmin(conn, pId);

		close(conn);

		return p;
	}

	public int getSearchListCount(String option, String location1, String location2, String location3, String option2,
			String word) {
		Connection conn = getConnection();

		int count = new ProductDAO().getSearchListCount(conn, option, location1, location2, location3, option2, word);

		close(conn);

		return count;
	}

	public ArrayList<Product> selectSearchList(String location1, String location2, String location3, String option,
			String option2, String word, PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Product> list = new ProductDAO().selectSearchList(conn, location1, location2, location3, option, option2, word, pi);

		close(conn);

		return list;
	}

}
