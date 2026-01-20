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
             HttpSession session = request.getSession();
            session.setAttribute("userId", validUser.getId()); 
            session.setAttribute("username", validUser.getUsername());

            if ("admin".equalsIgnoreCase(username)) {
                session.setAttribute("role", "staff");
                response.sendRedirect("staffDashboard.jsp");
            } else {
                session.setAttribute("role", "user");
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            request.setAttribute("errMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

   
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
