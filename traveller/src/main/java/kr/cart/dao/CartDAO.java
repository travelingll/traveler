package kr.cart.dao;

public class CartDAO {
	//싱글턴 패턴 작성
	private static CartDAO instance = new CartDAO();
	
	public static CartDAO getInstance() {
		return instance;
	}
	
	private CartDAO () {}
}
