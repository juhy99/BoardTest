<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn" %>
<%@ include file = "../include/sessioncheck.jsp" %>
<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	request.setCharacterEncoding("UTF-8");
	
	
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("name");
	String b_idx =  request.getParameter("b_idx");
	String b_title = request.getParameter("b_title");
	String b_content = request.getParameter("b_content");
	
	String sql = "";
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			sql = "update tb_board set b_title=?,b_content=?,b_userid=?,b_username=? where b_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_title);
			pstmt.setString(2, b_content);
			pstmt.setString(3, userid);
			pstmt.setString(4, username);
			pstmt.setString(5, b_idx);
			pstmt.executeUpdate();
%>						
			<script>
				alert('변경되었습니다!');
				location.href='view.jsp?b_idx=<%=b_idx%>';
			</script>
<%
		}else{
%>
			<script>
				alert('수정실패!');
				history.back();
			</script>
<%
			}
	}catch(Exception e){
		e.printStackTrace();
	}
%>