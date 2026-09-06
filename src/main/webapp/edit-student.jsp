<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.studentmarks.model.Student" %>
<%@ page import="com.studentmarks.model.Department" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
</head>

<body>

<h1>Edit Student</h1>

<%
    Student student =
            (Student) request.getAttribute("student");

    List<Department> departments =
            (List<Department>) request.getAttribute("departments");
%>

<form method="post"
      action="<%= request.getContextPath() %>/students">

    <input type="hidden"
           name="action"
           value="updateStudent">

    <input type="hidden"
           name="studentId"
           value="<%= student.getStudentId() %>">

    <p>
        <label>Roll Number:</label><br>
        <input type="text"
               name="rollNo"
               value="<%= student.getRollNo() %>"
               required>
    </p>

    <p>
        <label>First Name:</label><br>
        <input type="text"
               name="firstName"
               value="<%= student.getFirstName() %>"
               required>
    </p>

    <p>
        <label>Last Name:</label><br>
        <input type="text"
               name="lastName"
               value="<%= student.getLastName() == null ? "" : student.getLastName() %>">
    </p>

    <p>
        <label>Department:</label><br>

        <select name="departmentId" required>

            <%
                for (Department department : departments) {
            %>

                <option value="<%= department.getDepartmentId() %>"
                    <%= department.getDepartmentId()
                            == student.getDepartmentId()
                            ? "selected"
                            : "" %>>

                    <%= department.getDepartmentName() %>

                </option>

            <%
                }
            %>

        </select>
    </p>

    <p>
        <label>Semester:</label><br>

        <select name="semester" required>

            <%
                for (int semester = 1; semester <= 8; semester++) {
            %>

                <option value="<%= semester %>"
                    <%= semester == student.getCurrentSemester()
                            ? "selected"
                            : "" %>>

                    Semester <%= semester %>

                </option>

            <%
                }
            %>

        </select>
    </p>

    <button type="submit">
        Update Student
    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/students">
    Back to Students
</a>

</body>
</html>