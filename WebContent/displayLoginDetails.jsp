<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<%
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");
    String usertype = request.getParameter("userType");
    System.out.println(usertype);

    System.out.println(userid.equals(""));

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");

    Statement st = con.createStatement();
    ResultSet rs;
    if(usertype.equals("customer")){
    	rs = st.executeQuery("select * from customer where username='" + userid + "' and password='" + pwd + "'");
    } else if(usertype.equals("admin")){
    	rs = st.executeQuery("select * from admins where username='" + userid + "' and password='" + pwd + "'");
    } else{
    	rs = st.executeQuery("select * from reps where username='" + userid + "' and password='" + pwd + "'");
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
	<% if (rs.next() && !userid.equals("")) {
        session.setAttribute("user", userid);
        session.setAttribute("userType", usertype);

        if(usertype.equals("customer")){
        	session.setAttribute("userEmail", rs.getString("email"));
        }
        %><!-- the username will be stored in the session -->
        <p>Welcome <%=userid%></p>
        <p><a href='logout.jsp'>Log out</a></p>
        <% response.sendRedirect("success.jsp");
    } else {%>
        <p>Invalid login</p>
        <p><a href='login.jsp'>Try again</a></p>
    <% } %>

   </div>
   </body>
</html>
