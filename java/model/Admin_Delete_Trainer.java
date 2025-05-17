package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Admin_Delete_Trainer {

    private String trainerid;
    public Admin_Delete_Trainer(String trainerid)
    {
        this.trainerid = trainerid;
    }
    
    public boolean deleteTrainer()
    {
        try
        {
            String query = "DELETE FROM trainer_table WHERE trainer_id = ?";
            String query2 = "DELETE FROM trainer_verification_table WHERE trainer_id = ?";
            String query3 = "SELECT course_id FROM trainer_course_table  WHERE trainer_id = ?";
            
            Connection con = DBConnector.getConnection();
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, trainerid);
            int j = pst.executeUpdate();
            
            pst = con.prepareStatement(query2);
            pst.setString(1, trainerid);
            pst.executeUpdate();
            
            ArrayList <String> courseList = new ArrayList<>();
            courseList.clear();
            
            pst = con.prepareStatement(query3);
            pst.setString(1, trainerid);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                courseList.add(rs.getString(1));
            }
            if(!courseList.isEmpty())
            {
                for(int i=0; i<courseList.size(); i++)
                {
                    pst = con.prepareStatement("DELETE FROM course_table WHERE course_id=?");
                    pst.setString(1, courseList.get(i));
                    pst.executeUpdate();
                    
                    pst = con.prepareStatement("DELETE FROM trainer_course_table WHERE course_id = ?");
                    pst.setString(1, courseList.get(i));
                    pst.executeUpdate();
                }
            }
            if(j>0)
            return true;
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
}
