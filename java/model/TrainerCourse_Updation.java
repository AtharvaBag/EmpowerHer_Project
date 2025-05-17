package model;

import db.DBConnector;
import dto.Course_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class TrainerCourse_Updation 
{
    private Course_DTO updatedCourseDetails;
    private Connection con = DBConnector.getConnection();
    
    public TrainerCourse_Updation(Course_DTO updatedCourseDetails)
    {
        this.updatedCourseDetails = updatedCourseDetails;
    }
    
    public void updateCourse(String trainercourseid)
    {
        
        updatedCourseDetails.setCoursetitle(updatedCourseDetails.getCoursetitle().replace("'", "*"));
        updatedCourseDetails.setCourseclassname(updatedCourseDetails.getCourseclassname().replace("'", "*"));
        updatedCourseDetails.setCoursedescription(updatedCourseDetails.getCoursedescription().replace("'", "*"));
        updatedCourseDetails.setCourseclassaddress(updatedCourseDetails.getCourseclassaddress().replace("'", "*"));
        
        try
        {
            String query = "UPDATE course_table SET course_institute_name = ?, course_title = ?, "
                    + "course_viewers= ?, course_duration= ?, course_days_per_week= ?, course_mode= ?, "
                    + "course_institution_address= ?, course_institution_city= ?,"
                    + "course_institution_state= ?, course_description= ?, "
                    + "course_certification= ?, course_annual_fee = ?, course_skill_domain= ?"
                    + ", course_institute_contact= ? WHERE course_id= ?";
            
            String query2 = "UPDATE trainer_course_table SET verified='2' WHERE course_id = ?";
    
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, updatedCourseDetails.getCourseclassname().trim().toUpperCase());
            pst.setString(2, updatedCourseDetails.getCoursetitle().trim().toUpperCase());
            pst.setString(3, updatedCourseDetails.getCourseviewers().trim().toUpperCase());
            pst.setString(4, updatedCourseDetails.getCourseduration().trim());
            pst.setString(5, updatedCourseDetails.getCoursedays().trim());
            pst.setString(6, updatedCourseDetails.getCoursemode().trim().toUpperCase());
            pst.setString(7, updatedCourseDetails.getCourseclassaddress().trim().toUpperCase());
            pst.setString(8, updatedCourseDetails.getCourseclasscity().trim().toUpperCase());
            pst.setString(9, updatedCourseDetails.getCourseclassstate().trim().toUpperCase());
            pst.setString(10, updatedCourseDetails.getCoursedescription().trim());
            pst.setString(11, updatedCourseDetails.getCoursecertification().trim());
            pst.setString(12, updatedCourseDetails.getCoursefee().trim() );
            pst.setString(13, updatedCourseDetails.getTrainerskill().trim().toUpperCase());
            pst.setString(14, updatedCourseDetails.getCourseclasscontact().trim());
            pst.setString(15, trainercourseid);
            
            pst.executeUpdate();
            
            pst = con.prepareStatement(query2);
            pst.setString(1, trainercourseid);
            pst.executeUpdate();
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
