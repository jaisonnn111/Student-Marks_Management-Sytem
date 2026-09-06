package com.studentmarks.dao;

import com.studentmarks.model.Student;

import java.util.List;

public interface StudentDAO {

    void addStudent(Student student);

    void updateStudent(Student student);

    void deleteStudent(int studentId);

    Student getStudentById(int studentId);

    Student getStudentByRollNo(String rollNo);

    List<Student> getAllStudents();
}