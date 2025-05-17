package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Enroll_Student {
    private Course_DTO courseDetails;
    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    public Enroll_Student(Course_DTO courseDetails, Student_DTO studentDetails)
    {
        this.courseDetails = courseDetails;
        this.studentDetails = studentDetails;
    }
    
    public void enrollCourse()
    {
        try
        {
            String query = "INSERT INTO student_course_table (course_id, student_id, enrolled) VALUES (?, ?, '1')";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseDetails.getCourseid().trim());
            pst.setString(2, studentDetails.getStudentid().trim());
            System.out.println(query);
            int j = pst.executeUpdate();
            if(j>0)
            {
                System.out.println("Student student enrolled successfully!");
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    
    public void enrollWishedCourse()
    {
        try
        {
            String query = "UPDATE student_course_table SET enrolled='1' WHERE student_id = ? AND course_id= ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentid());
            pst.setString(2, courseDetails.getCourseid());
            System.out.println(query);
            int j = pst.executeUpdate();
            if(j>0)
            {
                System.out.println("Student enrolled to wishlisted course successfully!");
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    
    public void wishlistCourse()
    {
        try
        {
            String query = "INSERT INTO student_course_table (course_id, student_id, enrolled) VALUES (?, ?, '0')";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseDetails.getCourseid().trim());
            pst.setString(2, studentDetails.getStudentid().trim());
            System.out.println(query);
            int j = pst.executeUpdate();
            if(j>0)
            {
                System.out.println("Course added to widhlist successfully!");
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}

