/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

/**
 *
 * @author Vinicius
 */
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password"); 
        String rememberMe = request.getParameter("rememberMe");

        
        if (username != null && !username.trim().isEmpty() &&
            password != null && !password.trim().isEmpty()) {

            // Autenticação "bem-sucedida"
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(10 * 60);

            if ("true".equals(rememberMe)) {
                Cookie userCookie = new Cookie("username", username);
                userCookie.setMaxAge(60 * 60 * 24 * 30); // 30 dias
                response.addCookie(userCookie);
            } else {
                Cookie userCookie = new Cookie("username", null);
                userCookie.setMaxAge(0);
                response.addCookie(userCookie);
            }

            response.sendRedirect("dashboard.jsp");
        } else {
            // Isso aconteceria se o JS falhasse ou fosse contornado e enviasse dados vazios
            request.setAttribute("erro", "Usuário ou senha inválidos (recebidos no servidor)!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
  
