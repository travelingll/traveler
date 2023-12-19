package kr.order.vo;

import java.sql.Date;

public class OrderVO {
	private int order_num;
	private String item_name;
	private int order_price;
	private int order_custprice;
	private int mem_num;
	private int order_status;
	private Date order_date;
	private Date order_modate;
	private String notice;
	private int payment;
	
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public int getOrder_custprice() {
		return order_custprice;
	}
	public void setOrder_custprice(int order_custprice) {
		this.order_custprice = order_custprice;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getOrder_status() {
		return order_status;
	}
	public void setOrder_status(int order_status) {
		this.order_status = order_status;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public Date getOrder_modate() {
		return order_modate;
	}
	public void setOrder_modate(Date order_modate) {
		this.order_modate = order_modate;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
}
