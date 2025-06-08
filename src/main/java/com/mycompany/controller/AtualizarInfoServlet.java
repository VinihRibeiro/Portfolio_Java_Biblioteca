
package com.mycompany.controller;


import com.mycompany.dao.LivroDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/atualizarLivro")
public class AtualizarInfoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String isbn = request.getParameter("isbnEdit");
        String campo = request.getParameter("campoDesejado");
        String novoValor = request.getParameter("novoValor");

        
        try {
            // Validação básica dos parâmetros
            if (isbn == null || isbn.trim().isEmpty() || 
                campo == null || campo.trim().isEmpty() || 
                novoValor == null || novoValor.trim().isEmpty()) {
                
                request.setAttribute("mensagemErro", "Todos os campos são obrigatórios para a atualização.");
            } else {
                LivroDAO dao = new LivroDAO();
                boolean sucesso = dao.atualizarCampo(isbn, campo, novoValor);

                if (sucesso) {
                    request.setAttribute("mensagemSucesso", "O campo '" + campo + "' do livro com ISBN " + isbn + " foi atualizado com sucesso!");
                } else {
                    request.setAttribute("mensagemErro", "Não foi possível atualizar o livro. Verifique o ISBN e os dados informados.");
                }
            }
        } catch (Exception e) {
            request.setAttribute("mensagemErro", "Ocorreu um erro inesperado: " + e.getMessage());
            e.printStackTrace(); // Para depuração no console
        }
        
        // Redireciona de volta para a página de atualização para exibir a mensagem
        RequestDispatcher rd = request.getRequestDispatcher("/atualizarInfo.jsp");
        rd.forward(request, response);
    }
}
