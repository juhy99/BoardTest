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
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "delete from tb_board where b_idx=? and b_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,b_idx);
			pstmt.setString(2, userid);
			pstmt.executeUpdate();
%>						
			<script>
				alert('삭제되었습니다!');
				location.href='list.jsp';
			</script>
<%
		}else{
%>
			<script>
				alert('삭제실패!');
				history.back();
			</script>
<%
			}
	}catch(Exception e){
		e.printStackTrace();
	}
%>