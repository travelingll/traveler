package kr.event.vo;

import java.sql.Date;

public class EventVO {
	
	private int event_num;
	private int event_category;
	private String event_title;
	private String event_start;
	private String evnet_end;
	private String evnet_photo1;
	private String evnet_photo2;
	private String evnet_photo3;
	private String evnet_photo4;
	private String evnet_photo5;
	private String evnet_content;
	private int evnet_hit;
	private Date evnet_regdate;
	private Date evnet_modifydate;
	private int evnet_count;
	
	
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
	public String getEvnet_end() {
		return evnet_end;
	}
	public void setEvnet_end(String evnet_end) {
		this.evnet_end = evnet_end;
	}
	public String getEvnet_photo1() {
		return evnet_photo1;
	}
	public void setEvnet_photo1(String evnet_photo1) {
		this.evnet_photo1 = evnet_photo1;
	}
	public String getEvnet_photo2() {
		return evnet_photo2;
	}
	public void setEvnet_photo2(String evnet_photo2) {
		this.evnet_photo2 = evnet_photo2;
	}
	public String getEvnet_photo3() {
		return evnet_photo3;
	}
	public void setEvnet_photo3(String evnet_photo3) {
		this.evnet_photo3 = evnet_photo3;
	}
	public String getEvnet_photo4() {
		return evnet_photo4;
	}
	public void setEvnet_photo4(String evnet_photo4) {
		this.evnet_photo4 = evnet_photo4;
	}
	public String getEvnet_photo5() {
		return evnet_photo5;
	}
	public void setEvnet_photo5(String evnet_photo5) {
		this.evnet_photo5 = evnet_photo5;
	}
	public String getEvnet_content() {
		return evnet_content;
	}
	public void setEvnet_content(String evnet_content) {
		this.evnet_content = evnet_content;
	}
	public int getEvnet_hit() {
		return evnet_hit;
	}
	public void setEvnet_hit(int evnet_hit) {
		this.evnet_hit = evnet_hit;
	}
	public Date getEvnet_regdate() {
		return evnet_regdate;
	}
	public void setEvnet_regdate(Date evnet_regdate) {
		this.evnet_regdate = evnet_regdate;
	}
	public Date getEvnet_modifydate() {
		return evnet_modifydate;
	}
	public void setEvnet_modifydate(Date evnet_modifydate) {
		this.evnet_modifydate = evnet_modifydate;
	}
	public int getEvnet_count() {
		return evnet_count;
	}
	public void setEvnet_count(int evnet_count) {
		this.evnet_count = evnet_count;
	}
}
