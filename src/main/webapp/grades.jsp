<%@ page import="ciit.thedannified.labex.readforms.Database" %>
<%@ page import="ciit.thedannified.labex.readforms.models.ExamRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="ciit.thedannified.labex.readforms.SessionUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quiz Results | Quiz Website </title>
</head>
<body>

    <%
        if (!SessionUtils.hasUserLoggedIn(request, response)) {
            response.sendRedirect("./");
            return;
        }
    %>

    <%! List<ExamRecord> records; %>

    <h1> Quiz Results </h1>
    <%
        // Fetch all available exam records from the database.
        records = Database.getAllScores();

        // If there are no records available.
        if (records.isEmpty()) {
            // Notify user that no results are available yet.
    %>
    <p> No results available yet. </p>
    <%
        }
        // Otherwise, display all exam results in a tabulated form.
        else {
    %>
    <p> Here are the results: </p>
    <table border="2">
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Score</th>
            </tr>
        </thead>
        <tbody>
            <%
                // For every ExamRecord object found in the records:
                for (ExamRecord record : records) {
                    // Print the name and score stored in the record.
            %>
                <tr>
                    <td> <%= record.getName() %> </td>
                    <td> <%= record.getScore() %> </td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <%
        }
    %>
    <br />
    <small> <a href="home.jsp"> Go back to Home </a> </small>
</body>
</html>