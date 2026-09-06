<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Login</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }

        .login-container {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
        }

        button {
            width: 100%;
            padding: 11px;
            margin-top: 25px;
            cursor: pointer;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<div class="login-container">

    <h1>Admin Login</h1>

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
          action="<%= request.getContextPath() %>/admin-login">

        <label>Username</label>

        <input type="text"
               name="username"
               required>


        <label>Password</label>

        <input type="password"
               name="password"
               required>


        <button type="submit">
            Login
        </button>

    </form>

    <a class="back"
       href="<%= request.getContextPath() %>/">

        Back to Home

    </a>

</div>

</body>

</html>