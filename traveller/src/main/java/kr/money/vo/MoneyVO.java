package kr.money.vo;

import java.sql.Date;

public class MoneyVO {
	private int mem_num;
	private int sm_num;
	private String saved_money;
	private String sm_content;
	
	public String getSm_content() {
		return sm_content;
	}
	public void setSm_content(String sm_content) {
		this.sm_content = sm_content;
	}
	private Date sm_date;
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getSm_num() {
		return sm_num;
	}
	public void setSm_num(int sm_num) {
		this.sm_num = sm_num;
	}
	public String getSaved_money() {
		return saved_money;
	}
	public void setSaved_money(String saved_money) {
		this.saved_money = saved_money;
	}
	public Date getSm_date() {
		return sm_date;
	}
	public void setSm_date(Date sm_date) {
		this.sm_date = sm_date;
	}
}
