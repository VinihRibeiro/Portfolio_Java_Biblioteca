// 1. PACOTE CORRIGIDO
package com.mycompany.controller;

import java.io.IOException;
import java.util.ArrayList; 
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import com.mycompany.dao.LivroDAO;
import com.mycompany.model.Livro;


@WebServlet("/listarLivros")
public class ListarLivrosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String parametro = request.getParameter("parametro");
        String valor = request.getParameter("escolha");
        
        List<Livro> livros = new ArrayList<>(); // Inicializa a lista como vazia
        
        
        if (parametro != null && !parametro.isEmpty() && valor != null && !valor.isEmpty()) {
            try {
                LivroDAO dao = new LivroDAO();
                livros = dao.buscarPorParametro(parametro, valor);
            } catch (Exception e) {
                
                request.setAttribute("mensagemErro", "Erro ao buscar livros: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        request.setAttribute("livros", livros);
        request.getRequestDispatcher("listarLivro.jsp").forward(request, response);
    }
}
