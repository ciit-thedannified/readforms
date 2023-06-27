<%@ page import="ciit.thedannified.labex.readforms.Database" %>
<%@ page import="ciit.thedannified.labex.readforms.SessionUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title> Home | Quiz Website </title>
</head>
<body>
    <%!
        String username;            // Holds the client's username in this current session
        String score;               // FOR DEBUGGING: for tracking the score
        boolean hasTakenQuiz;       // Determines if the client has already taken the quiz.
    %>

    <%
        if (SessionUtils.hasUserLoggedIn(request, response)) {
            username = session.getAttribute("username").toString();     // Retrieve the client's username in this current session.
            hasTakenQuiz = Database.hasTakenQuiz(username);             // Check if the user has already taken the quiz by checking the database records.

            // If the client has taken the quiz before, then we can retrieve the user's latest quiz score
            if (hasTakenQuiz) score = session.getAttribute("score").toString();
        }
        else response.sendRedirect("./");
    %>

    <h1> Welcome, <%= /* Print client's */ username %>! </h1>
    <br /> <br />

    <!-- Go to the Exam Page -->
    <a href="./exam.jsp"> <%= /* Option's wording dynamically adjusts depending on */ hasTakenQuiz /* variable */ ? "Retake" : "Take" %> the Quiz </a> <br />
    <!-- Fetch all users' quiz scores -->
    <a href="./grades.jsp"> View Grades </a> <br />
    <!-- Signs out the user -->
    <a href="./logout.jsp"> Log out </a> <br />

</body>
</html>