package cs;

import java.sql.Timestamp;

public class QnABoardBean {
	private int b_id;
	private String u_id;
	private String b_category;
	private int b_view;
	private String b_title;
	private String b_content;
	private String b_ip;
	private String b_pwd;
	private Timestamp b_date;
	private String b_secret;
	private int b_ref;
	private int b_step;
	private int b_level;
	private String b_fname;
	private int b_fsize;
	private String b_rfname;
	private String b_anschk;
	
	private String u_grade; // 회원 등급
	
	public String getU_grade() {
		return u_grade;
	}

	public void setU_grade(String u_grade) {
		this.u_grade = u_grade;
	}
	
	private int count; // 전체 글 개수
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	public String getB_anschk() {
		return b_anschk;
	}
	public void setB_anschk(String b_anschk) {
		this.b_anschk = b_anschk;
	}
	public String getB_secret() {
		return b_secret;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public int getB_view() {
		return b_view;
	}
	public void setB_view(int b_view) {
		this.b_view = b_view;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_ip() {
		return b_ip;
	}
	public void setB_ip(String b_ip) {
		this.b_ip = b_ip;
	}
	public String getB_pwd() {
		return b_pwd;
	}
	public void setB_pwd(String b_pwd) {
		this.b_pwd = b_pwd;
	}
	public Timestamp getB_date() {
		return b_date;
	}
	public void setB_date(Timestamp b_date) {
		this.b_date = b_date;
	}
	public void setB_secret(String b_secret) {
		this.b_secret = b_secret;
	}
	public int getB_ref() {
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public int getB_step() {
		return b_step;
	}
	public void setB_step(int b_step) {
		this.b_step = b_step;
	}
	public int getB_level() {
		return b_level;
	}
	public void setB_level(int b_level) {
		this.b_level = b_level;
	}
	public String getB_fname() {
		return b_fname;
	}
	public void setB_fname(String b_fname) {
		this.b_fname = b_fname;
	}
	public int getB_fsize() {
		return b_fsize;
	}
	public void setB_fsize(int b_size) {
		this.b_fsize = b_size;
	}
	public String getB_rfname() {
		return b_rfname;
	}
	public void setB_rfname(String b_rfname) {
		this.b_rfname = b_rfname;
	}
	
	
}
