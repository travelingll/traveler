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
	private String accom_filename; //첨부하 사진 파일 이름
	private String accom_start;//여행 시작일
	private String accom_end;//여행 종료일
	private String ip;//IP
	private int mem_num;//회원 번호
	private String id;//회원 아이디
	private String photo;//회원 프로필 사진(조인해야함)
	private int cnt; //좋아요수
	private int apply_quantity; //현재 신청 인원수
	
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
	public String getAccom_start() {
		return accom_start;
	}
	public void setAccom_start(String accom_start) {
		this.accom_start = accom_start;
	}
	public String getAccom_end() {
		return accom_end;
	}
	public void setAccom_end(String accom_end) {
		this.accom_end = accom_end;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getApply_quantity() {
		return apply_quantity;
	}
	public void setApply_quantity(int apply_quantity) {
		this.apply_quantity = apply_quantity;
	}
	
}