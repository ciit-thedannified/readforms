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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ciit.thedannified.labex.readforms.models.Exam" %>
<%@ page import="ciit.thedannified.labex.readforms.models.ExamItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Optional" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Reading HTML Form Data with JSP</title>
    </head>
    <body>

    <%
        Optional<Object> sessionUser;
        sessionUser = Optional.ofNullable(session.getAttribute("username"));

        if (sessionUser.isEmpty()) response.sendRedirect("./");
    %>

    <%!
            Exam exam;                      // holds the Exam object of the application.
            List<ExamItem> examItems;       // holds a list of exam items prepared for the examination.
        %>
        <%
            // Check if there is no exam object AND the website does not have an "exam" attribute in the application scope.
            if (exam == null && application.getAttribute("exam") == null) {
                exam = new Exam();          // Instantiate a new Exam object.

                examItems = new ArrayList<>();      // Instantiate an ArrayList object of type ExamItem.

                try {
                    // Create 5 ExamItem objects for this examination.
                    examItems.add(new ExamItem("What is the main ingredient of a matcha latte?",
                            List.of("Matcha Powder", "Green Leaves", "Mint", "Pandan Leaves"), 0));
                    examItems.add(new ExamItem("What is Erika's Favorite Drink?",
                            List.of("Wild Strawberry Frappuccino", "Matcha Frappe", "Spanish Latte", "Dark Mocha Frappuccino"), 0));
                    examItems.add(new ExamItem("What is Erika's Favorite Dessert?",
                            List.of("Ube Cake", "Tiramisu", "Ice Cream", "Cheesecake"), 1));
                    examItems.add(new ExamItem("What is Danne's Favorite Programming Language?",
                            List.of("Python", "JavaScript", "Java", "C++"), 2));
                    examItems.add(new ExamItem("What is Danne's Favorite Food?",
                            List.of("Adobong Paksiw", "Pesto Pasta", "Siomai Chao Fan", "Pork Sisig"), 3));

                    // Insert all instantiated exam items into the Exam object.
                    exam.setExamItems(examItems);
                }
                // If there may be an instance that IndexOutOfBoundsException may occur, catch such exception and print the stack trace.
                catch (IndexOutOfBoundsException ioobe) {
                    ioobe.printStackTrace();
                }

                // Set "exam" attribute to the application scope (This allows the website to carry the Exam object over different web pages).
                application.setAttribute("exam", exam);
            }
            // If there is an existing "exam" attribute to our website already, simply retrieve the object.
            else {
                Object examSession = application.getAttribute("exam");

                // Check if the retrieved object from "exam" attribute is an instance of Exam class.
                if (examSession instanceof Exam) {
                    // Assign the retrieved object if the condition is satisfied.
                    exam = (Exam) examSession;
                    examItems = exam.getExamItems();
                }
            }
        %>

        <%
            // If there is no Exam object instantiated at all OR the Exam object does not contain any ExamItem objects...
            if (exam == null || exam.getExamItems().isEmpty()) {

            // Simply print, "No questions available"
        %>
        <p> No questions available. </p>
        <%
            }
            // Otherwise, create a form element that will display all the ExamItem objects of our exam.
            else {
        %>
            <h1> Exercise: Quiz Website </h1>
            <form action="./results.jsp" method="post">
        <%
            // For every exam item found in the Exam object...
            for (int i = 0; i < examItems.size(); i++) {
                    ExamItem item = examItems.get(i);       // holds the exam item of the current iteration
        %>

                <p><%= i + 1 %>. <%= item.getQuestion() %></p>
        <%
                    // For every choice available in an exam item, display them in a radio button element.
                    for (int j = 0; j < item.getChoices().size(); j++) {
        %>
                <input type="radio" id="item-<%= i + 1%>-<%= j %>" name="item-<%= i %>" value="<%= j %>" required />
                <label for="item-<%= i + 1%>-<%= j %>"> <%= item.getChoices().get(j) %> </label> <br />
        <%
                    }
        %>
            <br />
        <%
                }
        %>
                <input type="submit" value="Submit Answers" />
                <input type="reset" value="Clear Answers" />
            </form>
        <%
            }
        %>
        <br />
        <small> <a href="home.jsp"> Go back to Home </a> </small>
    </body>
</html>