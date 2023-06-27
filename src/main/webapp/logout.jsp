<%@ page import="ciit.thedannified.labex.readforms.SessionUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Logging out...</title>
</head>
<body>
    <%
        if (!SessionUtils.hasUserLoggedIn(request, response)) {
            response.sendRedirect("./");
            return;
        }
    %>

    <small> Logging out... </small>
    <%
        // Get all cookies
        Cookie[] cookies = request.getCookies();

        // For every cookie found in this client
        for (Cookie c : cookies) {
            c.setMaxAge(0);             // Delete them immediately
            response.addCookie(c);      // Commit changes
        }

        session.removeAttribute("username");    // Remove "username" attribute
        session.invalidate();                   // Invalidate the session
        response.sendRedirect("./");            // Redirect the user to the index page.
    %>
</body>
</html>