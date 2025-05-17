package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Admin_Delete_Course {

    private String courseid;
    public Admin_Delete_Course(String courseid)
    {
        this.courseid = courseid;
    }
    
    public boolean deleteCourse()
    {
        try
        {
            String query = "DELETE FROM course_table WHERE course_id = ?";
            String query2 = "DELETE FROM trainer_course_table WHERE course_id = ?";
            String query3 = "DELETE FROM student_course_table WHERE course_id = ?";
            
            System.out.println(query+"\n"+query2+"\n"+query3);
            Connection con = DBConnector.getConnection();
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseid);
            int i = pst.executeUpdate();
            
            pst = con.prepareStatement(query2);
            pst.setString(1, courseid);
            int j = pst.executeUpdate();
            
            pst = con.prepareStatement(query3);
            pst.setString(1, courseid);
            pst.executeUpdate();
            
            if(i!=0 && j!=0)
                return true;
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
}
