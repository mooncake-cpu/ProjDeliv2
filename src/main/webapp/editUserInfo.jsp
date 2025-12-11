<%@ page import="java.sql.*" %>
<%




try {
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/projectdb","root","school"
    );

    
    Statement st = con.createStatement();
    
    String user = request.getParameter("userid");
    String username = request.getParameter("username");
    String password = request.getParameter("pass");
    String address = request.getParameter("add");
    String phone = request.getParameter("phone");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");

    
    String sql = "SELECT * FROM End_User WHERE user_id = ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();
    if(!rs.next()){
    	out.print("User does not exist!"); %>
    	<a href="success.jsp">Back home</a> <% 
    	
    } else {
    	String sql2 = "SELECT username FROM eu_account WHERE user_id = ?";
    	PreparedStatement as = con.prepareStatement(sql2);
    	as.setString(1, user);

    	ResultSet ts = as.executeQuery();

    	String userz = null;

    	if (ts.next()) {
    	    userz = ts.getString("username");
    	    String sql3="UPDATE eu_account SET password = ? WHERE username = ?";
    	    PreparedStatement bc = con.prepareStatement(sql3);
        	bc.setString(1, password);
        	bc.setString(2, userz);  // second parameter for WHERE username = ?
        	

        	bc.executeUpdate();
        	
        	String sql4 = "UPDATE end_user SET first_name = ?, last_name = ?, address = ?, phone = ? WHERE userid = ?";
        	PreparedStatement lol = con.prepareStatement(sql4);
        	lol.setString(1, fname);
        	lol.setString(2, lname);
        	lol.setString(3, address);
        	lol.setString(4, phone);
        	lol.setString(5, user);

        	lol.executeUpdate();
        	

        	} else{
        		out.print("User does not exist!"); %>
            	<a href="success.jsp">Back home</a> <% 
        	}

        	}
    	
    

    


} catch(Exception e){
	java.io.StringWriter sw = new java.io.StringWriter();
    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
    e.printStackTrace(pw);

    out.println("<pre>" + sw.toString() + "</pre>");
}
%>


