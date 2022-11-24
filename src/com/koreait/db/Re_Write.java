package com.koreait.db;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.*;
import com.koreait.db.Dbconn;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Re_Write
 */
@WebServlet("/Re_Write")
public class Re_Write extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Re_Write() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
	    String b_idx = request.getParameter("b_idx");
	    String re_content = request.getParameter("re_content");
	   
	    String userid = (String)session.getAttribute("userid");	
	 	String name = (String)session.getAttribute("name");
	   
	 	PreparedStatement pstmt = null;
	 	Connection conn = null;
	 	try{
			conn=Dbconn.getConnection();
			if(conn != null){
				String sql = "insert into tb_reply(re_userid, re_username, re_content, re_boardidx) values(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,userid);
				pstmt.setString(2,name);
				pstmt.setString(3,re_content);
				pstmt.setString(4,b_idx);
				pstmt.executeUpdate();
			}
	 	}catch(Exception e){
	 		e.printStackTrace();
	 	}					
	 	writer.println("<script>alert('등록되었습니다!'); location.href='board/view.jsp?b_idx="+b_idx+"';</script>");

	}

}
