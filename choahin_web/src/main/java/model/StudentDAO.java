package model;

import java.sql.*;
import java.util.ArrayList;

public class StudentDAO {

	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	public StudentDAO() { //db 연결
		String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
		String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user = "scott";
		String pwd = "tiger";

		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, user, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public StudentLoginDO checkLogin(StudentLoginDO loginDO) { //로그인
		
		StudentLoginDO result = null;
		this.sql = "select * from Student_login where id = ? and passwd = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginDO.getId());
			pstmt.setString(2, loginDO.getPasswd());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = new StudentLoginDO();
				result.setId(rs.getString("id"));
				result.setPasswd(rs.getString("passwd"));
				result.setName(rs.getString("name"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public int insertStudent(StudentDO studentDO) { //학생 정보 입력
		
		int rowCount = 0;
		this.sql = "insert into Student (stuid, stuname, gender, korea, english, math, science) values(?,?,?,?,?,?,?)";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, studentDO.getStuid());
			pstmt.setString(2, studentDO.getStuname());
			pstmt.setString(3, studentDO.getGender());
			pstmt.setInt(4, studentDO.getKorea());
			pstmt.setInt(5, studentDO.getEnglish());
			pstmt.setInt(6, studentDO.getMath());
			pstmt.setInt(7, studentDO.getScience());
			rowCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	public ArrayList<StudentDO> showStudent() { //학생 정보 조회
		
		ArrayList<StudentDO> studentList = new ArrayList<StudentDO>();
		StudentDO studentDO = null;
		this.sql = "select * from Student";
		
		try {
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				studentDO = new StudentDO();
				studentDO.setStuid(rs.getString("stuid"));
				studentDO.setStuname(rs.getString("stuname"));
				studentDO.setGender(rs.getString("gender"));
				studentDO.setKorea(rs.getInt("korea"));
				studentDO.setEnglish(rs.getInt("english"));
				studentDO.setMath(rs.getInt("math"));
				studentDO.setScience(rs.getInt("science"));
				
				studentList.add(studentDO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return studentList;
	}
	
	public int modifyStudent(StudentDO studentDO) { //학생 정보 수정
		
		int rowCount = 0;
		this.sql = "update Student set korea=?, english=?, math=?, science=? where stuid=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, studentDO.getKorea());
			pstmt.setInt(2, studentDO.getEnglish());
			pstmt.setInt(3, studentDO.getMath());
			pstmt.setInt(4, studentDO.getScience());
			pstmt.setString(5, studentDO.getStuid());
			
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	public int deleteStudent(StudentDO studentDO) { //학생 정보 삭제
		
		int rowCount = 0;
		this.sql = "delete from Student where stuid = ?"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, studentDO.getStuid());
			
			rowCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (!pstmt.isClosed()) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;

	}
	
	public void closeConnection() { 
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
