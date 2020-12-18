<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="com.cs336.eliza.Revenue" %>

<%

	//get sort param, if exists
	//can be either trans (sort by transit line) or name (sort by customer last name)
	String sort = "";
	try {
		sort = request.getParameter("sort"); 
	} catch (Exception e) {
	} finally{
		if(sort == null){sort = "trans";}
	}
	

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	//get all reservations, including transit line name
	Statement st = con.createStatement();
	ResultSet rs;
	
	String transSort = "select sum(total_fare) as revenue,  first_name, last_name, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid group by transit_line_name order by transit_line_name";
	String nameSort = "select sum(total_fare) as revenue, email,first_name, last_name, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid group by email order by last_name";
	
	if(sort.equals("trans")){
		rs = st.executeQuery(transSort);
	} else{
		rs = st.executeQuery(nameSort);
	}
	
	LinkedList<Revenue> revs = new LinkedList<Revenue>();
	while(rs.next()){
		String fn = rs.getString("first_name");
		String ln = rs.getString("last_name");
		String t = rs.getString("transit_line_name");
		int re = rs.getInt("revenue");
		Revenue r = new Revenue(fn, ln, t, re);
		revs.add(r);
	}
	
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div id="content">
	<h1>Revenue Listing</h1>
	<table>
	<tr>
		<%if(sort.equals("trans")){ %>
		<th>Transit Line Name</th>
		<%} else {%>
		<th>Customer First Name</th>
		<th>Customer Last Name</th>
		<% }%>
		<th>Revenue</th>
	</tr>
	
	<%for (int i = 0; i < revs.size(); i++){%>
		<tr>
		<%if(sort.equals("trans")){ %>
		<td><%=revs.get(i).getTrans() %></td>
		<%} else {%>
		<td><%=revs.get(i).getFname() %></td>
		<td><%=revs.get(i).getLname() %></td>
		<% }%>
		<td><%=revs.get(i).getRev() %></td>
		</tr>
	<%} %>
	</table>
	
	<form action="revenueListing.jsp" method="POST">
	<button type="submit" name="sort" value="trans">Revenue per transit line</button>
	</form>
	
	<form action="revenueListing.jsp" method="POST">
	<button type="submit" name="sort" value="name">Revenue per customer</button>
	</form>
	
	</div>
	
	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
