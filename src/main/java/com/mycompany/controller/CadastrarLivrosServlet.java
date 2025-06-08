package com.mycompany.controller;


import com.mycompany.dao.LivroDAO;
import com.mycompany.model.Livro;

import jakarta.servlet.RequestDispatcher; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/cadastrarLivro")
public class CadastrarLivrosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // --- Leitura dos Parâmetros ---
            String titulo = request.getParameter("titulo");
            String autor = request.getParameter("autor");
            String editora = request.getParameter("editora");
            String anoPubliStr = request.getParameter("anoPubli");
            String isbn = request.getParameter("isbn");
            String quantidadeStr = request.getParameter("quantidade");
            String categoria = request.getParameter("categoria");
            String descricao = request.getParameter("descricao");

            
            if (titulo == null || titulo.isEmpty() || autor == null || autor.isEmpty()) {
                request.setAttribute("mensagemErro", "Título e Autor são campos obrigatórios.");
                RequestDispatcher rd = request.getRequestDispatcher("cadastroLivro.jsp");
                rd.forward(request, response);
                return;
            }
            
            int anoPubli = Integer.parseInt(anoPubliStr);
            int quantidade = Integer.parseInt(quantidadeStr);

           
            Livro livro = new Livro();
            livro.setTitulo(titulo);
            livro.setAutor(autor);
            livro.setEditora(editora); 
            livro.setAnoPublicacao(anoPubli);
            livro.setIsbn(isbn);
            livro.setQuantidade(quantidade);
            livro.setCategoria(categoria);
            livro.setDescricao(descricao);

            
            LivroDAO dao = new LivroDAO();
            boolean sucesso = dao.inserirLivro(livro);

            
            if (sucesso) {
                request.setAttribute("mensagemSucesso", "Livro '" + titulo + "' cadastrado com sucesso!");
            } else {
                request.setAttribute("mensagemErro", "Ocorreu um erro ao cadastrar o livro. Tente novamente.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "Ano de Publicação e Quantidade devem ser números válidos.");
        } catch (Exception e) {
            request.setAttribute("mensagemErro", "Um erro inesperado ocorreu: " + e.getMessage());
            e.printStackTrace(); 
        }
        
        // Redireciona de volta para a página de cadastro para exibir a mensagem
        RequestDispatcher rd = request.getRequestDispatcher("cadastroLivro.jsp");
        rd.forward(request, response);
    }
}
