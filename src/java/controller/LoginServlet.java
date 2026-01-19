package controller;

import bean.User;
import dao.LoginDao;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User loginBean = new User();
        loginBean.setUsername(username);
        loginBean.setPassword(password);

        LoginDao loginDao = new LoginDao();

        User validUser = loginDao.validateUser(loginBean);

        if (validUser!=null) {
            // Create session
             HttpSession session = request.getSession();
            session.setAttribute("userId", validUser.getId()); 
            session.setAttribute("username", validUser.getUsername());

            // Hardcoded role
            if ("admin".equalsIgnoreCase(username)) {
                session.setAttribute("role", "staff");
                response.sendRedirect("staffDashboard.jsp");
            } else {
                session.setAttribute("role", "user");
                response.sendRedirect("dashboard.jsp");
            }

        } else {
            // Login failed
            request.setAttribute("errMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}
