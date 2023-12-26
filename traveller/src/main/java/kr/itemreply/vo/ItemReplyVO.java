package kr.itemreply.vo;

import java.sql.Date;

/**
 * 
 */
public class ItemReplyVO {
	private int item_renum;
	private int item_num;
	private int mem_num;
	private String item_recontent;
	private Date item_redate;
	private String item_reip;
	private String item_st1;
	private String item_case;
	private String user_id;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getItem_renum() {
		return item_renum;
	}
	public void setItem_renum(int item_renum) {
		this.item_renum = item_renum;
	}
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getItem_recontent() {
		return item_recontent;
	}
	public void setItem_recontent(String item_recontent) {
		this.item_recontent = item_recontent;
	}
	public Date getItem_redate() {
		return item_redate;
	}
	public void setItem_redate(Date item_redate) {
		this.item_redate = item_redate;
	}
	public String getItem_reip() {
		return item_reip;
	}
	public void setItem_reip(String item_reip) {
		this.item_reip = item_reip;
	}
	public String getItem_st1() {
		return item_st1;
	}
	public void setItem_st1(String item_st1) {
		this.item_st1 = item_st1;
	}
	public String getItem_case() {
		return item_case;
	}
	public void setItem_case(String item_case) {
		this.item_case = item_case;
	}
	
	
}
