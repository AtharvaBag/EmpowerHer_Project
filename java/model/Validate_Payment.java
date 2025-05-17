package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Payment_DTO;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Validate_Payment {
    
    private Payment_DTO paymentDetails;
    private Course_DTO courseDetails;
    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    public Validate_Payment(Payment_DTO paymentDetails, Course_DTO courseDetails, Student_DTO studentDetails)
    {
        this.paymentDetails= paymentDetails;
        this.courseDetails = courseDetails;
        this.studentDetails = studentDetails;
    }
    
    public boolean completeTransaction()
    {
        try
        {
            String query = "INSERT INTO student_payment_table (course_id, student_id, payment_mode, course_fee, payment_date_time) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseDetails.getCourseid());
            pst.setString(2, studentDetails.getStudentid());
            pst.setString(3, paymentDetails.getPaymentmode().toUpperCase());
            pst.setString(4, courseDetails.getCoursefee());
            pst.setString(5, paymentDetails.getCurrentdatetime());
            System.out.println(query);
            int i = pst.executeUpdate();
            if(i>0)
            {
                System.out.println("Transaction Successful");
                return true;
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
    
    
}
