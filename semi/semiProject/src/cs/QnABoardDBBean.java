package cs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QnABoardDBBean {
	private static QnABoardDBBean instance = new QnABoardDBBean();

	public static QnABoardDBBean getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	public int insertBoard(QnABoardBean qBoard) throws Exception {
		String sql = "SELECT MAX(B_ID) FROM qna_board";

		int re = -1;
		int number;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int bid = qBoard.getB_id();
		int ref = qBoard.getB_ref();
		int step = qBoard.getB_step();
		int level = qBoard.getB_level();
		String ugrade = qBoard.getU_grade();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			
			if (bid != 0) {
				sql = "UPDATE qna_board SET B_STEP = B_STEP+1 WHERE B_REF = ? AND B_STEP > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				step = step + 1;
				level = level + 1;
			} else {
				ref = number;
				step = 0;
				level = 0;
			}
			sql = "INSERT INTO qna_board VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, number);
			pstmt.setString(2, qBoard.getU_id());
			pstmt.setString(3, qBoard.getB_category());
			pstmt.setInt(4, qBoard.getB_view());	
			pstmt.setString(5, qBoard.getB_title());
			pstmt.setString(6, qBoard.getB_content());
			pstmt.setString(7, qBoard.getB_ip());
			pstmt.setString(8, qBoard.getB_pwd());
			pstmt.setTimestamp(9, qBoard.getB_date());
			pstmt.setString(10, qBoard.getB_secret());
			pstmt.setInt(11, ref);
			pstmt.setInt(12, step);
			pstmt.setInt(13, level);
			pstmt.setString(14, qBoard.getB_fname());
			pstmt.setInt(15, qBoard.getB_fsize());
			pstmt.setString(16, qBoard.getB_rfname());
			pstmt.setString(17, "N");
			pstmt.executeUpdate();
			
			if(ref != number) {
				sql = "UPDATE qna_board SET B_ANSCHK = 'Y' WHERE B_REF=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qBoard.getB_ref());
				pstmt.executeUpdate();
			}
			
			re=1;
		} catch (SQLException ex) {
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
		return re;
	}

	public ArrayList<QnABoardBean> listBoard(int startRow, int pageSize) throws Exception {
		String sql = "SELECT B_ID, U_ID, B_CATEGORY, B_VIEW, B_TITLE, B_CONTENT\r\n" + 
				"     , B_IP, B_PWD, B_DATE, B_SECRET, B_REF, B_STEP, B_LEVEL\r\n" + 
				"     , B_FNAME, B_FSIZE, B_RFNAME, B_ANSCHK\r\n" + 
				"  FROM (SELECT ROWNUM AS rnum, A.* \r\n" + 
				"          FROM (SELECT * FROM QNA_BOARD ORDER BY B_REF DESC, B_STEP) A)\r\n" + 
				" WHERE rnum >= ? AND rnum <= ?";		// 페이지에 글을 몇 개 보여주는지 제한하는 쿼리
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		ArrayList<QnABoardBean> list = new ArrayList<QnABoardBean>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, startRow+pageSize-1);
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

	public QnABoardBean getBoard(int b_id, boolean hitAdd) throws Exception {
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
					"  FROM QNA_BOARD WHERE B_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				qbb = new QnABoardBean();
				qbb.setB_id(b_id);
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

	public QnABoardBean getFileName(int b_id) throws Exception {
		String sql = "SELECT B_FNAME, B_RFNAME FROM qna_board where B_ID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnABoardBean bb = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bb = new QnABoardBean();
				bb.setB_fname(rs.getString("B_FNAME"));
				bb.setB_rfname(rs.getString("B_RFNAME"));
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
		return bb;
	}
	
	public int getCount(QnABoardBean qbb) throws Exception {
		String sql = "SELECT COUNT(*) FROM qna_board";
		int re=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnABoardBean qboard = new QnABoardBean();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,qboard.getB_anschk());
			rs = pstmt.executeQuery();
			if (rs.next()) {
					re = rs.getInt(1); // 글 갯수
			} else {
					re = 0; // 글 없음
			}
		}catch (SQLException ex) {
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
		return re;
	}
	public int getReplyCount(QnABoardBean qbb) throws Exception {
		String sql = "SELECT COUNT(*) FROM qna_board WHERE B_ANSCHK = 'N'";
		int re=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				re = rs.getInt(1); // 글 갯수
			} else {
				re = 0; // 글 없음
			}
		}catch (SQLException ex) {
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
		return re;
	}
	
	public int deleteBoard(String b_pwd, int b_id) throws Exception {
		String sql = "SELECT B_PWD FROM qna_board WHERE B_ID = ?"; // 게시글에 맞는 비밀번호 조회
		int re = -1;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String db_pwd = rs.getString("B_PWD"); // 속성값에 조회한 비밀번호 입력
				if (db_pwd.equals(b_pwd)) {
					sql = "DELETE FROM qna_board WHERE B_ID = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, b_id);
					pstmt.executeUpdate();
					re = 1; // 번호, 비밀번호 일치
				} else {
					re = 0; // 비밀번호 불일치
				}
			} else {
				re = -1;
			}
		} catch (SQLException ex) {
			System.out.print("삭제 실패");
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
		return re;
	}

	public int editBoard(QnABoardBean qbb) throws Exception {
		String sql = "SELECT B_PWD FROM qna_board WHERE B_ID = ?"; // 게시글에 맞는 비밀번호 조회
		int re = -1; // 수정 실패
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qbb.getB_id());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String db_pwd = rs.getString("B_PWD"); // 속성값에 조회한 비밀번호 입력
				if (db_pwd.equals(qbb.getB_pwd())) {
					sql = "UPDATE qna_board SET B_CATEGORY=?, B_TITLE=?, B_CONTENT=? WHERE B_ID=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,qbb.getB_category());
					pstmt.setString(2,qbb.getB_title());
					pstmt.setString(3,qbb.getB_content());
					pstmt.setInt(4, qbb.getB_id());
					pstmt.executeUpdate();
					re = 1; // 수정 성공
				} else {
					re = 0; // 비밀번호 불일치
				}
			} else {
				re = -1; // 조회 실패
			}
		}catch (SQLException ex) {
			System.out.print("수정 실패");
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
		return re;
	}
	public ArrayList<QnABoardBean> adminListBoard(int startRow, int pageSize) throws Exception {
		String sql = "SELECT B_ID, U_ID, B_CATEGORY, B_VIEW, B_TITLE, B_CONTENT\r\n" + 
				"     , B_IP, B_PWD, B_DATE, B_SECRET, B_REF, B_STEP, B_LEVEL\r\n" + 
				"     , B_FNAME, B_FSIZE, B_RFNAME, B_ANSCHK\r\n" + 
				"  FROM (SELECT ROWNUM AS rnum, A.* \r\n" + 
				"          FROM (SELECT * FROM QNA_BOARD ORDER BY B_REF DESC, B_STEP) A)\r\n" + 
				" WHERE rnum >= ? AND rnum <= ? AND B_ANSCHK = 'N'";		// 답글이 없는 글만 불러오는 쿼리
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		ArrayList<QnABoardBean> adminList = new ArrayList<QnABoardBean>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, startRow+pageSize-1);
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
				
				adminList.add(qbb);
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
		return adminList;
	}
}
