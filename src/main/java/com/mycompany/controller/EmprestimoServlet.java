package com.mycompany.controller;

import com.mycompany.dao.EmprestimoDAO;
import com.mycompany.model.Emprestimo;
import com.mycompany.model.Livro;     
import com.mycompany.model.Usuario;   
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/emprestimos")
public class EmprestimoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        EmprestimoDAO dao = new EmprestimoDAO();

        try {
            if ("registrar".equals(acao)) {
                Usuario usuarioDoEmprestimo = new Usuario();
                usuarioDoEmprestimo.setId(Integer.parseInt(request.getParameter("idUsuario")));

                Livro livroDoEmprestimo = new Livro();
                livroDoEmprestimo.setId(Integer.parseInt(request.getParameter("idLivro")));

                Emprestimo e = new Emprestimo();
                e.setUsuario(usuarioDoEmprestimo);
                e.setLivro(livroDoEmprestimo);
                
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
        } catch (SQLException | ParseException | NumberFormatException e) {
            
            throw new ServletException("Erro ao processar a ação de empréstimo.", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EmprestimoDAO dao = new EmprestimoDAO();
        try {
            List<Emprestimo> lista = dao.listarAtivosOuAtrasados();
            request.setAttribute("emprestimos", lista);
            request.getRequestDispatcher("emprestimos/listar.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Erro ao buscar a lista de empréstimos.", e);
        }
    }
}