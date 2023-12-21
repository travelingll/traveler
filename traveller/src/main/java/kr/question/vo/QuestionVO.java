package kr.question.vo;

import java.sql.Date;

public class QuestionVO {

	private int question_num;
	private int mem_num;
	private String question_ip;
	private int question_category;
	private String question_title;
	private int question_lock;
	private String question_passwd;
	private String question_photo;
	private String question_content;
	private Date question_regdate;
	private Date question_modifydate;
	private int question_level;
	private int question_hit;
	private String name;
	private int question_renum;
	

	public int getQuestion_category() {
		return question_category;
	}
	public void setQuestion_category(int question_category) {
		this.question_category = question_category;
	}
	public int getQuestion_renum() {
		return question_renum;
	}
	public void setQuestion_renum(int question_renum) {
		this.question_renum = question_renum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getQuestion_hit() {
		return question_hit;
	}
	public void setQuestion_hit(int question_hit) {
		this.question_hit = question_hit;
	}
	public int getQuestion_num() {
		return question_num;
	}
	public void setQuestion_num(int question_num) {
		this.question_num = question_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getQuestion_ip() {
		return question_ip;
	}
	public void setQuestion_ip(String question_ip) {
		this.question_ip = question_ip;
	}

	public String getQuestion_title() {
		return question_title;
	}
	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}
	public int getQuestion_lock() {
		return question_lock;
	}
	public void setQuestion_lock(int question_lock) {
		this.question_lock = question_lock;
	}
	public String getQuestion_passwd() {
		return question_passwd;
	}
	public void setQuestion_passwd(String question_passwd) {
		this.question_passwd = question_passwd;
	}
	public String getQuestion_photo() {
		return question_photo;
	}
	public void setQuestion_photo(String question_photo) {
		this.question_photo = question_photo;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public Date getQuestion_regdate() {
		return question_regdate;
	}
	public void setQuestion_regdate(Date question_regdate) {
		this.question_regdate = question_regdate;
	}
	public Date getQuestion_modifydate() {
		return question_modifydate;
	}
	public void setQuestion_modifydate(Date question_modifydate) {
		this.question_modifydate = question_modifydate;
	}
	public int getQuestion_level() {
		return question_level;
	}
	public void setQuestion_level(int question_level) {
		this.question_level = question_level;
	}
}
