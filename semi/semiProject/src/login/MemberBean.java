package login;

import java.sql.Timestamp;

public class MemberBean {
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String user_phone;
	private String user_email;
	private String user_addr;
	//private String user_grade;
	private Timestamp user_regdate;
	
	public static int pageSize=10;
	public static int pageCount=1;
	public static int pageNum=1;
	
	public static String s_user_id;
	
	public static String pageNumber(int limit) {
		String str="";
		int startPage = pageNum;
		if(startPage > 1) {
			startPage = pageNum -1;
		} else {
			startPage = 1;
		}
		
		//if(startPage - limit>0) {
		if(startPage > 1) {
			int temp=startPage-limit;
			if(temp <= 0) {
				temp=1;
			}
			str="<a href = 'listMember.jsp?pageNum="+(temp)+"&search_user_id="+s_user_id+"'>[이전]</a>&nbsp;&nbsp";
		}
		
		for(int i=startPage;i<(startPage+limit);i++) {
			if(i==pageNum) {
				str +="["+i+"]&nbsp&nbsp";
			} else {
				str+="<a href='listMember.jsp?pageNum="+i+"&search_user_id="+s_user_id+"'>["+i+"]</a>&nbsp;&nbsp;";
			}
			if(i>=pageCount)break;
		}
		
		if(startPage + limit<=pageCount) {
			str+="<a href = 'listMember.jsp?pageNum="+(startPage+limit)+"&search_user_id="+s_user_id+"'>[다음]</a>&nbsp;&nbsp";
		}
		
		return str;
	}
	
	
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public Timestamp getUser_regdate() {
		return user_regdate;
	}
	public void setUser_regdate(Timestamp user_regdate) {
		this.user_regdate = user_regdate;
	}

	/*
	 * public String getUser_grade() { return user_grade; } public void
	 * setUser_grade(String user_grade) { this.user_grade = user_grade; }
	 */
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
}