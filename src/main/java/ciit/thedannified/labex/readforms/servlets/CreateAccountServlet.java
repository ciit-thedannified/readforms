package ciit.thedannified.labex.readforms.servlets;

import ciit.thedannified.labex.readforms.Database;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "CreateAccountServlet", urlPatterns = "/create")
public class CreateAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get all user credentials.
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Create a new user to the database and check if the procedure is successful.
        boolean hasCreatedNewAccount = Database.createUser(username, password);

        // If the procedure is a success:
        if (hasCreatedNewAccount) {
            // Notify the user that the account has been created successfully.
            System.out.println("Account created successfully!");
            resp.setStatus(HttpServletResponse.SC_CREATED);

            // Forward information to login page.
            req.getRequestDispatcher("./").forward(req, resp);
        }
        // Otherwise, handle the error:
        else {
            // Notify the user that the account creation process failed.
            System.err.println("ERROR: Username \"" + username + "\" already exists.");
            resp.setStatus(HttpServletResponse.SC_CONFLICT);

            // Forward information to create page.
            req.getRequestDispatcher("./signup.jsp").forward(req, resp);
        }
    }

}
