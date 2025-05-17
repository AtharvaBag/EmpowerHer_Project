package model;

import db.DBConnector;
import dto.Payment_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Payment_Details {

    private String courseid;
    private String studentid;
    private Connection con = DBConnector.getConnection();
    public Payment_Details(String courseid, String studentid)
    {
        this.courseid = courseid;
        this.studentid = studentid;
    }
    
    public Payment_DTO getPaymentDetails()
    {
        Payment_DTO paymentDetails = new Payment_DTO();
        try
        {
            String query = "SELECT payment_mode, course_fee, payment_date_time FROM student_payment_table WHERE student_id = ? AND course_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentid);
            pst.setString(2, courseid);
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                paymentDetails.setPaymentmode(rs.getString(1));
                paymentDetails.setCoursefee(rs.getString(2));
                paymentDetails.setCurrentdatetime(rs.getString(3));
            }
            paymentDetails.setCourseid(courseid);
            paymentDetails.setStudentid(studentid);
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return paymentDetails;
    }
}
