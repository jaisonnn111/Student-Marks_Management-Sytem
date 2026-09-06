package com.studentmarks.service;

import com.studentmarks.dao.StudentDAO;
import com.studentmarks.dao.DepartmentDAO;

import com.studentmarks.dao.impl.StudentDAOImpl;
import com.studentmarks.dao.impl.DepartmentDAOImpl;

import com.studentmarks.model.Student;
import com.studentmarks.model.Department;

import java.util.List;

public class StudentServiceImpl implements StudentService {

    private final StudentDAO studentDAO;
    private final DepartmentDAO departmentDAO;

    public StudentServiceImpl() {

        this.studentDAO = new StudentDAOImpl();
        this.departmentDAO = new DepartmentDAOImpl();
    }

    @Override
    public void addStudent(Student student) {

        validateStudent(student);

        // Check whether department exists
        Department department =
                departmentDAO.getDepartmentById(
                        student.getDepartmentId());

        if (department == null) {
            throw new IllegalArgumentException(
                    "Department does not exist.");
        }

        // Check duplicate roll number
        Student existingStudent =
                studentDAO.getStudentByRollNo(
                        student.getRollNo());

        if (existingStudent != null) {
            throw new IllegalArgumentException(
                    "A student with this roll number already exists.");
        }

        studentDAO.addStudent(student);
    }

    @Override
    public void updateStudent(Student student) {

        if (student.getStudentId() <= 0) {
            throw new IllegalArgumentException(
                    "Invalid student ID.");
        }

        validateStudent(student);

        Department department =
                departmentDAO.getDepartmentById(
                        student.getDepartmentId());

        if (department == null) {
            throw new IllegalArgumentException(
                    "Department does not exist.");
        }

        Student existingStudent =
                studentDAO.getStudentById(
                        student.getStudentId());

        if (existingStudent == null) {
            throw new IllegalArgumentException(
                    "Student does not exist.");
        }

        studentDAO.updateStudent(student);
    }

    @Override
    public void deleteStudent(int studentId) {

        if (studentId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid student ID.");
        }

        Student student =
                studentDAO.getStudentById(studentId);

        if (student == null) {
            throw new IllegalArgumentException(
                    "Student does not exist.");
        }

        studentDAO.deleteStudent(studentId);
    }

    @Override
    public Student getStudentById(int studentId) {

        if (studentId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid student ID.");
        }

        return studentDAO.getStudentById(studentId);
    }

    @Override
    public Student getStudentByRollNo(String rollNo) {

        if (rollNo == null || rollNo.isBlank()) {
            throw new IllegalArgumentException(
                    "Roll number is required.");
        }

        return studentDAO.getStudentByRollNo(
                rollNo.trim());
    }

    @Override
    public List<Student> getAllStudents() {

        return studentDAO.getAllStudents();
    }

    private void validateStudent(Student student) {

        if (student == null) {
            throw new IllegalArgumentException(
                    "Student cannot be null.");
        }

        if (student.getRollNo() == null
                || student.getRollNo().isBlank()) {

            throw new IllegalArgumentException(
                    "Roll number is required.");
        }

        if (student.getFirstName() == null
                || student.getFirstName().isBlank()) {

            throw new IllegalArgumentException(
                    "First name is required.");
        }

        if (student.getCurrentSemester() < 1
                || student.getCurrentSemester() > 8) {

            throw new IllegalArgumentException(
                    "Semester must be between 1 and 8.");
        }

        if (student.getDepartmentId() <= 0) {

            throw new IllegalArgumentException(
                    "Valid department is required.");
        }
    }
}