<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.studentmarks.model.Student" %>
<%@ page import="com.studentmarks.model.Subject" %>
<%@ page import="com.studentmarks.model.Mark" %>
<%@ page import="java.util.List" %>

<%
    Student student = (Student) request.getAttribute("student");
    List<Subject> subjects =
            (List<Subject>) request.getAttribute("subjects");

    List<Mark> marks =
            (List<Mark>) request.getAttribute("marks");

    String errorMessage =
            (String) request.getAttribute("errorMessage");

    boolean hasMarks =
            marks != null && !marks.isEmpty();
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>
        <%= hasMarks ? "Edit Marks" : "Add Marks" %>
    </title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 25px;
        }

        .student-info {
            margin-bottom: 30px;
        }

        .student-info p {
            margin: 8px 0;
        }

        table {
            border-collapse: collapse;
            width: 700px;
        }

        th,
        td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        input[type="number"] {
            width: 100px;
            padding: 6px;
        }

        .error {
            color: red;
            margin-bottom: 20px;
        }

        .button {
            margin-top: 20px;
            padding: 10px 20px;
        }

    </style>

</head>

<body>

<h1>
    <%= hasMarks ? "Edit Marks" : "Add Marks" %>
</h1>

<%
    if (errorMessage != null) {
%>

    <div class="error">
        <%= errorMessage %>
    </div>

<%
    }
%>

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
        <strong>Department ID:</strong>
        <%= student.getDepartmentId() %>
    </p>

    <p>
        <strong>Semester:</strong>
        <%= student.getCurrentSemester() %>
    </p>

</div>

<form method="post"
      action="<%= request.getContextPath() %>/students">

    <input type="hidden"
           name="action"
           value="saveMarks">

    <input type="hidden"
           name="studentId"
           value="<%= student.getStudentId() %>">

    <table>

        <tr>
            <th>Subject Code</th>
            <th>Subject Name</th>
            <th>Marks</th>
        </tr>

<%
    for (Subject subject : subjects) {

        double existingScore = 0;
        boolean markFound = false;

        if (marks != null) {

            for (Mark mark : marks) {

                if (subject.getSubjectCode()
                        .equals(mark.getSubjectCode())) {

                    existingScore = mark.getScore();
                    markFound = true;
                    break;
                }
            }
        }
%>

        <tr>

            <td>
                <%= subject.getSubjectCode() %>
            </td>

            <td>
                <%= subject.getSubjectName() %>
            </td>

            <td>

                <input type="number"
                       name="score_<%= subject.getSubjectCode() %>"
                       min="0"
                       max="100"
                       step="0.01"
                       value="<%= markFound ? existingScore : "" %>"
                       required>

            </td>

        </tr>

<%
    }
%>

    </table>

    <br>

    <button type="submit" class="button">

        <%= hasMarks ? "Update Marks" : "Save Marks" %>

    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/students">
    Back to Student Management
</a>

</body>

</html>