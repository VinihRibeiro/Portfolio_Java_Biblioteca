package com.mycompany.controller;

import com.mycompany.dao.ContatoDAO;
import com.mycompany.model.Contato;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet que controla todas as ações da agenda: listar, inserir, editar e excluir.
 */
@WebServlet(urlPatterns = {"/agenda", "/agenda/novo", "/agenda/editar", "/agenda/excluir"})
public class AgendaController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContatoDAO dao;

    public AgendaController() {
        super();
        this.dao = new ContatoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            if (action.equals("/agenda")) {
                listarContatos(request, response);
            } else if (action.equals("/agenda/editar")) {
                mostrarFormularioEdicao(request, response);
            } else if (action.equals("/agenda/excluir")) {
                excluirContato(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/agenda");
            }
        } catch (SQLException e) {
            throw new ServletException("Erro de banco de dados no GET", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            if (action.equals("/agenda/novo")) {
                adicionarNovoContato(request, response);
            } else if (action.equals("/agenda/editar")) {
                editarContato(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/agenda");
            }
        } catch (SQLException e) {
            throw new ServletException("Erro de banco de dados no POST", e);
        }
    }

    // --- Métodos de Ação ---

    private void listarContatos(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Contato> listaDeContatos = dao.listarContatos();
        request.setAttribute("listaDeContatos", listaDeContatos);
        RequestDispatcher rd = request.getRequestDispatcher("/agenda.jsp");
        rd.forward(request, response);
    }

    private void adicionarNovoContato(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        Contato novoContato = new Contato();
        novoContato.setNome(request.getParameter("nome"));
        novoContato.setEmail(request.getParameter("email"));
        novoContato.setTelefone(request.getParameter("telefone"));
        novoContato.setEndereco(request.getParameter("endereco"));
        novoContato.setTipoUsuario(request.getParameter("tipo_usuario"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        novoContato.setDataCadastro(sdf.format(new Date()));
        
        dao.inserirContato(novoContato);
        response.sendRedirect(request.getContextPath() + "/agenda?status=sucesso");
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Contato contatoExistente = dao.buscarContatoPorId(id);
        request.setAttribute("contato", contatoExistente);
        RequestDispatcher rd = request.getRequestDispatcher("/editar.jsp");
        rd.forward(request, response);
    }

    private void editarContato(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        Contato contato = new Contato();
        contato.setId(Integer.parseInt(request.getParameter("id")));
        contato.setNome(request.getParameter("nome"));
        contato.setEmail(request.getParameter("email"));
        contato.setTelefone(request.getParameter("telefone"));
        contato.setEndereco(request.getParameter("endereco"));
        contato.setTipoUsuario(request.getParameter("tipo_usuario"));
        
        dao.atualizarContato(contato);
        response.sendRedirect(request.getContextPath() + "/agenda?status=editado");
    }

    private void excluirContato(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.excluirContato(id);
        response.sendRedirect(request.getContextPath() + "/agenda?status=excluido");
    }
}
