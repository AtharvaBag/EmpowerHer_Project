<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            session.invalidate();
            response.sendRedirect("home.html");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
