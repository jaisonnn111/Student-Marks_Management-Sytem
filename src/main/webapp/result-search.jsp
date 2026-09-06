<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.studentmarks.model.Department" %>

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

        form {
            width: 500px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
        }

        .error {
            color: red;
            margin-bottom: 15px;
        }

    </style>

</head>

<body>

    <h1>View Student Result</h1>

    <%
        String errorMessage =
                (String) request.getAttribute("errorMessage");

        List<Department> departments =
                (List<Department>)
                request.getAttribute("departments");
    %>

    <% if (errorMessage != null) { %>

        <div class="error">
            <strong>Error:</strong>
            <%= errorMessage %>
        </div>

    <% } %>


    <form method="post"
          action="<%= request.getContextPath() %>/result">

        <label>
            Roll Number / USN
        </label>

        <input type="text"
               name="rollNo"
               required>


        <label>
            First Name
        </label>

        <input type="text"
               name="firstName"
               required>


        <label>
            Last Name
        </label>

        <input type="text"
               name="lastName">


        <label>
            Department
        </label>

        <select name="departmentId" required>

            <option value="">
                -- Select Department --
            </option>

            <%
                if (departments != null) {

                    for (Department department : departments) {
            %>

                <option value="<%= department.getDepartmentId() %>">

                    <%= department.getDepartmentCode() %>
                    -
                    <%= department.getDepartmentName() %>

                </option>

            <%
                    }
                }
            %>

        </select>


        <label>
            Semester
        </label>

        <select name="semester" required>

            <option value="">
                -- Select Semester --
            </option>

            <% for (int i = 1; i <= 8; i++) { %>

                <option value="<%= i %>">
                    Semester <%= i %>
                </option>

            <% } %>

        </select>


        <button type="submit">
            View Result
        </button>

    </form>

    <br>

    <%
    Boolean adminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");

    if (Boolean.TRUE.equals(adminLoggedIn)) {
%>

    <br>
    <a href="<%= request.getContextPath() %>/students">
        Back to Student Management
    </a>

<%
    }
%>

</body>

</html>