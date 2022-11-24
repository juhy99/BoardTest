<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.koreait.db.Dbconn" %>
<%@ include file = "../include/sessioncheck.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
/* 	ResultSet rs_date = null; */
	int tot = 0;
	int pagePerCount = 10; //페이지당 글 갯수
	int start=0;
	int total = 0; 
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum != null && !pageNum.equals("")){
		start = (Integer.parseInt(pageNum)-1)*pagePerCount;
	}else{
		pageNum = "1";
		start=0;
	}
	
	try{
		conn = Dbconn.getConnection();
		
		if(conn != null){
			String sql = "select count(b_idx) as tot from tb_board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				tot = rs.getInt("tot");
			}
			total = tot;
			
			sql = "select * from tb_board order by b_idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,start);
			pstmt.setInt(2,pagePerCount);
			rs = pstmt.executeQuery();
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
	table{
		width:800px;
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid black;
		padding: 10px;
	}
	
	img{
		width: 16px;
	}
</style>
</head>
<body>
	<h2>리스트</h2>
	<p>총 게시글 : <%=tot%>개</p>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>날짜</th>
			<th>좋아요</th>
		</tr>
<%
	total = tot - start;
	while(rs.next()){
		String b_idx = rs.getString("b_idx");
		String b_title = rs.getString("b_title");
		String b_userid = rs.getString("b_userid");
		String b_username = rs.getString("b_username");
		String b_regdate = rs.getString("b_regdate");
		int b_hit = rs.getInt("b_hit");
		String b_like = rs.getString("b_like");
		
		
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = transFormat.parse(b_regdate);
		long now = System.currentTimeMillis();
		long inputDate = date.getTime();
		
		String sql = "select count(re_idx) as cnt from tb_reply where re_boardidx=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		ResultSet rs_reply = pstmt.executeQuery();
		String replyCnt = "";
		
		if(rs_reply.next()){
			int cnt = rs_reply.getInt("cnt");
			if(cnt > 0){
				replyCnt = "["+cnt+"]";
			}
		}
		
		
/* 		sql = "SELECT TIMESTAMPDIFF(day, ?, now()) dateCnt";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, b_regdate);
		rs_date = pstmt.executeQuery();
		String dateNew= "";
		if(rs_date.next()){
			int dateCnt = rs_date.getInt("dateCnt");
			if(dateCnt < 3){
				dateNew = "new";
			}
		} */
		
%>		
		<tr>
			<td><%=total %></td>
			<td><a href="view.jsp?b_idx=<%=b_idx %>"><%=b_title %></a> <%=replyCnt %> <%-- <%=dateNew %> --%>
			<%
				if(now - inputDate < (1000*60*60*24*2)){
			%>
					<img src="./new.png" alt="새글">
			<%
				}
			%>
				
			</td>
			<td><%=b_userid %>(<%=b_username %>)</td>
			<td><%=b_hit %></td>
			<td><%=b_regdate %></td>
			<td><%=b_like %></td>
		</tr>
<%
		total--;
	}

	int pageNums = 0;
	if(tot % pagePerCount == 0){
		pageNums = (tot/pagePerCount);
	}else{
		pageNums = (tot/pagePerCount)+1;
	}
%>
		<tr>
			<td colspan="6">
			<%
				for(int i=1; i<=pageNums; i++){
					out.print("<a href='list.jsp?pageNum="+i+"'>["+i+"]</a>&nbsp;&nbsp;&nbsp;");
				}
			%>
			</td>
		</tr>
	</table>
	<p><a href='write.jsp'>글쓰기</a><a href='../login.jsp'>돌아가기</a></p>
</body>
</html>