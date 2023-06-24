<%@ page import="java.util.Optional" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Page | Quiz Website</title>

    <style>
        .fc-section, .label {
            margin: 5px;
        }
    </style>
</head>
<body>

    <%! String s; %>

    <%
        Optional<Cookie[]> cookies;
        s = null;

        cookies = Optional.ofNullable(request.getCookies());

        cookies.ifPresent(c -> s = Arrays.stream(c)
                .filter(a -> a.getName().equals("username"))
                .map(Cookie::getValue).findFirst().orElse(null));

        if (s != null) {
            session.setAttribute("username", s);
            response.sendRedirect("./home.jsp");
        }
    %>

    <h1> Exercise: Quiz Website </h1>
    <p> Create an account to get started. </p>

    <%
        // Fetch response status code
        int status = response.getStatus();

        // If user entered wrong credentials in our form,
        // notify user that such account credentials do not exist.
        if (status == HttpServletResponse.SC_CONFLICT) {
    %>
    <p class="danger"> Username "<%= request.getParameter("username") %>" already exists. Please use a unique username. </p>
    <%
        }
    %>

    <form action="./create" method="post">
        <div class="fc-section">
            <label for="username" class="label"> Username: </label>
            <input type="text" id="username" name="username" maxlength="16" required />
        </div>
        <div class="fc-section">
            <label for="password" class="label"> Password: </label>
            <input type="password" id="password" name="password" required />
        </div>
        <div class="fc-section">
            <input type="submit" value="Create Account" /> &nbsp;
            <input type="reset" value="Clear" /> &nbsp;
        </div>
    </form>

    <br />

    <small> Have an account? <a href="index.jsp">Log in</a> here! </small>

</body>
</html>