/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.LoginBean;
import dao.LoginDao;
/**
 *
 * @author syazw
 */
public class LoginServlet extends HttpServlet{
        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        LoginBean loginBean = new LoginBean();
        
        loginBean.setUsername(user);
        loginBean.setPassword(pass);
        
        LoginDao loginDao = new LoginDao();
        
        String userValidate = loginDao.authenticateUser(loginBean);
        
    if (userValidate.equals("SUCCESS")) {
       // 1. Create or get the session
       javax.servlet.http.HttpSession session = request.getSession(); 
    
       // 2. Store the username in the session so it persists across multiple pages
       request.setAttribute("userName", user); 
    
       // 3. Redirect to Home
       request.getRequestDispatcher("/dashboard.html").forward(request, response);
    }else{
       request.setAttribute("errMessage", userValidate); 
       request.getRequestDispatcher("/login.jsp").forward(request, response);
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
