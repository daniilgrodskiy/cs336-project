<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="com.cs336.eliza.Reservation" %>

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
	
	String transSort = "select rid, t2.tid, email, first_name, last_name, date, total_fare, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid order by transit_line_name";
	String nameSort = "select rid, t2.tid, email, first_name, last_name, date, total_fare, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid order by last_name";
	
	if(sort.equals("trans")){
		rs = st.executeQuery(transSort);
	} else{
		rs = st.executeQuery(nameSort);
	}
	
	LinkedList<Reservation> reservations = new LinkedList<Reservation>();
	while(rs.next()){
		int id = rs.getInt("rid");
		String e = rs.getString("email");
		String fn = rs.getString("first_name");
		String ln = rs.getString("last_name");
		String t = rs.getString("transit_line_name");
		int f = rs.getInt("total_fare");
		Date d = rs.getDate("date");
		Reservation r = new Reservation(id, f, e, fn, ln, t, d);
		reservations.add(r);
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
	<h1>List of Reservations</h1>
	<table>
	<tr>
		<th>Reservation ID</th>
		<th>Customer Email</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Transit Line Name</th>
		<th>Total fare</th>
		<th>Date</th>
	</tr>
	
	<%for (int i = 0; i < reservations.size(); i++){%>
		<tr>
		<td><%=reservations.get(i).getRid() %></td>
		<td><%=reservations.get(i).getEmail() %></td>
		<td><%=reservations.get(i).getFname() %></td>
		<td><%=reservations.get(i).getLname() %></td>
		<td><%=reservations.get(i).getTrans() %></td>
		<td><%=reservations.get(i).getFare() %></td>
		<td><%=reservations.get(i).getDate() %></td>
		</tr>
	<%} %>
	</table>
	
	<form action="reservationList.jsp" method="POST">
	<button type="submit" name="sort" value="trans">Sort by transit line</button>
	</form>
	
	<form action="reservationList.jsp" method="POST">
	<button type="submit" name="sort" value="name">Sort by customer last name</button>
	</form>
	
	</div>
	
	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
