package com.mycompany.dao;

import com.mycompany.model.Emprestimo;       
import com.mycompany.util.ConnectionFactory; 
import java.util.Date;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmprestimoDAO {

    public void registrarEmprestimo(Emprestimo e) throws SQLException {
        String sql = "INSERT INTO emprestimos (id_usuario, id_livro, data_emprestimo, data_devolucao_prevista, status) VALUES (?, ?, ?, ?, 'ATIVO')";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, e.getIdUsuario());
            stmt.setInt(2, e.getIdLivro());
            stmt.setDate(3, new java.sql.Date(e.getDataEmprestimo().getTime()));
            stmt.setDate(4, new java.sql.Date(e.getDataDevolucaoPrevista().getTime()));

            stmt.executeUpdate();
        }
    }

    public void registrarDevolucao(int idEmprestimo, Date dataDevolucao) throws SQLException {
        String sql = "UPDATE emprestimos SET data_devolucao_real = ?, status = 'DEVOLVIDO' WHERE id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(dataDevolucao.getTime()));
            stmt.setInt(2, idEmprestimo);
            stmt.executeUpdate();
        }
    }

    public void renovarEmprestimo(int idEmprestimo, Date novaDataPrevista) throws SQLException {
        String sql = "UPDATE emprestimos SET data_devolucao_prevista = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(novaDataPrevista.getTime()));
            stmt.setInt(2, idEmprestimo);
            stmt.executeUpdate();
        }
    }

    public List<Emprestimo> listarAtivosOuAtrasados() throws SQLException {
        List<Emprestimo> lista = new ArrayList<>();
        String sql = "SELECT * FROM emprestimos WHERE status = 'ATIVO' OR status = 'ATRASADO'";
        try (Connection conn = ConnectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Emprestimo e = new Emprestimo();
                e.setId(rs.getInt("id"));
                e.setIdUsuario(rs.getInt("id_usuario"));
                e.setIdLivro(rs.getInt("id_livro"));
                e.setDataEmprestimo(rs.getDate("data_emprestimo"));
                e.setDataDevolucaoPrevista(rs.getDate("data_devolucao_prevista"));
                e.setDataDevolucaoReal(rs.getDate("data_devolucao_real"));
                e.setStatus(rs.getString("status"));
                lista.add(e);
            }
        }
        return lista;
    }
}
