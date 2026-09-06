<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.studentmarks.model.Department" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Add Student</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 25px;
        }

        form {
            width: 400px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 9px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .error {
            color: red;
            margin-bottom: 15px;
        }

        .back {
            margin-top: 20px;
            display: inline-block;
        }

    </style>

</head>

<body>

    <h1>Add Student</h1>

    <%

        String errorMessage =
                (String) request.getAttribute("errorMessage");

        if (errorMessage != null) {

    %>

        <div class="error">

            <%= errorMessage %>

        </div>

    <%

        }

    %>


    <form method="post"
          action="<%= request.getContextPath() %>/students">


        <label for="rollNo">

            Roll Number / USN

        </label>

        <input type="text"
               id="rollNo"
               name="rollNo"
               required>


        <label for="firstName">

            First Name

        </label>

        <input type="text"
               id="firstName"
               name="firstName"
               required>


        <label for="lastName">

            Last Name

        </label>

        <input type="text"
               id="lastName"
               name="lastName">


        <label for="departmentId">

            Department

        </label>

        <select id="departmentId"
                name="departmentId"
                required>

            <option value="">

                -- Select Department --

            </option>

            <%

                List<Department> departments =
                        (List<Department>)
                        request.getAttribute("departments");

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


        <label for="semester">

            Current Semester

        </label>

        <select id="semester"
                name="semester"
                required>

            <option value="">

                -- Select Semester --

            </option>

            <%

                for (int semester = 1;
                     semester <= 8;
                     semester++) {

            %>

                <option value="<%= semester %>">

                    Semester <%= semester %>

                </option>

            <%

                }

            %>

        </select>


        <button type="submit">

            Add Student

        </button>

    </form>


    <a class="back"
       href="<%= request.getContextPath() %>/students">

        Back to Student List

    </a>


</body>

</html>