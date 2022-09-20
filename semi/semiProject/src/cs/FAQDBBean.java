package cs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/*
 * 작성자 : 이민하
 * 작성일 : 2022.09.19
 * FAQ를 위해 따로 만든 메소드 
 * 후에 QnABoardDBBean에 넣고 삭제해도 됨. => FAQ.jsp를 수정해야함.
 * */
public class FAQDBBean { //QnABoardBean과 QnABoardDBBean을 사용
	
	private static FAQDBBean instance = new FAQDBBean();
	
	public static FAQDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ArrayList<QnABoardBean> listBoardFAQ(String b_title, String b_category) throws Exception {
		String sql = "select b_id\r\n" + 
				"     , u_id\r\n" + 
				"     , b_category\r\n" + 
				"     , b_view\r\n" + 
				"     , b_title\r\n" + 
				"     , b_content\r\n" + 
				"     , b_ip\r\n" + 
				"     , b_pwd\r\n" + 
				"     , b_date\r\n" + 
				"     , b_secret\r\n" + 
				"     , b_ref\r\n" + 
				"     , b_step\r\n" + 
				"     , b_level\r\n" + 
				"     , b_fname\r\n" + 
				"     , b_fsize\r\n" + 
				"     , b_rfname\r\n" + 
				"     , b_anschk\r\n" + 
				"  from qna_board \r\n" + 
				" where b_level = 0 \r\n" + 
				"   and b_anschk = 'Y' \r\n" + 
				"   and b_secret = 'N' \r\n" + 
				"   and b_title like '%"+b_title+"%' \r\n" + 
				"   and b_category like '%"+b_category+"%' \r\n" + 
				"   and rownum <= 10 \r\n" + 
				" order by b_view desc";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		ArrayList<QnABoardBean> list = new ArrayList<QnABoardBean>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QnABoardBean qbb = new QnABoardBean();
				qbb.setB_id(rs.getInt("B_ID"));
				qbb.setU_id(rs.getString("U_ID"));
				qbb.setB_category(rs.getString("B_CATEGORY"));
				qbb.setB_view(rs.getInt("B_VIEW"));
				qbb.setB_title(rs.getString("B_TITLE"));
				qbb.setB_content(rs.getString("B_CONTENT"));
				qbb.setB_ip(rs.getString("B_IP"));
				qbb.setB_pwd(rs.getString("B_PWD"));
				qbb.setB_date(rs.getTimestamp("B_DATE"));
				qbb.setB_secret(rs.getString("B_SECRET"));
				qbb.setB_ref(rs.getInt("B_REF"));
				qbb.setB_step(rs.getInt("B_STEP"));
				qbb.setB_level(rs.getInt("B_LEVEL"));
				qbb.setB_fname(rs.getString("B_FNAME"));
				qbb.setB_fsize(rs.getInt("B_FSIZE"));
				qbb.setB_rfname(rs.getString("B_RFNAME"));
				qbb.setB_anschk(rs.getString("B_ANSCHK"));
				
				list.add(qbb);
			}
			
		} catch (SQLException ex) {
			System.out.print("조회 실패");
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public QnABoardBean getBoardFAQ(int b_id, boolean hitAdd) throws Exception {
		String sql = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnABoardBean qbb = null;
		
		try {
			if (hitAdd == true) {
				sql = "UPDATE QNA_BOARD SET B_VIEW=B_VIEW+1 WHERE B_ID = ?";
				conn = getConnection();
				;
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_id);
				pstmt.executeUpdate(); // 쿼리 실행
			} else {
				conn = getConnection();
			}
			
			sql = "SELECT B_ID, U_ID, B_CATEGORY, B_VIEW, B_TITLE, B_CONTENT\r\n" + 
					",B_IP, B_PWD, B_DATE, B_SECRET, B_REF, B_STEP, B_LEVEL\r\n" + 
					",B_FNAME, B_FSIZE, B_RFNAME, B_ANSCHK\r\n" + 
					"  FROM QNA_BOARD WHERE B_REF = ? AND B_LEVEL != 0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				qbb = new QnABoardBean();
				qbb.setB_id(rs.getInt("b_id"));
				qbb.setU_id(rs.getString("U_ID"));
				qbb.setB_category(rs.getString("B_CATEGORY"));
				qbb.setB_view(rs.getInt("B_VIEW"));
				qbb.setB_title(rs.getString("B_TITLE"));
				qbb.setB_content(rs.getString("B_CONTENT"));
				qbb.setB_ip(rs.getString("B_IP"));
				qbb.setB_pwd(rs.getString("B_PWD"));
				qbb.setB_date(rs.getTimestamp("B_DATE"));
				qbb.setB_secret(rs.getString("B_SECRET"));
				qbb.setB_ref(rs.getInt("B_REF"));
				qbb.setB_step(rs.getInt("B_STEP"));
				qbb.setB_level(rs.getInt("B_LEVEL"));
				qbb.setB_fname(rs.getString("B_FNAME"));
				qbb.setB_fsize(rs.getInt("B_FSIZE"));
				qbb.setB_rfname(rs.getString("B_RFNAME"));
				qbb.setB_anschk(rs.getString("B_ANSCHK"));
			}
		} catch (SQLException ex) {
			System.out.print("조회 실패");
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return qbb;
	}
}


