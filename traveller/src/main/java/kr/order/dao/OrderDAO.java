package kr.order.dao;

public class OrderDAO {
	private static OrderDAO instance = new OrderDAO();
	
	public static OrderDAO getInstance() {
		return instance;
	}
	
	private OrderDAO() {}
	
}
