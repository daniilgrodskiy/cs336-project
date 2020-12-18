<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.HashMap"%>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("admin")) {
	response.sendRedirect("../success.jsp");
}
%>

<%

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");

	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(total_fare) as revenue, email,first_name, last_name, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid group by email order by last_name");
    HashMap<String, Integer> map = new HashMap<String, Integer>();
    while (rs.next()) {
        if(!map.containsKey(rs.getString("email"))){
            map.put(rs.getString("email"), (Integer)rs.getInt("revenue"));
        }else{
            map.put(rs.getString("email"), map.get(rs.getString("email")) + (Integer)rs.getInt("revenue"));
        }
    }
    int max = -1;
    String email = "";
    for (String i : map.keySet()) {
      System.out.println(i + " " + map.get(i));
      if(map.get(i) > max){
        max = map.get(i);
        email = i;
       }
    }
    System.out.println(email);
    String result = "";
    if(max != -1){
        ResultSet temp = st.executeQuery("select sum(total_fare) as revenue, email,first_name, last_name, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid group by email order by last_name");
        result = "The customer who spent the most amount is ";
        while(temp.next()){
            if (temp.getString("email").equals(email)){
                result += temp.getString("first_name") + " " + temp.getString("last_name") + "!";
                break;
            }
        }
    }else{
        result = "We have not had any customers yet.";
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

	<h1>Best Customer</h1>
    <p><%=result %></p>

	</div>

	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	</body>


</html>
