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
    <title> Welcome | Quiz Website </title>

    <style>
        .fc-section, .label {
            margin: 5px;
        }

        .success {
            color: darkgreen;
        }

        .danger {
            color: darkred;
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
    <p> Please log in to get started. </p>

    <%
        // Fetch response status code
        int status = response.getStatus();

        // If user was able to create a new account,
        // notify user that they may log in their account to get started.
        if (status == HttpServletResponse.SC_CREATED) {
    %>
        <p class="success"> Account created successfully! You may now use your credentials to log in. </p>
    <%
        }

        // If user entered wrong credentials in our form,
        // notify user that such account credentials do not exist.
        else if (status == HttpServletResponse.SC_NOT_FOUND) {
    %>
        <p class="danger"> Account credentials do not exist. Please create an account first. </p>
    <%
        }
    %>

    <form action="./login" method="post">
        <!-- USERNAME TEXT FORM CONTROL -->
        <div class="fc-section">
            <label for="username" class="label"> Username: </label>
            <input type="text" id="username" name="username" minlength="3" maxlength="16" required />
        </div>
        <!-- PASSWORD TEXT FORM CONTROL -->
        <div class="fc-section">
            <label for="password" class="label"> Password: </label>
            <input type="password" id="password" name="password" minlength="8" required />
        </div>
        <!-- BUTTON FORM CONTROLS -->
        <div class="fc-section">
            <input type="submit" value="Log in" /> &nbsp;
            <input type="reset" value="Clear" /> &nbsp;
        </div>
    </form>

    <br />
    <small> Don't have an account yet? <a href="./signup.jsp">Sign up</a> here! </small>

</body>
</html>