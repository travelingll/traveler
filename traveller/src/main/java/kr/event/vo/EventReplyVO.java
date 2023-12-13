package kr.event.vo;

import java.sql.Date;

public class EventReplyVO {
	
	private int event_renum;
	private String event_recontent;
	private Date event_redate;
	private Date event_modifydate;
	private String event_reip;
	private int event_num;
	private int mem_num;
	
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getEvent_modifydate() {
		return event_modifydate;
	}
	public void setEvent_modifydate(Date event_modifydate) {
		this.event_modifydate = event_modifydate;
	}
	public int getEvent_renum() {
		return event_renum;
	}
	public void setEvent_renum(int event_renum) {
		this.event_renum = event_renum;
	}
	public String getEvent_recontent() {
		return event_recontent;
	}
	public void setEvent_recontent(String event_recontent) {
		this.event_recontent = event_recontent;
	}
	public Date getEvent_redate() {
		return event_redate;
	}
	public void setEvent_redate(Date event_redate) {
		this.event_redate = event_redate;
	}
	public String getEvent_reip() {
		return event_reip;
	}
	public void setEvent_reip(String event_reip) {
		this.event_reip = event_reip;
	}
	public int getEvent_num() {
		return event_num;
	}
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
