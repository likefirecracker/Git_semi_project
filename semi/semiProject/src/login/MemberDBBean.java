package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import cs.NoticeBean;
import cs.QnABoardBean;


public class MemberDBBean {
	private static MemberDBBean instance = new MemberDBBean();

	public static MemberDBBean getInstance() {
		// 값을 입력받는 메소드
		return instance; // BoardDBBean의 객체를 입력받음.

	}

	public static Connection getConnection() throws Exception {
		// 쿼리작업 사용할 Connection객체 리턴하는 메소드
		// 따로만든 이유 -> 여러번 사용하기 위해서

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	// 유저 가입 메소드
	public static int register(MemberBean member) throws Exception {
        //값을 추가하는 메소드
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "insert into user_table(user_id, user_pwd, user_name, user_phone ,user_email, user_regdate,"
					+ " user_addr)"
					+ " values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			//pstmt를 연결
			pstmt.setString(1, member.getUser_id()); //추가 
			pstmt.setString(2, member.getUser_pwd()); //추가 
			pstmt.setString(3, member.getUser_name()); //추가 
			pstmt.setString(4, member.getUser_phone()); //추가 
			pstmt.setString(5, member.getUser_email()); //추가 
			pstmt.setTimestamp(6, member.getUser_regdate()); //추가 
			pstmt.setString(7, member.getUser_addr()); //추가 
			pstmt.executeUpdate();

			System.out.println("회원가입 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 실패");
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return 1;
	}
	public int confirmID(String id) throws Exception{
		//중복확인을 위한 메소드
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re= -1;
		String sql = "select mem_id from memberT where mem_id =?";
		//파라미터값을 ?로 받음.
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); //sql의 결과값.
		
			if(rs.next()) {
				re =1;
			}
			else {
				re = -1;
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
			return re;
	}
	
	public MemberBean getMember(String id) throws Exception{
		//아이디가 일치하는 멤버의 정보를 얻어오는 메소드
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from user_table where user_id=?";
		MemberBean member = null;
		
		try {	con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			member = new MemberBean();
			// 로그인할때 입력하는 아이디를 bean에 넣어줌 
			member.setUser_id(rs.getString("user_id")); 
			member.setUser_pwd(rs.getString("user_pwd"));
			member.setUser_name(rs.getString("user_name"));  
			member.setUser_phone(rs.getString("user_phone"));  
			member.setUser_email(rs.getString("user_email"));  
			member.setUser_regdate(rs.getTimestamp("user_regdate"));
			//타입이 다르기 때문에  
			member.setUser_addr(rs.getString("user_addr"));  
		}
		rs.close();
		pstmt.close();
		con.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	 public int userCheck(String id, String pwd) throws Exception {
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String sql = "select user_pwd from user_table where user_id = ?";
		  String db_user_pwd;
		  int re = -1;

		  try {
		   con = getConnection();
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, id);
		   rs = pstmt.executeQuery();

		   if(rs.next()) {
		    db_user_pwd = rs.getString("user_pwd");
		    
		    if (db_user_pwd.equals(pwd))
		     re = -1;
		    else
		     re = 0;
		     
		   } else {
		    re = -1;
		   }
		  } catch(Exception e) {
		   System.out.println(e.getMessage()); 
		  }

		  rs.close();
		  pstmt.close();
		  con.close();

		  return re;
	 }
	 
	 public String findId(String user_name, String user_phone) {
		String re=null;
		
		try {			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "select user_id from user_table where user_name=? and user_phone=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_name);
			pstmt.setString(2, user_phone);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				re = rs.getString("user_id");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	 }
	
	 
		public ArrayList<MemberBean> listMember(String pageNumber, String user_id) throws Exception{
			ArrayList<MemberBean> memberList = new ArrayList<>();
			Connection conn = null;
			Statement stmt= null;
			PreparedStatement pstmt =null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=0;
			String sql=""; 
			String sql2=""; 
			sql = "select user_id\r\n" + 
					"     , user_pwd\r\n" + 
					"     , user_name\r\n" + 
					"     , user_phone\r\n" + 
					"     , user_email\r\n" + 
					"     , user_regdate\r\n" + 
					"     , user_addr\r\n" + 
					"  from user_table\r\n"+
					" where user_id like '%"+user_id+"%'";
			
			sql2="SELECT COUNT(user_id) FROM user_table where user_id like '%"+user_id+"%'";
			try {
				conn = getConnection();
				
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet=stmt.executeQuery(sql2);
				
				if(pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if(dbCount%MemberBean.pageSize==0) { //dbCount => 총 숫자 , pageSize =10 => ex) 84%10 = 4
					MemberBean.pageCount = dbCount / MemberBean.pageSize; //80/10=> 8
				} else {
					MemberBean.pageCount = dbCount / MemberBean.pageSize +1;//84/10 +1=> 8+1 => 9
				}
				
				if(pageNumber != null) {
					MemberBean.pageNum = Integer.parseInt(pageNumber);
					absolutePage = (MemberBean.pageNum - 1) * MemberBean.pageSize +1;
				}
				rs=stmt.executeQuery(sql);
				if(rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while(count<MemberBean.pageSize){
						MemberBean member = new MemberBean();
						
						member.setUser_id(rs.getString("user_id"));
						member.setUser_pwd(rs.getString("user_pwd"));
						member.setUser_name(rs.getString("user_name"));
						member.setUser_phone(rs.getString("user_phone"));
						member.setUser_email(rs.getString("user_email"));
						member.setUser_regdate(rs.getTimestamp("user_regdate"));
						member.setUser_addr(rs.getString("user_addr"));
						
						memberList.add(member);
						
						if(rs.isLast()) {
							break;
						} else {
							rs.next();
						}
						
						count++;
					}
				}
				
			}catch(SQLException ex){
				System.out.println("조회 실패");
				ex.printStackTrace();
			}finally{
				try{
					if(pstmt != null)pstmt.close();
					if(conn != null)conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return memberList;
		}
		
		/*
		 * 작성자 : 이민하
		 * 일  시 : 2022.09.20
		 * 데이터 삭제문 
		 * */
		public int deleteMember(String user_id) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;

			int re=-1;
			String sql;
			try {
				conn = getConnection();
				
				sql = "DELETE FROM USER_TABLE WHERE USER_ID = ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				pstmt.executeUpdate();
				
				System.out.println("삭제 성공");
				
			}catch(SQLException ex){
				System.out.println("변경 실패");
				ex.printStackTrace();
			}finally{
				try{
					if(pstmt != null)pstmt.close();
					if(conn != null)conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return re;
		}

		/*
		 * 작성자 : 이민하
		 * 일  시 : 2022.09.20
		 * 데이터 업데이트 
		 * */
		public int editMember(MemberBean member) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String check_pw="";
			int re=-1;
			String sql;
			
			try {
				conn = getConnection();
				
				sql = "update user_table\r\n" + 
						"    set user_name = ?\r\n" + 
						"      , user_phone = ?\r\n" + 
						"      , user_email = ?\r\n" + 
						"      , user_regdate = ?\r\n"+
						"      , user_addr = ?\r\n"+
						"  where user_id = ?";

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, member.getUser_name());				
				pstmt.setString(2, member.getUser_phone());
				pstmt.setString(3, member.getUser_email());
				pstmt.setTimestamp(4, member.getUser_regdate());
				pstmt.setString(5, member.getUser_addr());
				pstmt.setString(6, member.getUser_id());
				
				re=pstmt.executeUpdate();
				
				System.out.println("변경 성공");
				re=1;
				
			}catch(SQLException ex){
				System.out.println("변경 실패");
				ex.printStackTrace();
			}finally{
				try{
					if(pstmt != null)pstmt.close();
					if(conn != null)conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
			
			return re;
		}
		
}