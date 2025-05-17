package model;

import db.DBConnector;
import dto.Course_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TrainerCourse_Registration 
{
    private Course_DTO courseRegister;
    private Connection con = DBConnector.getConnection();
    
    public TrainerCourse_Registration(Course_DTO courseRegister)
    {
        this.courseRegister = courseRegister;
    }
    
    public boolean isDetailsValid()
    {
        if(courseRegister.getCourseclasscontact().trim().equals("") || courseRegister.getCourseclasscontact().trim().length()!=10 || courseRegister.getTrainerskill().trim().equals("") || courseRegister.getCoursetitle().trim().equals("") || courseRegister.getCourseclassname().trim().equals("") || courseRegister.getCoursedays().trim().equals("") || courseRegister.getCoursedescription().trim().equals("") || courseRegister.getCourseduration().trim().equals("") ||   courseRegister.getCoursecertification().trim().equals("") || courseRegister.getCoursefee().trim().equals("") || courseRegister.getCoursemode().trim().equals(""))
        {
            return false;
        }
        if((courseRegister.getCoursemode().equalsIgnoreCase("Offline") || courseRegister.getCoursemode().equalsIgnoreCase("Hybrid")) && (courseRegister.getCourseclassaddress().trim().equals("") || courseRegister.getCourseclasscity().trim().equals("") || courseRegister.getCourseclassstate().trim().equals("")))
        {
             return false;
        }
        return true;
    }
    
    public void registerCourse(String trainerid)
    {
        if(courseRegister.getCoursedescription().trim().length()>100)
        {
            courseRegister.setCoursedescription(courseRegister.getCoursedescription().substring(0,100).trim());
        }
        
        courseRegister.setCoursetitle(courseRegister.getCoursetitle().replace("'", "*"));
        courseRegister.setCourseclassname(courseRegister.getCourseclassname().replace("'", "*"));
        courseRegister.setCoursedescription(courseRegister.getCoursedescription().replace("'", "*"));
        courseRegister.setCourseclassaddress(courseRegister.getCourseclassaddress().replace("'", "*"));
        
        String query = "INSERT INTO course_table (course_institute_name, course_title, course_viewers, course_duration, course_days_per_week, course_mode, course_institution_address, course_institution_city, course_institution_state, course_description, course_certification, course_annual_fee, course_skill_domain, course_institute_contact)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                  
                
        String query2 = "SELECT course_id FROM course_table WHERE course_title= ? AND course_institute_contact= ?";
        
        
        try
                {
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, courseRegister.getCourseclassname().trim().toUpperCase());
                    pst.setString(2, courseRegister.getCoursetitle().trim().toUpperCase());
                    pst.setString(3, courseRegister.getCourseviewers().trim().toUpperCase());
                    pst.setString(4, courseRegister.getCourseduration().trim().toUpperCase());
                    pst.setString(5, courseRegister.getCoursedays().trim());
                    pst.setString(6, courseRegister.getCoursemode().trim().toUpperCase());
                    pst.setString(7, courseRegister.getCourseclassaddress().trim().toUpperCase());
                    pst.setString(8, courseRegister.getCourseclasscity().trim().toUpperCase());
                    pst.setString(9, courseRegister.getCourseclassstate().trim().toUpperCase());
                    pst.setString(10, courseRegister.getCoursedescription().trim());
                    pst.setString(11, courseRegister.getCoursecertification().trim());
                    pst.setString(12, courseRegister.getCoursefee().trim());
                    pst.setString(13, courseRegister.getTrainerskill().trim().toUpperCase());
                    pst.setString(14, courseRegister.getCourseclasscontact().trim());
                    
                    int i=0;
                    int j = pst.executeUpdate();
                    if(j>0)
                    {
                        System.out.println("Corse Registered Successfully!");
                        pst = con.prepareStatement(query2);
                        pst.setString(1, courseRegister.getCoursetitle().trim().toUpperCase());
                        pst.setString(2, courseRegister.getCourseclasscontact().trim());
                        ResultSet rs = pst.executeQuery();
                        if(rs.next())
                            courseRegister.setCourseid(rs.getString(1));
                        pst = con.prepareStatement("INSERT INTO trainer_course_table (trainer_id, course_id, verified) VALUES(?, ?, '0')");
                        pst.setString(1, trainerid.trim());
                        pst.setString(2, courseRegister.getCourseid().trim());
                        j = pst.executeUpdate();
                        if(j>0)
                             System.out.println("trainer_course_table updated");
                    }
                    
                }
                catch(SQLException e)
                {
                    System.out.println(e);
                }
    }
}
