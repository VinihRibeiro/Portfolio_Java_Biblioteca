package com.mycompany.dao;

import com.mycompany.model.Contato;
import com.mycompany.util.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement; // <<< IMPORT ADICIONADO AQUI
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) para todas as operações relacionadas a Contatos/Usuários.
 */
public class ContatoDAO {

    public void inserirContato(Contato contato) throws SQLException {
        String sql = "INSERT INTO usuarios (nome, email, telefone, endereco, tipo_usuario, data_cadastro) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, contato.getNome());
            pst.setString(2, contato.getEmail());
            pst.setString(3, contato.getTelefone());
            pst.setString(4, contato.getEndereco());
            pst.setString(5, contato.getTipoUsuario());
            pst.setString(6, contato.getDataCadastro());
            pst.executeUpdate();
        }
    }

    public List<Contato> listarContatos() throws SQLException {
        List<Contato> contatos = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY nome";
        try (Connection con = ConnectionFactory.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Contato contato = new Contato();
                contato.setId(rs.getInt("id"));
                contato.setNome(rs.getString("nome"));
                contato.setEmail(rs.getString("email"));
                contato.setTelefone(rs.getString("telefone"));
                contato.setEndereco(rs.getString("endereco"));
                if (rs.getObject("tipo_usuario") != null) {
                    contato.setTipoUsuario(rs.getString("tipo_usuario"));
                }
                if (rs.getObject("data_cadastro") != null) {
                    contato.setDataCadastro(rs.getString("data_cadastro"));
                }
                contatos.add(contato);
            }
        }
        return contatos;
    }

    public Contato buscarContatoPorId(int id) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        Contato contato = null;
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    contato = new Contato();
                    contato.setId(rs.getInt("id"));
                    contato.setNome(rs.getString("nome"));
                    contato.setEmail(rs.getString("email"));
                    contato.setTelefone(rs.getString("telefone"));
                    contato.setEndereco(rs.getString("endereco"));
                    contato.setTipoUsuario(rs.getString("tipo_usuario"));
                }
            }
        }
        return contato;
    }

    public void atualizarContato(Contato contato) throws SQLException {
    // Query SQL atualizada para incluir o campo tipo_usuario
    String sql = "UPDATE usuarios SET nome=?, email=?, telefone=?, endereco=?, tipo_usuario=? WHERE id=?";
    
    try (Connection con = ConnectionFactory.getConnection();
         PreparedStatement pst = con.prepareStatement(sql)) {
        
        pst.setString(1, contato.getNome());
        pst.setString(2, contato.getEmail());
        pst.setString(3, contato.getTelefone());
        pst.setString(4, contato.getEndereco());
        pst.setString(5, contato.getTipoUsuario()); 
        pst.setInt(6, contato.getId()); 
        
        pst.executeUpdate();
    }
}
    public void excluirContato(int id) throws SQLException {
    String sql = "DELETE FROM usuarios WHERE id = ?";
    
    try (Connection con = ConnectionFactory.getConnection();
         PreparedStatement pst = con.prepareStatement(sql)) {
        
        pst.setInt(1, id);
        pst.executeUpdate();
    }
}
}
