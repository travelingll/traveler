package kr.item.vo;

import java.sql.Date;

import kr.order.dao.OrderDAO;

public class ItemVO {
	
	private int item_num;
	private String item_name;
	private String item_content;
	private int item_price;
	private String item_img1;
	private String item_img2;
	private String item_img3;
	private String item_img4;
	private String item_img5;
	private String item_img6;
	private String item_st1;
	private String item_st2;
	private String item_st3;
	private String date_start;
	private String date_end;
	private String status;
	private Date reg_date;
	private Date modifydate;
	private int quantity;
	private String item_case;
	private int orderCount=0;
	
	
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public String getItem_case() {
		return item_case;
	}
	public void setItem_case(String item_case) {
		this.item_case = item_case;
	}
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_content() {
		return item_content;
	}
	public void setItem_content(String item_content) {
		this.item_content = item_content;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int price) {
		this.item_price = price;
	}
	public String getItem_img1() {
		return item_img1;
	}
	public void setItem_img1(String item_img1) {
		this.item_img1 = item_img1;
	}
	public String getItem_img2() {
		return item_img2;
	}
	public void setItem_img2(String item_img2) {
		this.item_img2 = item_img2;
	}
	public String getItem_img3() {
		return item_img3;
	}
	public void setItem_img3(String item_img3) {
		this.item_img3 = item_img3;
	}
	public String getItem_img4() {
		return item_img4;
	}
	public void setItem_img4(String item_img4) {
		this.item_img4 = item_img4;
	}
	public String getItem_img5() {
		return item_img5;
	}
	public void setItem_img5(String item_img5) {
		this.item_img5 = item_img5;
	}
	public String getItem_img6() {
		return item_img6;
	}
	public void setItem_img6(String item_img6) {
		this.item_img6 = item_img6;
	}
	
	public String getDate_start() {
		return date_start;
	}
	public void setDate_start(String date_start) {
		this.date_start = date_start;
	}
	public String getDate_end() {
		return date_end;
	}
	public void setDate_end(String date_end) {
		this.date_end = date_end;
	}
	
	public String getItem_st1() {
		return item_st1;
	}
	public void setItem_st1(String item_st1) {
		this.item_st1 = item_st1;
	}
	public String getItem_st2() {
		return item_st2;
	}
	public void setItem_st2(String item_st2) {
		this.item_st2 = item_st2;
	}
	public String getItem_st3() {
		return item_st3;
	}
	public void setItem_st3(String item_st3) {
		this.item_st3 = item_st3;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getModifydate() {
		return modifydate;
	}
	public void setModifydate(Date modifydate) {
		this.modifydate = modifydate;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "ItemVO [item_num=" + item_num + ", item_name=" + item_name + ", item_content=" + item_content
				+ ", price=" +  ", item_img1=" + item_img1 + ", item_img2=" + item_img2 + ", item_img3="
				+ item_img3 + ", item_img4=" + item_img4 + ", item_img5=" + item_img5 + ", item_img6=" + item_img6
				+ ", item_st1=" + item_st1 + ", item_st2=" + item_st2 + ", item_st3=" + item_st3 + ", date_start="
				+ date_start + ", date_end=" + date_end + ", status=" + status + ", reg_date=" + reg_date
				+ ", modifydate=" + modifydate + ", quantity=" + quantity + "]";
	}
}
