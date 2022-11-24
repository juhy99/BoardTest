package com.koreait.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Dbconn {
    private static Connection conn;
    public static Connection getConnection() throws SQLException, ClassNotFoundException { //sql과 연결메소드
        String url = "jdbc:mysql://127.0.0.1/aidev?useSSL=false";   //경로지정
        String uid = "root";        //mysql아이디
        String upw = "1234";        //mysql비번
        Class.forName("com.mysql.cj.jdbc.Driver");  //mysql 드라이버 등록
        conn = DriverManager.getConnection(url,uid,upw); //DriverManager를 통해 구동할때 필요한값 등록
        return conn;
    }
}
