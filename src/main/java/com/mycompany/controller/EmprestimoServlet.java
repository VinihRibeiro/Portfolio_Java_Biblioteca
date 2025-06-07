package com.mycompany.controller;

import com.mycompany.dao.EmprestimoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.model.Emprestimo; 
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;

@WebServlet("/emprestimos")
public class EmprestimoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        try {
            EmprestimoDAO dao = new EmprestimoDAO();
            if ("registrar".equals(acao)) {
                Emprestimo e = new Emprestimo();
                e.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                e.setIdLivro(Integer.parseInt(request.getParameter("idLivro")));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                e.setDataEmprestimo(new Date());
                e.setDataDevolucaoPrevista(sdf.parse(request.getParameter("dataDevolucaoPrevista")));
                dao.registrarEmprestimo(e);
                response.sendRedirect(request.getContextPath() + "/emprestimos");
            } else if ("devolver".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.registrarDevolucao(id, new Date());
                response.sendRedirect(request.getContextPath() + "/emprestimos"); 
            } else if ("renovar".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date novaData = sdf.parse(request.getParameter("novaData"));
                dao.renovarEmprestimo(id, novaData);
                response.sendRedirect(request.getContextPath() + "/emprestimos");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EmprestimoDAO dao = new EmprestimoDAO();
        try {
            List<Emprestimo> lista = dao.listarAtivosOuAtrasados();
            request.setAttribute("emprestimos", lista);
            request.getRequestDispatcher("emprestimos/listar.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
