package kr.event.vo;

import java.sql.Date;

public class EventVO {
	
	private int event_num;
	private int event_category;
	private String event_title;
	private String event_start;
	private String event_end;
	private String event_photo1;
	private String event_photo2;
	private String event_photo3;
	private String event_photo4;
	private String event_photo5;
	private String event_content;
	private int event_hit;
	private Date event_regdate;
	private Date event_modifydate;
	private int event_count;
	
	
	public int getEvent_num() {
		return event_num;
	}
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	public int getEvent_category() {
		return event_category;
	}
	public void setEvent_category(int event_category) {
		this.event_category = event_category;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_start() {
		return event_start;
	}
	public void setEvent_start(String event_start) {
		this.event_start = event_start;
	}
	public String getEvent_end() {
		return event_end;
	}
	public void setEvent_end(String event_end) {
		this.event_end = event_end;
	}
	public String getEvent_photo1() {
		return event_photo1;
	}
	public void setEvent_photo1(String event_photo1) {
		this.event_photo1 = event_photo1;
	}
	public String getEvent_photo2() {
		return event_photo2;
	}
	public void setEvent_photo2(String event_photo2) {
		this.event_photo2 = event_photo2;
	}
	public String getEvent_photo3() {
		return event_photo3;
	}
	public void setEvent_photo3(String event_photo3) {
		this.event_photo3 = event_photo3;
	}
	public String getEvent_photo4() {
		return event_photo4;
	}
	public void setEvent_photo4(String event_photo4) {
		this.event_photo4 = event_photo4;
	}
	public String getEvent_photo5() {
		return event_photo5;
	}
	public void setEvent_photo5(String event_photo5) {
		this.event_photo5 = event_photo5;
	}
	public String getEvent_content() {
		return event_content;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public int getEvent_hit() {
		return event_hit;
	}
	public void setEvent_hit(int event_hit) {
		this.event_hit = event_hit;
	}
	public Date getEvent_regdate() {
		return event_regdate;
	}
	public void setEvent_regdate(Date event_regdate) {
		this.event_regdate = event_regdate;
	}
	public Date getEvent_modifydate() {
		return event_modifydate;
	}
	public void setEvent_modifydate(Date event_modifydate) {
		this.event_modifydate = event_modifydate;
	}
	public int getEvent_count() {
		return event_count;
	}
	public void setEvent_count(int event_count) {
		this.event_count = event_count;
	}
}
