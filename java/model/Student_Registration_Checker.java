package model;

import db.DBConnector;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Student_Registration_Checker {

    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    
    public Student_Registration_Checker(Student_DTO studentDetails)
    {
        this.studentDetails = studentDetails;
    }
    
    public boolean areDetailsValid()
    {
        if(studentDetails.getStudentname().trim().equals("") || studentDetails.getStudentcontact().trim().equals("") || studentDetails.getStudentmailid().equals("") || studentDetails.getStudentpassword().trim().equals("") || studentDetails.getStudentconfirmpassword().trim().equals(""))
        {
                return false;
        }
        return true;
    }
    
    public boolean isContactCorrect()
    {
        if(studentDetails.getStudentcontact().trim().length() != 10)
        {
            return false;
        }
        return true;
    }
    
    public boolean isMailIdCorrect()
    {
         if(studentDetails.getStudentmailid().contains("@") && (studentDetails.getStudentmailid().contains(".com") || studentDetails.getStudentmailid().contains(".org") || studentDetails.getStudentmailid().contains(".edu")))
        {
            return true;
        }
        System.out.println("Invalid mail id");
        return false;
    }
    
    public boolean isPasswordCorrect()
    {
        if(studentDetails.getStudentpassword().equals(studentDetails.getStudentconfirmpassword()) && studentDetails.getStudentpassword().length()>=8)
        {
            return true;
        }
        System.out.println("Password Correct");
        return false;
    }
    
    public void registerStudent()
    {
        try
        {
            String query = "INSERT INTO student_table (student_name, student_mailid, student_contact, student_password) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentname().trim().toUpperCase());
            pst.setString(2, studentDetails.getStudentmailid().trim());
            pst.setString(3, studentDetails.getStudentcontact().trim());
            pst.setString(4, studentDetails.getStudentpassword().trim());
            pst.executeUpdate();
            
            String query2 = "SELECT student_id FROM student_table WHERE student_name = ? AND student_contact= ?";
            pst = con.prepareStatement(query2);
            pst.setString(1, studentDetails.getStudentname().trim());
            pst.setString(2, studentDetails.getStudentcontact().trim());
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                studentDetails.setStudentid(rs.getString(1));
            }
            System.out.println("Student registered, id: "+studentDetails.getStudentid());
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
