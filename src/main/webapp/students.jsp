<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.studentmarks.model.Student" %>
<%@ page import="com.studentmarks.model.Department" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Management</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 25px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
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

        .actions a {
            margin-right: 8px;
        }

        .add-student {
            display: inline-block;
            margin-bottom: 20px;
        }

        .dashboard-button {
            display: inline-block;
            margin-left: 15px;
            padding: 8px 15px;
            text-decoration: none;
            background-color: #333;
            color: white;
            border-radius: 5px;
        }

    </style>

</head>

<body>

<h1>Admin Student Management</h1>


<a class="add-student"
   href="<%= request.getContextPath() %>/students?action=add">

    Add Student

</a>


<a class="dashboard-button"
   href="<%= request.getContextPath() %>/admin-dashboard">

    Back to Admin Dashboard

</a>


<br>
<br>


<%

    List<Student> students =
            (List<Student>) request.getAttribute("students");

    List<Department> departments =
            (List<Department>) request.getAttribute("departments");

    Map<Integer, Boolean> marksStatus =
            (Map<Integer, Boolean>)
                    request.getAttribute("marksStatus");

%>


<table>

    <tr>

        <th>Roll Number</th>

        <th>First Name</th>

        <th>Last Name</th>

        <th>Department</th>

        <th>Semester</th>

        <th>Actions</th>

    </tr>


<%

    if (students != null && !students.isEmpty()) {

        for (Student student : students) {

            boolean hasMarks = false;

            if (marksStatus != null
                    && marksStatus.containsKey(
                            student.getStudentId())) {

                hasMarks =
                        marksStatus.get(
                                student.getStudentId());

            }

%>


    <tr>

        <!-- Roll Number -->
        <td>

            <%= student.getRollNo() %>

        </td>


        <!-- First Name -->
        <td>

            <%= student.getFirstName() %>

        </td>


        <!-- Last Name -->
        <td>

            <%= student.getLastName() == null
                    ? ""
                    : student.getLastName() %>

        </td>


        <!-- Department -->
        <td>

<%

            String departmentCode = "";

            if (departments != null) {

                for (Department department : departments) {

                    if (department.getDepartmentId()
                            == student.getDepartmentId()) {

                        departmentCode =
                                department.getDepartmentCode();

                        break;

                    }

                }

            }

%>

            <%= departmentCode %>

        </td>


        <!-- Semester -->
        <td>

            <%= student.getCurrentSemester() %>

        </td>


        <!-- Actions -->
        <td class="actions">

<%

            if (hasMarks) {

%>

                <a href="<%= request.getContextPath() %>/students?action=marks&studentId=<%= student.getStudentId() %>">

                    Edit Marks

                </a>

<%

            } else {

%>

                <a href="<%= request.getContextPath() %>/students?action=marks&studentId=<%= student.getStudentId() %>">

                    Add Marks

                </a>

<%

            }

%>

        </td>

    </tr>


<%

        }

    } else {

%>


    <tr>

        <td colspan="6">

            No students found.

        </td>

    </tr>


<%

    }

%>


</table>


</body>

</html>