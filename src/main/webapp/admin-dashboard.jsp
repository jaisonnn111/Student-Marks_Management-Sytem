<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Dashboard</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .menu {
            margin-top: 30px;
        }

        .menu a {
            display: inline-block;
            margin: 10px;
            padding: 15px 25px;
            border: 1px solid #ccc;
            text-decoration: none;
            color: black;
        }

    </style>

</head>

<body>

<h1>Admin Dashboard</h1>

<p>
    Welcome, Admin.
</p>

<div class="menu">

    <a href="<%= request.getContextPath() %>/students">
        Manage Students
    </a>

    <a href="<%= request.getContextPath() %>/result">
        View Results
    </a>

    <a href="<%= request.getContextPath() %>/admin-logout">
        Logout
    </a>

</div>

</body>

</html>