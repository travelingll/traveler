package kr.comm.vo;

import java.sql.Date;

public class CommVO {
	private int comm_num;
	private String comm_title;
	private Date reg_date;
	private String comm_content;
	private int comm_hit;
	private Date modify_date;
	private String filename;
	private String ip;
	private int mem_num;
	private String id;	
	private String photo;		//회원 프로필 사진(조인해야함)
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public String getComm_title() {
		return comm_title;
	}
	public void setComm_title(String comm_title) {
		this.comm_title = comm_title;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	public int getComm_hit() {
		return comm_hit;
	}
	public void setComm_hit(int comm_hit) {
		this.comm_hit = comm_hit;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}

