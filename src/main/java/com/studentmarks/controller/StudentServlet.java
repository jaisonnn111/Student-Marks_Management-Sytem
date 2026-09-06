package com.studentmarks.controller;

import com.studentmarks.dao.impl.CurriculumDAOImpl;
import com.studentmarks.dao.impl.DepartmentDAOImpl;
import com.studentmarks.model.Department;
import com.studentmarks.model.Mark;
import com.studentmarks.model.Student;
import com.studentmarks.model.Subject;
import com.studentmarks.service.MarkService;
import com.studentmarks.service.MarkServiceImpl;
import com.studentmarks.service.StudentService;
import com.studentmarks.service.StudentServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    private StudentService studentService;
    private MarkService markService;

    @Override
    public void init() {
        studentService = new StudentServiceImpl();
        markService = new MarkServiceImpl();
    }

    // =====================================================
    // GET
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        // =================================================
        // ADD STUDENT PAGE
        // =================================================

        if ("add".equals(action)) {

            List<Department> departments =
                    new DepartmentDAOImpl()
                            .getAllDepartments();

            request.setAttribute(
                    "departments",
                    departments);

            request.getRequestDispatcher(
                    "/add-student.jsp")
                    .forward(request, response);

            return;
        }

        // =================================================
        // MARKS PAGE
        // ADD MARKS OR EDIT MARKS
        // =================================================

        if ("marks".equals(action)) {

            int studentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "studentId"));

            // Find student
            Student student =
                    studentService.getStudentById(
                            studentId);

            if (student == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Student not found");

                return;
            }

            // ---------------------------------------------
            // Get exactly 5 subjects from curriculum
            // using student's department + semester
            // ---------------------------------------------

            List<Subject> subjects =
                    new CurriculumDAOImpl()
                            .getSubjectsByDepartmentAndSemester(
                                    student.getDepartmentId(),
                                    student.getCurrentSemester());

            // ---------------------------------------------
            // Get existing marks for this student
            // ---------------------------------------------

            List<Mark> marks =
                    markService.getMarksByStudentAndSemester(
                            studentId,
                            student.getCurrentSemester());

            request.setAttribute(
                    "student",
                    student);

            request.setAttribute(
                    "subjects",
                    subjects);

            request.setAttribute(
                    "marks",
                    marks);

            request.getRequestDispatcher(
                    "/marks-form.jsp")
                    .forward(request, response);

            return;
        }

        // =================================================
        // DEFAULT - DISPLAY ALL STUDENTS
        // =================================================

        List<Student> students =
                studentService.getAllStudents();

        // -------------------------------------------------
        // Load all departments so JSP can display
        // department code such as CS / AIDS
        // instead of department ID
        // -------------------------------------------------

        List<Department> departments =
                new DepartmentDAOImpl()
                        .getAllDepartments();

        // Map:
        // student ID → true if marks exist

        Map<Integer, Boolean> marksStatus =
                new HashMap<>();

        for (Student student : students) {

            List<Mark> marks =
                    markService.getMarksByStudentAndSemester(
                            student.getStudentId(),
                            student.getCurrentSemester());

            boolean hasMarks =
                    marks != null
                    && !marks.isEmpty();

            marksStatus.put(
                    student.getStudentId(),
                    hasMarks);
        }

        request.setAttribute(
                "students",
                students);

        // Send departments to students.jsp
        request.setAttribute(
                "departments",
                departments);

        request.setAttribute(
                "marksStatus",
                marksStatus);

        request.getRequestDispatcher(
                "/students.jsp")
                .forward(request, response);
    }

    // =====================================================
    // POST
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding("UTF-8");

            String action =
                    request.getParameter("action");

            // =================================================
            // SAVE / UPDATE MARKS
            // =================================================

            if ("saveMarks".equals(action)) {

                int studentId =
                        Integer.parseInt(
                                request.getParameter(
                                        "studentId"));

                // ---------------------------------------------
                // Find student
                // ---------------------------------------------

                Student student =
                        studentService.getStudentById(
                                studentId);

                if (student == null) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Student not found");

                    return;
                }

                // ---------------------------------------------
                // Get curriculum subjects
                // ---------------------------------------------

                List<Subject> subjects =
                        new CurriculumDAOImpl()
                                .getSubjectsByDepartmentAndSemester(
                                        student.getDepartmentId(),
                                        student.getCurrentSemester());

                // ---------------------------------------------
                // Process all 5 subjects
                // ---------------------------------------------

                for (Subject subject : subjects) {

                    String parameterName =
                            "score_"
                            + subject.getSubjectCode();

                    String scoreValue =
                            request.getParameter(
                                    parameterName);

                    if (scoreValue == null
                            || scoreValue.isBlank()) {

                        throw new IllegalArgumentException(
                                "Please enter marks for "
                                + subject.getSubjectName());
                    }

                    double score =
                            Double.parseDouble(
                                    scoreValue);

                    Mark mark =
                            new Mark();

                    mark.setStudentId(
                            studentId);

                    mark.setSubjectCode(
                            subject.getSubjectCode());

                    mark.setScore(score);

                    /*
                     * MarkServiceImpl automatically decides:
                     *
                     * No existing mark → INSERT
                     * Existing mark    → UPDATE
                     */

                    markService.addMark(
                            mark,
                            student.getCurrentSemester());
                }

                // ---------------------------------------------
                // Return to student list
                // ---------------------------------------------

                response.sendRedirect(
                        request.getContextPath()
                        + "/students");

                return;
            }

            // =================================================
            // ADD STUDENT
            // =================================================

            String rollNo =
                    request.getParameter("rollNo");

            String firstName =
                    request.getParameter("firstName");

            String lastName =
                    request.getParameter("lastName");

            int departmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "departmentId"));

            int semester =
                    Integer.parseInt(
                            request.getParameter(
                                    "semester"));

            Student student =
                    new Student();

            student.setRollNo(
                    rollNo);

            student.setFirstName(
                    firstName);

            student.setLastName(
                    lastName);

            student.setDepartmentId(
                    departmentId);

            student.setCurrentSemester(
                    semester);

            studentService.addStudent(
                    student);

            response.sendRedirect(
                    request.getContextPath()
                    + "/students");

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    e.getMessage());

            /*
             * For marks errors, return to marks page
             * instead of incorrectly going to add-student.jsp.
             */

            String action =
                    request.getParameter("action");

            if ("saveMarks".equals(action)) {

                try {

                    int studentId =
                            Integer.parseInt(
                                    request.getParameter(
                                            "studentId"));

                    Student student =
                            studentService.getStudentById(
                                    studentId);

                    if (student != null) {

                        List<Subject> subjects =
                                new CurriculumDAOImpl()
                                        .getSubjectsByDepartmentAndSemester(
                                                student.getDepartmentId(),
                                                student.getCurrentSemester());

                        List<Mark> marks =
                                markService
                                        .getMarksByStudentAndSemester(
                                                studentId,
                                                student.getCurrentSemester());

                        request.setAttribute(
                                "student",
                                student);

                        request.setAttribute(
                                "subjects",
                                subjects);

                        request.setAttribute(
                                "marks",
                                marks);

                        request.getRequestDispatcher(
                                "/marks-form.jsp")
                                .forward(request, response);

                        return;
                    }

                } catch (Exception ignored) {
                    // Fall through to generic error handling
                }
            }

            // -------------------------------------------------
            // ADD STUDENT ERROR
            // -------------------------------------------------
            // Reload departments before returning to
            // add-student.jsp. Otherwise the JSP receives
            // departments = null and causes a 500 error.
            // -------------------------------------------------

            List<Department> departments =
                    new DepartmentDAOImpl()
                            .getAllDepartments();

            request.setAttribute(
                    "departments",
                    departments);

            request.getRequestDispatcher(
                    "/add-student.jsp")
                    .forward(request, response);
        }
    }
}