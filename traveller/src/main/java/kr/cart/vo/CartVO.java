package kr.cart.vo;

import java.sql.Date;

public class CartVO {
	private int cart_num;
	private int mem_num;
	private int item_num;
	private Date cart_regdate;
	private int cart_count;
	
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public Date getCart_regdate() {
		return cart_regdate;
	}
	public void setCart_regdate(Date cart_regdate) {
		this.cart_regdate = cart_regdate;
	}
	public int getCart_count() {
		return cart_count;
	}
	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}
}
