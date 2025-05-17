package model;

import db.DBConnector;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Trainer_Course_Students_List {

    private String courseid;
    private Connection con = DBConnector.getConnection();
    public Trainer_Course_Students_List(String courseid)
    {
        this.courseid = courseid;
    }
    
    public ArrayList fetchStudents()
    {
        ArrayList <Student_DTO> enrolledStudents = new ArrayList<>();
        enrolledStudents.clear();
        ArrayList <String> enrolledStudentsId = new ArrayList<>();
        enrolledStudentsId.clear();
        try
        {
            String query = "SELECT student_id FROM student_course_table WHERE course_id = ? AND enrolled='1'";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseid);
            System.out.println(query);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                enrolledStudentsId.add(rs.getString(1));
                
            }
            for(int i=0; i<enrolledStudentsId.size(); i++)
            {
                Student_DTO studentDetails = new Student_DTO();
                Student_Data_Extract getData = new Student_Data_Extract(enrolledStudentsId.get(i), studentDetails);
                enrolledStudents.add(getData.getStudentData());
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return enrolledStudents;
    }
    
    public ArrayList fetchDeletedStudents()
    {
        ArrayList <String> deletedStudentsId = new ArrayList<>();
        deletedStudentsId.clear();
        ArrayList<Student_DTO> deletedStudentsList = new ArrayList<>();
        try
        {
            String query = "SELECT student_id FROM student_course_table WHERE course_id = ? AND enrolled = '2'";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, courseid);
            System.out.println(query);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                deletedStudentsId.add(rs.getString(1));
            }
            for(int i=0; i<deletedStudentsId.size(); i++)
            {
                Student_DTO deletedStudent = new Student_DTO();
                Student_Data_Extract getData = new Student_Data_Extract(deletedStudentsId.get(i), deletedStudent);
                deletedStudentsList.add(getData.getStudentData());
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return deletedStudentsList;
    }
}
