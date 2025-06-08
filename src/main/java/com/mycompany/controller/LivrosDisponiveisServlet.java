
package com.mycompany.controller;


import com.mycompany.dao.LivroDAO;
import com.mycompany.model.Livro;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/livrosDisponiveis")
public class LivrosDisponiveisServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        List<Livro> livrosDisponiveis = new ArrayList<>();

        
        try {
            LivroDAO dao = new LivroDAO();
            livrosDisponiveis = dao.listarLivrosDisponiveis();
            System.out.println("Livros disponíveis encontrados: " + livrosDisponiveis.size());

        } catch (Exception e) {
            System.err.println("Erro ao listar livros disponíveis: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Não foi possível carregar a lista de livros disponíveis.");
        }

        request.setAttribute("livrosDisponiveis", livrosDisponiveis);
        request.getRequestDispatcher("/livrosDisponiveis.jsp").forward(request, response);
    }
}
