<%@page import="dto.Payment_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("isAdminVerified")==null)
    {
        response.sendRedirect("home.html");
        return;
    }
    if(!(boolean)session.getAttribute("isAdminVerified"))
    {
        response.sendRedirect("home.html");
        return;
    }
    boolean showpayments = false;
    if(session.getAttribute("showpayments")!=null)
    {
        showpayments = (boolean)session.getAttribute("showpayments");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Admin Payment Details</title>
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
            background-attachment: fixed;
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
h1 {
    color: var(--black);
    font-size: 3.8rem;
    text-align: center;
    padding-top: 0.5rem;
    margin-bottom: 0.5rem;
}
table {
    width: 100%; 
    max-width: 1400px;
    border-collapse: collapse;
    margin-left: 2%;
    margin-bottom: 1rem; 
    background: var(--black);
    opacity: 0.7;
    border-radius: 10px;
    box-shadow: var(--box-shadow);
}
table td {
    padding: 1rem 1.5rem; 
    font-size: 20px; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}

input[type="text"] {
    width: 90%;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 20px;
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
        p {
    font-size: 2.5rem;
    text-align: left;
    color: var(--black);
    padding-top: 1rem;
    padding-bottom: 1rem;
}
        .btn {
            display: flex;
            justify-content: center;
            font-size: 2rem;
            font-weight: bolder;
            border-radius: 30px;
            color: var(--white);
            cursor: pointer;
            text-transform: capitalize;
            width: 200px;
            height: 35px;
            background: #507484;
            box-shadow: var(--box-shadow);
            margin: auto;
        }
        .btn:hover {
            background: transparent;
            color: var(--white);
        }

        </style>
    </head>
    <body>
        <header class="header">
            <a href="home.html" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <form action="Admin_Home.jsp" method="get">
                    <input type="submit" value="Home" class="nav-btn">
                </form>
                <a></a>
                <form action="Admin_Logout.jsp" method="get">
                    <input type="submit" value="Logout" class="nav-btn">
                </form>
            </nav>
        </header>
        
        <div class="main-content">
        <h1>Hello Admin!</h1>
        <br>
        <p style="margin-left: 28%">Enter student id/course id/both to fetch the payment details!</p>
        <!-- <a href="Admin_Home.jsp">Home</a> -->
        <form action="Check_Payment_Input" method="POST">
            <table>
                <tr>
                    <td>Student Id</td>
                    <td>Course Id</td>
                    <td>Action</td>
                </tr>
                <tr>
                    <td><input type="text" name="studentid"></td>
                    <td><input type="text" name="courseid"></td>
                    <td><input type="Submit" value="Search"  class="btn"></td>
                </tr>
            </table>
            
            <BR>
            <%
            if(showpayments)
            {
            %>
                
            <p style="margin-left: 43%"><B>Payment Details</B></p>
                <table>
                    <tr>
                        <td>Student ID</td>
                        <td>Course ID</td>
                        <td>Payment Mode</td>
                        <td>Amount Paid</td>
                        <td>Transaction Date and Time</td>
                    </tr>
            <%
                    ArrayList <Payment_DTO> paymentDetailsList = new ArrayList <>((ArrayList)session.getAttribute("paymentDetailsList"));
                    if(paymentDetailsList.isEmpty())
                    {
            %>
                     <tr>
                        <td><input type="Text" value="No Data Found" readonly></td>
                        <td><input type="Text" value="No Data Found" readonly></td>
                        <td><input type="Text" value="No Data Found" readonly></td>
                        <td><input type="Text" value="No Data Found" readonly></td>
                        <td><input type="Text" value="No Data Found" readonly></td>
                    </tr>   
            <%
                    }
                    else
                    {
                        for(int i=0; i<paymentDetailsList.size(); i++)
                        {
            %>
                            <tr>
                                <td><input type="text" value="<%=paymentDetailsList.get(i).getStudentid()%>" readonly></td>
                                <td><input type="text" value="<%=paymentDetailsList.get(i).getCourseid()%>" readonly></td>
                                <td><input type="text" value="<%=paymentDetailsList.get(i).getPaymentmode()%>" readonly></td>
                                <td><input type="text" value="<%=paymentDetailsList.get(i).getCoursefee()%>" readonly></td>
                                <td><input type="text" value="<%=paymentDetailsList.get(i).getCurrentdatetime()%>" readonly></td>
                            </tr>
            <%
                        }
                    }
            %>
                </table>
            <%
            }
            %>
        </form>
        </div>
    </body>
</html>
