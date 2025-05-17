<%@page import="dto.Student_DTO"%>
<%
        boolean isStudentLoggedId = false;
         Student_DTO studentDetails = null;
        if(session.getAttribute("isStudentLoggedIn") != null)
        {
            isStudentLoggedId = (boolean)session.getAttribute("isStudentLoggedIn");
             studentDetails = (Student_DTO)session.getAttribute("studentDetails");
        }
        if(!isStudentLoggedId || studentDetails==null)
        {
            response.sendRedirect("student_login.html");
            return;
        }
       
        
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Student Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        body {
            background-image: url('images/EmpowerHer background Image.png');
            background-size: cover;
            background-position: center;
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
    display: flex;
    gap: 2rem; 
    align-items: center;
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
        .btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 1rem 3rem;
            font-size: 2rem;
            font-weight: bolder;
            border: var(--border);
            border-radius: 8px;
            color: var(--black);
            cursor: pointer;
            text-transform: capitalize;
        }
        .btn:hover {
            background: #507484;
            color: var(--white);
        }
        h1 {
    margin-top: 35px;
    text-align: center; 
    color: var(--black);
    margin-bottom: 1rem;
    font-size: 35px; 
}
table {
    width: 100%; 
    max-width: 600px;
    border-collapse: collapse; 
    margin-top: 20px;
    margin-left: 455px;
    margin-bottom: 1rem; 
    background: var(--black);
    opacity: 0.7;
    border-radius: 10px;
    box-shadow: var(--box-shadow);
}
table td {
    padding: 2rem;
    font-size: 20px;
    font-weight: bolder; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
table th {
    padding: 3rem;
    font-size: 20px;
    font-weight: bolder; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
input[type="text"] {
    width: 100%;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
    
}
input[type="submit"],
input[type="reset"] 
{
            background-color: #507484;
            color: var(--white);
            box-shadow: var(--box-shadow);
            padding: 0.4rem 1rem; 
            cursor: pointer;
            border-radius: 25px;
            transition: background-color 0.3s;
            font-size: 20px; 
            font-weight: bold;
            width: 200px; 
            box-shadow: var(--box-shadow);
            border: 0px;
            margin-left: 15px;
        }
.btn {
            display: inline-block;
            margin-bottom: 15px;
            font-size: 2rem;
            font-weight: bolder;
            border-radius: 30px;
            color: var(--white);
            cursor: pointer;
            text-transform: capitalize;
            width: 200px;
            height: 40px;
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
         <!-- Header Section Starts -->
         <header class="header">
            <a href="Student_Home.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <a href="Student_Home.jsp">Home</a>
                <a href="Student_Profile_Delete.jsp">Delete Profile</a>
                <a href="Student_Logout.jsp">Logout</a>
                
            </nav>
        </header>
        <!-- Header Section Ends -->

        <h1>Student Details</h1>
        <!-- <h2>Student Id: <%=studentDetails.getStudentid()%></h2> -->
        <table>
            <form action="Student_profile_update" method="POST">
                
                <tr>
                    <th>Name: </th>
                    <td><input type="text" value="<%=studentDetails.getStudentname()%>" name="studentname" id="studentname"></td>
                </tr>
                <tr>
                    <th>Contact Number: </th>
                    <td><input type="text" value="<%=studentDetails.getStudentcontact()%>" name="studentcontact" id="studentcontact"></td>
                </tr>
                <tr>
                    <th>Email Id: </th>
                    <td><input type="text" value="<%=studentDetails.getStudentmailid()%>" name="studentmailid" id="studentmailid"></td>
                </tr>
                <tr>
                    <td><input type="reset" value="Reset" class="btn"></td>
                    <td><input type="Submit" value="Update Profile" class="btn"></td>
                </tr>
            </form>
        </table>
    </body>
</html>