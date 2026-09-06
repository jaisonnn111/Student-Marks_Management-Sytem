<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.studentmarks.model.Result" %>
<%@ page import="com.studentmarks.model.Student" %>
<%@ page import="com.studentmarks.model.Department" %>
<%@ page import="com.studentmarks.model.Mark" %>
<%@ page import="com.studentmarks.dao.SubjectDAO" %>
<%@ page import="com.studentmarks.dao.impl.SubjectDAOImpl" %>
<%@ page import="com.studentmarks.model.Subject" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Result</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 25px;
        }

        .student-info {
            margin-bottom: 25px;
            padding: 15px;
            border: 1px solid #ccc;
            width: 600px;
        }

        .student-info p {
            margin: 8px 0;
        }

        table {
            border-collapse: collapse;
            width: 800px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }

        th {
            background-color: #f2f2f2;
        }

        .summary {
            margin-top: 25px;
            width: 400px;
        }

        .summary p {
            font-size: 18px;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
        }

    </style>

</head>

<body>

    <%
        Result result =
                (Result) request.getAttribute("result");

        if (result == null) {
    %>

        <h1>Result Not Available</h1>

        <p>
            The requested result could not be found.
        </p>

        <a href="<%= request.getContextPath() %>/result">
            Search Again
        </a>

    <%
            return;
        }

        Student student =
                result.getStudent();

        Department department =
                result.getDepartment();

        SubjectDAO subjectDAO =
                new SubjectDAOImpl();
    %>


    <h1>Student Result</h1>


    <!-- =========================================
         STUDENT INFORMATION
         ========================================= -->

    <div class="student-info">

        <p>
            <strong>Roll Number:</strong>
            <%= student.getRollNo() %>
        </p>

        <p>
            <strong>Student Name:</strong>
            <%= student.getFirstName() %>
            <%= student.getLastName() == null
                    ? ""
                    : student.getLastName() %>
        </p>

        <p>
            <strong>Department:</strong>
            <%= department.getDepartmentName() %>
        </p>

        <p>
            <strong>Semester:</strong>
            <%= result.getSemester() %>
        </p>

    </div>


    <!-- =========================================
         SUBJECT-WISE MARKS
         ========================================= -->

    <table>

        <tr>
            <th>Subject Code</th>
            <th>Course / Subject</th>
            <th>Marks</th>
            <th>Grade</th>
        </tr>


        <%
            for (Mark mark : result.getMarks()) {

                Subject subject =
                        subjectDAO.getSubjectByCode(
                                mark.getSubjectCode());
        %>

        <tr>

            <td>
                <%= mark.getSubjectCode() %>
            </td>

            <td>
                <%= subject != null
                        ? subject.getSubjectName()
                        : "Unknown Subject" %>
            </td>

            <td>
                <%= mark.getScore() %>
            </td>

            <td>
                <%= mark.getGrade() %>
            </td>

        </tr>

        <%
            }
        %>

    </table>


    <!-- =========================================
         RESULT SUMMARY
         ========================================= -->

    <div class="summary">

        <p>
            <strong>Total Marks:</strong>
            <%= result.getTotalMarks() %> / 500
        </p>

        <p>
            <strong>Percentage:</strong>
            <%= result.getPercentage() %>%
        </p>

        <p>
            <strong>Overall Grade:</strong>
            <%= result.getOverallGrade() %>
        </p>

    </div>


    <a class="back"
       href="<%= request.getContextPath() %>/result">

        Back

    </a>
    <%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (Boolean.TRUE.equals(adminLoggedIn)) {
%>
<br/>
    <a href="<%= request.getContextPath() %>/students">
        Back to Student Management
    </a>

<%
    }
%>

</body>

</html>