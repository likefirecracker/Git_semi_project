package cs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class NoticeDBBean {
	private static NoticeDBBean noticeDBBean = new NoticeDBBean();
	
	public static NoticeDBBean getInstance() {
		return noticeDBBean;
	}
	
	public Connection getConnection() throws Exception{
		Connection conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	/*
	 * 작성자 : 이민하
	 * 일  시 : 2022.09.16
	 * 데이터 삽입문 
	 * */
	public int insertNotice(NoticeBean notice) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re=-1;
		String sql;
		int number;
		
		try {
			conn = getConnection();
			sql = "SELECT MAX(N_NUM) FROM NOTICE";
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			pstmt.clearParameters();//insert에 2개 추가 2022.09.13
			sql = "INSERT INTO notice VALUES(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, notice.getN_title());
			pstmt.setString(3, notice.getN_content());
			pstmt.setTimestamp(4,notice.getN_date());
			pstmt.setInt(5, 0);
			pstmt.setString(6, notice.getN_pwd());
			pstmt.setString(7,notice.getN_ip());
			pstmt.setNString(8, notice.getUser_id());

			
			pstmt.executeUpdate();
			re=1;
			
		}catch(SQLException ex){
			System.out.println("추가 실패");
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
	 * 일  시 : 2022.09.16
	 * 데이터 출력문
	 * */
	public NoticeBean getNotice(int n_num, boolean hitadd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "update notice\r\n" + 
				"   set n_hit = n_hit+1\r\n" + 
				" where n_num = ?"; 
		
		NoticeBean notice = new NoticeBean();
		try {
			conn = getConnection();
			if(hitadd) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, n_num);
				pstmt.executeUpdate();	
				pstmt.clearParameters();
			}
			
			sql="select n.n_num\r\n" + 
					"     , n.n_title\r\n" + 
					"     , n.n_content\r\n" + 
					"     , n.n_date\r\n" + 
					"     , n.n_hit\r\n" + 
					"     , n.n_pwd\r\n" + 
					"     , n.n_ip\r\n" + 
					"     , n.user_id\r\n" + 
					"     , (select n1.n_num\r\n" + 
					"          from notice n1\r\n" + 
					"         where n1.n_num=(select min(n2.n_num) from notice n2 where n2.n_num > "+n_num+")) as after\r\n" + 
					"     , (select n_num\r\n" + 
					"          from notice\r\n" + 
					"        where n_num=(select max(n_num) from notice where n_num < "+n_num+")) as before\r\n" + 
					"FROM notice n\r\n" + 
					"where n.n_num = "+n_num;
			pstmt = conn.prepareStatement(sql);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setN_num(rs.getInt("n_num"));
				notice.setN_title(rs.getString("n_title"));
				notice.setN_content(rs.getString("n_content"));
				notice.setN_date(rs.getTimestamp("n_date"));
				notice.setN_hit(rs.getInt("n_hit"));
				notice.setN_pwd(rs.getString("n_pwd"));
				notice.setN_ip(rs.getString("n_ip"));
				notice.setUser_id(rs.getString("user_id"));
				notice.setBefore(rs.getInt("before"));
				notice.setAfter(rs.getInt("after"));
			}
			
				

		}catch(SQLException ex){
			System.out.println("조회 실패");
			ex.printStackTrace();
		}finally{
			try{
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return notice;
	}
	
	
	/*
	 * 작성자 : 이민하
	 * 일  시 : 2022.09.16
	 * 데이터 List 출력문 
	 * */
	public ArrayList<NoticeBean> listNotice(String pageNumber) throws Exception{
		ArrayList<NoticeBean> noticeList = new ArrayList<>();
		Connection conn = null;
		Statement stmt= null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		int dbCount=0;
		int absolutePage=0;
		String sql=""; 
		String sql2=""; 
		sql = "select n_num\r\n" + 
				"     , n_title\r\n" + 
				"     , n_content\r\n" + 
				"     , n_date\r\n" + 
				"     , n_hit\r\n" + 
				"     , n_pwd\r\n" + 
				"     , n_ip\r\n" + 
				"     , user_id\r\n" + 
				"  from notice"+   
				" order by n_num";
		
		sql2="SELECT COUNT(N_NUM) FROM NOTICE";
		try {
			conn = getConnection();
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet=stmt.executeQuery(sql2);
			
			if(pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if(dbCount%NoticeBean.pageSize==0) { //dbCount => 총 숫자 , pageSize =10 => ex) 84%10 = 4
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize; //80/10=> 8
			} else {
				NoticeBean.pageCount = dbCount / NoticeBean.pageSize +1;//84/10 +1=> 8+1 => 9
			}
			
			if(pageNumber != null) {
				NoticeBean.pageNum = Integer.parseInt(pageNumber);
				absolutePage = (NoticeBean.pageNum - 1) * NoticeBean.pageSize +1;
			}
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while(count<NoticeBean.pageSize){
					NoticeBean notice = new NoticeBean();
					
					notice.setN_num(rs.getInt("n_num"));
					notice.setN_title(rs.getString("n_title"));
					notice.setN_content(rs.getString("n_content"));
					notice.setN_date(rs.getTimestamp("n_date"));
					notice.setN_hit(rs.getInt("n_hit"));
					notice.setN_pwd(rs.getString("n_pwd"));
					notice.setN_ip(rs.getString("n_ip"));
					notice.setUser_id(rs.getString("user_id"));
					
					noticeList.add(notice);
					
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
		return noticeList;
	}
	
	/*
	 * 작성자 : 이민하
	 * 일  시 : 2022.09.16
	 * 데이터 수정문
	 * */
	public int editNotice(NoticeBean notice) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String check_pw="";
		int re=-1;
		String sql;
		
		sql = "select n_pwd\r\n" + 
				"   from notice\r\n" + 
				"  where user_id = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getUser_id());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check_pw=rs.getString(1);
			}
			if(check_pw.equals(notice.getN_pwd())) { //혹시 몰라서 다시한번 검사
				sql = "update notice\r\n" + 
						"    set n_title = ?\r\n" + 
						"      , n_content = ?\r\n" + 
						"  where n_num = ?";
				pstmt.clearParameters();
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, notice.getN_title());
				pstmt.setString(2, notice.getN_content());
				pstmt.setInt(3, notice.getN_num());
				
				re=pstmt.executeUpdate();
				
				System.out.println("변경 성공");
				re=1;
			}else {
				System.out.println("변경 실패");
				re=0;
			}
			
			
			
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
	 * 일  시 : 2022.09.16
	 * 데이터 삭제문 
	 * */
	public int deleteNotice(int n_num, String bpwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String check_pw=null;
		int re=-1;
		String sql;
		sql = "select n_pwd\r\n" + 
				"   from notice\r\n" + 
				"  where n_num = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check_pw=rs.getString(1);
			}
			
			if(check_pw.equals(bpwd)) { //혹시 몰라서 다시한번 검사
				sql = "DELETE FROM NOTICE WHERE N_NUM = ?";
				pstmt.clearParameters();
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, n_num);
				pstmt.executeUpdate();
				
				System.out.println("삭제 성공");
				re=1;
			}else {
				System.out.println("삭제 실패");
				re=0;
			}
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
	
	public int countWrite(int amount) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		
		String sql = "SELECT COUNT(*) FROM NOTICE";
		try {
			conn = getConnection();
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int pages;
		if(count%amount == 0) {
			pages = count/amount;			
		} else {
			pages= count/amount +1 ;
		}
		
		
		return pages;
	}
}
