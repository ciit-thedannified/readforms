package ciit.thedannified.labex.readforms.servlets;

import ciit.thedannified.labex.readforms.Database;
import ciit.thedannified.labex.readforms.SessionUtils;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LoginAccountServlet", urlPatterns = "/login")
public class LoginAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie unameCookie;

        RequestDispatcher rd = req.getRequestDispatcher("./");
        HttpSession session = req.getSession();

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (Database.validateUser(username, password)) {
            unameCookie = new Cookie("username", username);
            int status = SessionUtils.addSession(username, session.getId());

            session.setAttribute("username", username);

            System.out.println(status);
            resp.addCookie(unameCookie);
            resp.sendRedirect("./home.jsp");
        }
        else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            rd.forward(req, resp);
        }
    }


}
