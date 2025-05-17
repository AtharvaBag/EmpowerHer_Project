package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Student_DTO;
import dto.Trainer_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Admin_Get_Details {
    
    public Admin_Get_Details(){}

    private Connection con = DBConnector.getConnection();
    private String trainerid;
    public Admin_Get_Details(String trainerid)
    {
        this.trainerid = trainerid;
    }
    
    private Course_DTO courseDetails;
    public Admin_Get_Details(Course_DTO courseDetails)
    {
        this.courseDetails = courseDetails;
    }
    
    public ArrayList verifiedTrainers()
    {
        ArrayList <String> verifiedTrainerId = new ArrayList<>();
        ArrayList <Trainer_DTO> verifiedTrainers = new ArrayList<>();
        try
        {
                String query = "SELECT trainer_id FROM trainer_verification_table WHERE verified='1'";
                PreparedStatement pst = con.prepareStatement(query);
                ResultSet rs = pst.executeQuery();
                while(rs.next())
                {
                    verifiedTrainerId.add(rs.getString(1));
                }
                for(int i=0; i<verifiedTrainerId.size(); i++)
                {
                    pst = con.prepareStatement("SELECT trainer_name FROM trainer_table WHERE trainer_id= ?");
                    pst.setString(1, verifiedTrainerId.get(i));
                    rs = pst.executeQuery();
                    Trainer_DTO verifiedTrainerDetail = new Trainer_DTO();
                    verifiedTrainerDetail.setTrainerid(verifiedTrainerId.get(i));
                    if(rs.next())
                    {
                        verifiedTrainerDetail.setTrainername(rs.getString(1));
                    }
                    verifiedTrainers.add(verifiedTrainerDetail);
                }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return verifiedTrainers;
    }
    
    public ArrayList unverifiedTrainers()
    {
        ArrayList <String> unverifiedTrainerId = new ArrayList<>();
        ArrayList <Trainer_DTO> unverifiedTrainers = new ArrayList<>();
        try
        {
                String query = "SELECT trainer_id FROM trainer_verification_table WHERE verified='0' OR verified='2'";
                PreparedStatement pst = con.prepareStatement(query);
                ResultSet rs = pst.executeQuery();
                while(rs.next())
                {
                    unverifiedTrainerId.add(rs.getString(1));
                }
                for(int i=0; i<unverifiedTrainerId.size(); i++)
                {
                    pst = con.prepareStatement("SELECT trainer_name FROM trainer_table WHERE trainer_id= ?");
                    pst.setString(1, unverifiedTrainerId.get(i));
                    rs = pst.executeQuery();
                    Trainer_DTO unverifiedTrainerDetail = new Trainer_DTO();
                    unverifiedTrainerDetail.setTrainerid(unverifiedTrainerId.get(i));
                    if(rs.next())
                    {
                        unverifiedTrainerDetail.setTrainername(rs.getString(1));
                    }
                    unverifiedTrainers.add(unverifiedTrainerDetail);
                }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return unverifiedTrainers;
    }
    
    public Map verifiedCourse()
    {
        Map <String, String> verifiedCourseTrainerId = new HashMap<>();
        Map <Course_DTO, Trainer_DTO> verifiedCourseTrainer = new HashMap<>();
        try
        {
            String query = "SELECT course_id, trainer_id FROM trainer_course_table WHERE verified='1'";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                verifiedCourseTrainerId.put(rs.getString(1), rs.getString(2));
                System.out.println(verifiedCourseTrainerId.get(rs.getString(1)));
            }
            for(Map.Entry<String, String> entry : verifiedCourseTrainerId.entrySet())
            {
                pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id = ?");
                pst.setString(1, entry.getKey());
                rs = pst.executeQuery();
                Course_DTO courseDetails = new Course_DTO();
                courseDetails.setCourseid(entry.getKey());
                if(rs.next())
                {
                    courseDetails.setCoursetitle(rs.getString(1));
                }
                pst = con.prepareStatement("SELECT trainer_name FROM trainer_table WHERE trainer_id = ?");
                pst.setString(1, entry.getValue());
                rs = pst.executeQuery();
                Trainer_DTO trainerDetails = new Trainer_DTO();
                trainerDetails.setTrainerid(entry.getValue());
                if(rs.next())
                {
                    trainerDetails.setTrainername(rs.getString(1));
                }
                verifiedCourseTrainer.put(courseDetails, trainerDetails);
                
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return verifiedCourseTrainer;
    }
    
    public Map unverifiedCourse()
    {
        Map <String, String> unverifiedCourseTrainerId = new HashMap<>();
        Map <Course_DTO, Trainer_DTO> unverifiedCourseTrainer = new HashMap<>();
        try
        {
            String query = "SELECT course_id, trainer_id FROM trainer_course_table WHERE verified='0' OR verified='2'";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                unverifiedCourseTrainerId.put(rs.getString(1), rs.getString(2));
            }
            rs.close();
            for(Map.Entry<String, String> entry : unverifiedCourseTrainerId.entrySet())
            {
                pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id = ?");
                pst.setString(1, entry.getKey());
                rs = pst.executeQuery();
                Course_DTO courseDetails = new Course_DTO();
                courseDetails.setCourseid(entry.getKey());
                if(rs.next())
                {
                    courseDetails.setCoursetitle(rs.getString(1));
                }
                pst = con.prepareStatement("SELECT trainer_name FROM trainer_table WHERE trainer_id = ?");
                pst.setString(1, entry.getValue());
                rs = pst.executeQuery();
                Trainer_DTO trainerDetails = new Trainer_DTO();
                trainerDetails.setTrainerid(entry.getValue());
                if(rs.next())
                {
                    trainerDetails.setTrainername(rs.getString(1));
                }
                unverifiedCourseTrainer.put(courseDetails, trainerDetails);
                rs.close();
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return unverifiedCourseTrainer;
    }
    
    public boolean isTrainerVerified()
    {
        try
        {
            String query = "SELECT verified FROM trainer_verification_table WHERE trainer_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, trainerid);
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                if(rs.getString(1).equals("1"))
                {
                    System.out.println("Trainer is verified : " + trainerid);
                    return true;
                }
                else
                {
                    System.out.println("Trainer is not verified : " + trainerid);
                    return false;
                }
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
    
    public ArrayList coursesWithDeletionRequest()
    {
        ArrayList <String> deltetionRequestCoursesId = new ArrayList<>();
        ArrayList <Course_DTO> deletetionRequestCourses = new ArrayList<>();
        try
        {
            String query = "SELECT DISTINCT course_id FROM student_course_table WHERE enrolled = '2'";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                deltetionRequestCoursesId.add(rs.getString(1));
            }
            for(int i=0; i<deltetionRequestCoursesId.size(); i++)
            {
                pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id = ?");
                pst.setString(1, deltetionRequestCoursesId.get(i));
                rs = pst.executeQuery();
                Course_DTO courseDetails = new Course_DTO();
                courseDetails.setCourseid(deltetionRequestCoursesId.get(i));
                if(rs.next())
                {
                    courseDetails.setCoursetitle(rs.getString(1));
                }
                deletetionRequestCourses.add(courseDetails);
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return deletetionRequestCourses;
     }
    
    public ArrayList getDeletionStudents()
    {
        ArrayList <Student_DTO> deletionStudentsList = new ArrayList<>();
        ArrayList <String> deletionStudentId = new ArrayList<>();
        try
        {
            String query = "SELECT student_id FROM student_course_table WHERE course_id = ? AND enrolled='2'";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseDetails.getCourseid());
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                deletionStudentId.add(rs.getString(1));
            }
            for(int i=0; i<deletionStudentId.size(); i++)
            {
                pst = con.prepareStatement("SELECT student_name FROM student_table WHERE student_id = ?");
                pst.setString(1, deletionStudentId.get(i));
                rs = pst.executeQuery();
                Student_DTO studentDetails = new Student_DTO();
                studentDetails.setStudentid(deletionStudentId.get(i));
                if(rs.next())
                {
                    studentDetails.setStudentname(rs.getString(1));
                }
                deletionStudentsList.add(studentDetails);
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return deletionStudentsList;
    }
}
