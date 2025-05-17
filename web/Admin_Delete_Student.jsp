<%@page import="dto.Course_DTO"%>
<%@page import="dto.Student_DTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        if(session.getAttribute("isAdminVerified")==null || session.getAttribute("studentDetails")==null || session.getAttribute("courseDetails")==null)
        {
            response.sendRedirect("home.html");
            return;
        }
        if(!(boolean)session.getAttribute("isAdminVerified"))
        {
            response.sendRedirect("home.html");
            return;
        }
        Student_DTO studentDetails = (Student_DTO)session.getAttribute("studentDetails");
        Course_DTO courseDetails = (Course_DTO)session.getAttribute("courseDetails");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Admin Delete Student</title>
        <style>
            * {
            font-family: 'Nunito', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            border: none;
            outline: none;
            text-decoration: none;
            transition: all .4s linear;
        }
        :root {
            --green: #90bcc4;
            --light-green: #f0fdfa;
            --light-color: #777;
            --light-white: #eee;
            --black: #444;
            --white: #fff;
            --border: .2rem solid var(--black);
            --box-shadow: 0 0.8rem 1rem rgba(0, 0, 0, .5);
        }
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body{
            background-image: url('images/EmpowerHer background Image.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed; 
            background-repeat: no-repeat;
            height: 100vh;

        }
        html {
            font-size: 62.5%;
            overflow-x: hidden;
        }
        .home {
            display: flex;
            align-items: center;
            justify-content: center;
           
            height: 100vh;
        }
        .header {
            position: sticky;
            top: 0;
            left: 0;
            right: 0;
            background-color: var(--black);
            box-shadow: var(--box-shadow);
            padding: 2rem 10%;
            display: flex;
            align-items: center;
            z-index: 1000;
        }
        .header .logo {
            color: var(--light-white);
            margin-right: auto;
            font-size: 2.5rem;
            font-weight: bolder;
        }
        .header .logo span {
            color: var(--green);
        }
        .navbar {
            position: relative;
        }
        .navbar #close-navbar {
            position: absolute;
            top: 1.5rem;
            right: 2rem;
            font-size: 4rem;
            cursor: pointer;
            color: var(--black);
            display: none;
        }
        .navbar #close-navbar:hover {
            transform: rotate(90deg);
        }
        .navbar a {
            color: var(--light-white);
            margin-right: 2rem;
            font-size: 2rem;
            font-weight: bold;
        }
        .navbar a:hover {
            color: var(--green);
        }
        .icons div {
            cursor: pointer;
            font-size: 2.5rem;
            color: var(--light-white);
            margin-left: 1.5rem;
        }
        .icons div:hover {
            color: var(--green);
        }
        #menu-btn {
            display: none;
        }
        .navbar form {
    display: inline-block;
    margin-right: 2rem;
}

.nav-btn {
    background: none;
    color: var(--light-white);
    font-size: 2rem;
    font-weight: bold;
    border: none;
    cursor: pointer;
    transition: color 0.4s;
}

.nav-btn:hover {
    color: var(--green);
}
h2{
    font-size: 2.5rem;
    font-weight: bolder;
    text-align: center;
    color: var(--black);
    padding-top: 1rem;
}
table {
    width: 100%; 
    max-width: 900px;
    border-collapse: collapse; 
    margin-bottom: 1rem; 
    background: var(--black);
    opacity: 0.7;
    border-radius: 10px;
    box-shadow: var(--box-shadow);
    margin-left: 20%;
}
table td {
    padding: 1rem; 
    font-size: 20px; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
input[type="text"] {
    width: 250px;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 10px;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
}
.main-content {
            width: 100%; 
            margin: auto;
            padding: 4rem;
        }
        .btn{
            display: inline-block;
            font-size: 2rem;
            font-weight: bolder;
            border-radius: 30px;
            color: var(--white);
            cursor: pointer;
            text-transform: capitalize;
            width: 250px;
            height: 35px;
            background: #507484;
            box-shadow: var(--box-shadow);
        }
        .btn:hover {
            background: transparent;
            color: var(--white);
        }
        </style>
    </head>
    <body>
        <header class="header">
            <a href="Admin_Home.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                 <form action="Admin_Home.jsp" method="POST">
                    <input type="submit" value="Home" class="nav-btn">
                </form>
                <form>
                </form>
                <form action="Admin_Students_Deletion_List.jsp" method="POST">
                    <input type="submit" value="Back" class="nav-btn">
                </form>
                
               
            </nav>
        </header>
        <br><br>
        <h2>Student Id: <%=studentDetails.getStudentid()%></h2>
        <h2>Enrolled in <span style="color: #507484"><%=courseDetails.getCoursetitle()%></span> (Course ID: <%=courseDetails.getCourseid()%>)</h2>
        <div class="main-content">
            <form action="Admin_Cancel_Student_Deletion" method="POST">  
                <table>
                  
                  <tr>
                      <td>Your Name: </td>
                      <td><input type="text" value="<%=studentDetails.getStudentname()%>" name="studentname" id="studentname"></td>
                  </tr>
                  <tr>
                      <td>Contact Number: </td>
                      <td><input type="text" value="<%=studentDetails.getStudentcontact()%>" name="studentcontact" id="studentcontact"></td>
                  </tr>
                  <tr>
                      <td>Email Id: </td>
                      <td><input type="text" value="<%=studentDetails.getStudentmailid()%>" name="studentmailid" id="studentmailid"></td>
                  </tr>
                  <tr>
                      <td><input type="Submit" class="btn" value="Cancel Deletion"></td>
                      <td><input type="Button" class="btn" value="Remove From Course" onclick="location.href='Admin_Remove_Student.jsp'"></td>
                  </tr>
             </table>
              </form>
        </div>
      
      
    </body>
</html>
