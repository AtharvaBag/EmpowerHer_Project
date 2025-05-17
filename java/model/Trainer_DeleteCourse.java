package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Trainer_DeleteCourse {
    private String trainercourseid;
    private Connection con = DBConnector.getConnection();
    public Trainer_DeleteCourse(String trainercourseid)
    {
        this.trainercourseid = trainercourseid;
    }
    
    public void deleteCourse()
    {
        try
        {
            String query = "DELETE FROM course_table WHERE course_id= ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, trainercourseid);
            pst.executeUpdate();
            
            String query2 = "DELETE FROM trainer_course_table WHERE course_id= ?";
             pst = con.prepareStatement(query2);
            pst.setString(1, trainercourseid);
            System.out.println(query+"      "+query2);
            pst.execute();
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
