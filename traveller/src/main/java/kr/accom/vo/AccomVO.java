package kr.accom.vo;

import java.sql.Date;

public class AccomVO {
	private int accom_num; //게시물 번호
	private int accom_status; //진행 상태
	private String accom_title; //제목
	private String accom_content; //내용
	private int accom_hit; //조회수
	private Date accom_regdate; //등록일
	private Date accom_modifydate; //수정일
	private int accom_quantity; //모집 인원수
	private int accom_expense;//여행 경비
	private String accom_filename; //
	private int accom_start;
	private int accom_end;
	private String ip;
	
	public int getAccom_num() {
		return accom_num;
	}
	public void setAccom_num(int accom_num) {
		this.accom_num = accom_num;
	}
	public int getAccom_status() {
		return accom_status;
	}
	public void setAccom_status(int accom_status) {
		this.accom_status = accom_status;
	}
	public String getAccom_title() {
		return accom_title;
	}
	public void setAccom_title(String accom_title) {
		this.accom_title = accom_title;
	}
	public String getAccom_content() {
		return accom_content;
	}
	public void setAccom_content(String accom_content) {
		this.accom_content = accom_content;
	}
	public int getAccom_hit() {
		return accom_hit;
	}
	public void setAccom_hit(int accom_hit) {
		this.accom_hit = accom_hit;
	}
	public Date getAccom_regdate() {
		return accom_regdate;
	}
	public void setAccom_regdate(Date accom_regdate) {
		this.accom_regdate = accom_regdate;
	}
	public Date getAccom_modifydate() {
		return accom_modifydate;
	}
	public void setAccom_modifydate(Date accom_modifydate) {
		this.accom_modifydate = accom_modifydate;
	}
	public int getAccom_quantity() {
		return accom_quantity;
	}
	public void setAccom_quantity(int accom_quantity) {
		this.accom_quantity = accom_quantity;
	}
	public int getAccom_expense() {
		return accom_expense;
	}
	public void setAccom_expense(int accom_expense) {
		this.accom_expense = accom_expense;
	}
	public String getAccom_filename() {
		return accom_filename;
	}
	public void setAccom_filename(String accom_filename) {
		this.accom_filename = accom_filename;
	}
	public int getAccom_start() {
		return accom_start;
	}
	public void setAccom_start(int accom_start) {
		this.accom_start = accom_start;
	}
	public int getAccom_end() {
		return accom_end;
	}
	public void setAccom_end(int accom_end) {
		this.accom_end = accom_end;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
}
