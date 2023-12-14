package kr.accom.vo;

public class AccomReplyVO {
	private int accom_renum; // 댓글번호
	private String accom_recontent; //내용
	private String accom_redate; //작성일
	private String accom_remodifydate; //수정일
	private String accom_reip; // 아이피 주소
	private int accom_num; //게시판 번호
	private int mem_num; //작성자 회원번호
	private String id; //작성자 ID
	public int getAccom_renum() {
		return accom_renum;
	}
	public void setAccom_renum(int accom_renum) {
		this.accom_renum = accom_renum;
	}
	public String getAccom_recontent() {
		return accom_recontent;
	}
	public void setAccom_recontent(String accom_recontent) {
		this.accom_recontent = accom_recontent;
	}
	public String getAccom_redate() {
		return accom_redate;
	}
	public void setAccom_redate(String accom_redate) {
		this.accom_redate = accom_redate;
	}
	public String getAccom_remodifydate() {
		return accom_remodifydate;
	}
	public void setAccom_remodifydate(String accom_remodifydate) {
		this.accom_remodifydate = accom_remodifydate;
	}
	public String getAccom_reip() {
		return accom_reip;
	}
	public void setAccom_reip(String accom_reip) {
		this.accom_reip = accom_reip;
	}
	public int getAccom_num() {
		return accom_num;
	}
	public void setAccom_num(int accom_num) {
		this.accom_num = accom_num;
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
	
	
}
