package com.mycompany.dao;

import com.mycompany.model.Livro;
import com.mycompany.util.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    public boolean inserirLivro(Livro livro) throws SQLException {
        String sql = "INSERT INTO livros (titulo, autor, editora, ano_publicacao, isbn, quantidade_disponivel, categoria, descricao) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, livro.getTitulo());
            stmt.setString(2, livro.getAutor());
            stmt.setString(3, livro.getEditora());
            stmt.setInt(4, livro.getAnoPublicacao());
            stmt.setString(5, livro.getIsbn());
            stmt.setInt(6, livro.getQuantidade());
            stmt.setString(7, livro.getCategoria());
            stmt.setString(8, livro.getDescricao());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Livro> buscarPorParametro(String parametro, String valor) throws SQLException {
        List<Livro> livros = new ArrayList<>();
        String[] camposPermitidos = {"isbn", "titulo", "autor", "categoria"};
        String coluna = "titulo"; 
        for (String campoPermitido : camposPermitidos) {
            if (campoPermitido.equals(parametro)) {
                coluna = campoPermitido;
                break;
            }
        }

        String sql = "SELECT * FROM livros WHERE " + coluna + " LIKE ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, "%" + valor + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Livro livro = new Livro();
                    livro.setId(rs.getInt("id"));
                    livro.setTitulo(rs.getString("titulo"));
                    livro.setAutor(rs.getString("autor"));
                    livro.setEditora(rs.getString("editora"));
                    livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                    livro.setIsbn(rs.getString("isbn"));
                    livro.setQuantidade(rs.getInt("quantidade_disponivel"));
                    livro.setCategoria(rs.getString("categoria"));
                    livro.setDescricao(rs.getString("descricao"));
                    livros.add(livro);
                }
            }
        }
        return livros;
    }

    
    public boolean atualizarCampo(String isbn, String campo, String novoValor) throws SQLException {
        // Lista de campos permitidos para evitar SQL Injection no nome da coluna
        String[] camposPermitidos = {"titulo", "autor", "categoria", "editora", "ano_publicacao", "isbn", "quantidade_disponivel", "descricao"};
        boolean campoValido = java.util.Arrays.asList(camposPermitidos).contains(campo);

        if (!campoValido) {
            System.err.println("Tentativa de atualização de campo inválido: " + campo);
            return false; 
        }

        String sql = "UPDATE livros SET " + campo + " = ? WHERE isbn = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            // Ajusta o tipo do parâmetro para campos numéricos
            if (campo.equals("quantidade_disponivel") || campo.equals("ano_publicacao")) {
                stmt.setInt(1, Integer.parseInt(novoValor));
            } else {
                stmt.setString(1, novoValor);
            }
            stmt.setString(2, isbn);

            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Livro> listarLivrosDisponiveis() throws SQLException {
        List<Livro> livrosDisponiveis = new ArrayList<>();
        String sql = "SELECT * FROM livros WHERE quantidade_disponivel > 0";

        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Livro livro = new Livro();
                livro.setId(rs.getInt("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setEditora(rs.getString("editora"));
                livro.setAnoPublicacao(rs.getInt("ano_publicacao"));
                livro.setIsbn(rs.getString("isbn"));
                livro.setQuantidade(rs.getInt("quantidade_disponivel"));
                livro.setCategoria(rs.getString("categoria"));
                livro.setDescricao(rs.getString("descricao"));
                livrosDisponiveis.add(livro);
            }
        }
        return livrosDisponiveis;
    }
}
