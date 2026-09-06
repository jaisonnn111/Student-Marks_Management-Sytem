<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Marks Management System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #222;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 22px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .header p {
            margin: 8px 0 0;
            color: #d1d5db;
        }

        .container {
            width: 850px;
            max-width: 90%;
            margin: 70px auto;
            text-align: center;
        }

        .container h2 {
            margin-bottom: 10px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 40px;
        }

        .options {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .card {
            width: 330px;
            padding: 35px 30px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .card h2 {
            margin-top: 0;
            margin-bottom: 15px;
        }

        .card p {
            color: #666;
            min-height: 45px;
            line-height: 1.5;
        }

        .button {
            display: inline-block;
            padding: 12px 28px;
            margin-top: 15px;
            background: #1f2937;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .button:hover {
            background: #374151;
        }

        .footer {
            margin-top: 60px;
            color: #888;
            font-size: 14px;
        }

    </style>

</head>

<body>

    <div class="header">

        <h1>Student Result Management System</h1>

        <p>Manage and view student academic results</p>

    </div>


    <div class="container">

        <h2>Welcome</h2>

        <p class="subtitle">
            Please select your role to continue.
        </p>


        <div class="options">

            <!-- ADMIN -->

            <div class="card">

                <h2>Admin</h2>

                <p>
                    Manage students, marks and academic results.
                </p>

                <a class="button"
                   href="<%= request.getContextPath() %>/admin-login">
                    Admin Login
                </a>

            </div>


            <!-- STUDENT -->

            <div class="card">

                <h2>Student</h2>

                <p>
                    Enter your details and view your semester result.
                </p>

                <a class="button"
                   href="<%= request.getContextPath() %>/result">
                    Check Result
                </a>

            </div>

        </div>


        <div class="footer">

            Student Result Management System

        </div>

    </div>

</body>

</html>