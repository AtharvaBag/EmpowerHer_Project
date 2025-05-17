package model;

import db.DBConnector;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Student_Data_Extract {

    private Student_DTO studentDetails;
    private String studentid;
    private Connection con = DBConnector.getConnection();
    public Student_Data_Extract(Student_DTO studentDetails)
    {
        this.studentDetails = studentDetails;
    }
    
    public Student_Data_Extract(String studentid, Student_DTO studentDetails)
    {
        this.studentid = studentid;
        this.studentDetails = studentDetails;
    }
    
    public void studentData()
    {
        try
        {
            String query = "SELECT student_id, student_mailid FROM student_table WHERE student_contact = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentcontact().trim());
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                studentDetails.setStudentid(rs.getString(1));
                studentDetails.setStudentmailid(rs.getString(2));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    
    
    public Student_DTO getStudentData()
    {
        try
        {
            String query = "SELECT student_name, student_contact, student_mailid FROM student_table WHERE student_id = ?";
            studentDetails.setStudentid(studentid);
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentid);
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                studentDetails.setStudentname(rs.getString(1));
                studentDetails.setStudentcontact(rs.getString(2));
                studentDetails.setStudentmailid(rs.getString(3));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return studentDetails;
    }
}
