<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.Calendar" %>
<%@ page import ="java.util.HashMap"%>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("admin")) {
	response.sendRedirect("../success.jsp");
}
%>


<%
	//LocalDate currentdate = LocalDate.now();
	int month = Calendar.getInstance().get(Calendar.MONTH)+1;

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");

	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select rid, t2.tid, email, first_name, last_name, date, total_fare, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid order by last_name");
	int sales = 0;
	HashMap<String, Integer> map = new HashMap<String, Integer>();
	while(rs.next()){
		String m = rs.getString("date");
		if(Integer.parseInt(m.split("-")[1]) == month){
            if(!map.containsKey(rs.getString("transit_line_name"))){
                map.put(rs.getString("transit_line_name"), 0);
            }else{
                map.put(rs.getString("transit_line_name"), map.get(rs.getString("transit_line_name")) + 1);
            }
        }
	}
	String[] output = new String[5];
	int[] output1 = new int[5];
	int k = 0;
	while(map.size()>0 && k<5){
	    int max = -1;
	    String line = "";
	    for(String i : map.keySet()){
	        if(map.get(i) > max){
	            max = map.get(i);
	            line = i;
	        }
	    }
	    map.remove(line);
	    output[k] = line;
	    output1[k] = max;
	    k++;
	}

%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>

	<body>
	
	<div class="flex-nav">
  		<div>
  			<h1 id="title">Trainy </h1>
  		</div>
		<div class="userCard">
		 	<p id="userType">Customer</p>
		 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
			<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
		</div>
   	</div>

	<div id="content">
	<h1>Most Active Lines this month</h1>
	<table>
    	<tr>
    		<th>Transit Line Name</th>
    		<th>Number of Reservations</th>
    	</tr>

    	<%for (int i = 0; i < k; i++){%>
    		<tr>
    		<td><%=output[i] %></td>
    		<td><%=output1[i] %></td>
    		</tr>
    	<%} %>
    	</table>
	</div>

		<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>


	</body>


</html>
