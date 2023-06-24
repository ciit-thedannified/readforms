<!--
    **************************************************************************
    COURSE SUBJECT: CSELEC1 - DYNAMIC WEB PROGRAMMING (JAVA EE/REST API)
    ASSIGNMENT TITLE: Lab Exercise: Reading HTML Form Data with JSP

    SUBMITTED BY:   BOISER, Danne Uriel M.
                    BS Computer Science - 2nd Year

    SUBMITTED TO:   FULLER, Jonathan F.
                    Class Instructor
    ***************************************************************************
    NOTE:   This file contains the source code used to run a working JSP file
            executed in Eclipse JavaEE Developers IDE and Apache Tomcat 9.0
-->

<%@ page import="ciit.thedannified.labex.readforms.models.Exam" %>
<%@ page import="ciit.thedannified.labex.readforms.models.ExamItem" %>
<%@ page import="ciit.thedannified.labex.readforms.Database"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Exam Results</title>
        <style>
            .incorrect {
                color: red;
            }
            .correct {
                color: darkgreen;
            }
        </style>
    </head>
    <body>
        <%
            Optional<Object> sessionUser;
            sessionUser = Optional.ofNullable(session.getAttribute("username"));

            if (sessionUser.isEmpty()) response.sendRedirect("./");
        %>

        <%!
            int score = 0;                          // holds a data representing the total of correct answers made after taking the exam.
            double average = 0;                     // holds the average score
            Exam exam;                              // holds the Exam object
            List<ExamItem> examItems;               // holds the list of ExamItem objects
            Map<String, String[]> answerParams;     // fetches the request parameters containing the answer input of the user.
            List<Integer> answers;                  // holds an array of integer representation of answer inputs.
        %>
        <%
            exam = (Exam) application.getAttribute("exam");     // retrieve the Exam object from the application scope of the website.
            answerParams = request.getParameterMap();           // fetch all request parameters after form submission.

            // If no Exam object was retrieved from the application scope OR request parameter map is empty...
            if (exam == null || answerParams.isEmpty()) {

            // Tell user that the website cannot produce a result, and they must take an exam first.
        %>
            <h1> No results available. </h1>
            <a href="./"> Take the exam first </a>
        <%
            }

            // Otherwise, display the Exam result based on user input:
            else {
                // Map all values inside "answerParams" object, which must retrieve every answer inputs of the user;
                // Then return a list of integers containing the answer inputs converted in said type.
                answers = answerParams.values().stream().map(s -> Integer.parseInt(s[0])).toList();

                // Check user's answers and return the score
                score = exam.checkAnswers(answers);

                // Get the percentage value of the score.
                average = ((double) score / answers.size()) * 100;

                // Get all exam items of the Exam object.
                examItems = exam.getExamItems();

                // Add/Update an exam record to the database.
                Database.addRecord(session.getAttribute("username").toString(), score);

                // Set a "score" attribute to the session object.
                session.setAttribute("score", String.valueOf(score));
        %>
            <h1> Exam Summary </h1>
            <h3> Here is your exam result: </h3>
            <%-- Display the score of the user. --%>
            <h4> <u>Your Score</u>: <%= score %>/<%= exam.getExamItems().size() %> (<%= average %>%) </h4>
        <%
                // For every exam items answered by the user, display the question, the user's answer, and the correct answer.
                for (int i = 0; i < examItems.size(); i++) {
                    ExamItem item = examItems.get(i);
                    List<String> choices = item.getChoices();
                    int chosenAnswer = Integer.parseInt(request.getParameter(String.format("item-%d", i)));
        %>
            <%-- The text color of the question depends whether the user answered the question correctly or not. --%>
            <p class="<%= item.getAnswer() == chosenAnswer ? "correct" : "incorrect" %>"><strong><%= i + 1 %>. <%= item.getQuestion() %></strong></p>
            <p>You answered: <%= choices.get(chosenAnswer) %> </p>
            <p>Correct answer: <%= choices.get(item.getAnswer()) %> </p>
        <%
                }
        %>
            <a href="home.jsp"> Take the Quiz again </a>
        <%
            }
        %>
    </body>
</html>
