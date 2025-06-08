package com.mycompany.dao;

import com.mycompany.model.Emprestimo;
import com.mycompany.model.Usuario;
import com.mycompany.model.Livro; // IMPORT ADICIONADO
import com.mycompany.model.StatusEmprestimo; // IMPORT ADICIONADO
import com.mycompany.model.TipoUsuario;
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
            stmt.setInt(1, e.getUsuario().getId());
            stmt.setInt(2, e.getLivro().getId());
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
        
        // 1. QUERY MELHORADA: Usamos JOIN para buscar dados das 3 tabelas
        String sql = "SELECT " +
                     "e.id AS emprestimo_id, e.data_emprestimo, e.data_devolucao_prevista, " +
                     "e.data_devolucao_real, e.status AS emprestimo_status, " +
                     "u.id AS usuario_id, u.nome AS usuario_nome, " + // Adicionamos dados do usuário
                     "l.id AS livro_id, l.titulo AS livro_titulo " +   // Adicionamos dados do livro
                     "FROM emprestimos e " +
                     "JOIN usuarios u ON e.id_usuario = u.id " +
                     "JOIN livros l ON e.id_livro = l.id " +
                     "WHERE e.status = 'ATIVO' OR e.status = 'ATRASADO'";

        try (Connection conn = ConnectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                // 2. CRIE OS OBJETOS COMPLETOS PRIMEIRO
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("usuario_id"));
                usuario.setNome(rs.getString("usuario_nome"));
                // Se tiver mais campos em Usuario (como tipo), adicione aqui com set...

                Livro livro = new Livro();
                livro.setId(rs.getInt("livro_id"));
                livro.setTitulo(rs.getString("livro_titulo"));
                // Se tiver mais campos em Livro (como autor), adicione aqui com set...

                // 3. AGORA, CRIE O EMPRÉSTIMO E ASSOCIE OS OBJETOS
                Emprestimo e = new Emprestimo();
                e.setId(rs.getInt("emprestimo_id"));
                e.setUsuario(usuario); // Usando o novo método setUsuario(Usuario)
                e.setLivro(livro);     // Usando o novo método setLivro(Livro)
                e.setDataEmprestimo(rs.getDate("data_emprestimo"));
                e.setDataDevolucaoPrevista(rs.getDate("data_devolucao_prevista"));
                e.setDataDevolucaoReal(rs.getDate("data_devolucao_real"));
                
                // Convertendo a String do banco para o Enum
                e.setStatus(StatusEmprestimo.valueOf(rs.getString("emprestimo_status")));
                
                lista.add(e);
            }
        }
        return lista;
    }
    // Adicione este método dentro da sua classe EmprestimoDAO

public List<Emprestimo> gerarRelatorioPorData(Date dataInicio, Date dataFim) throws SQLException {
    List<Emprestimo> lista = new ArrayList<>();
    
    String sql = "SELECT " +
                 "e.id AS emprestimo_id, e.data_emprestimo, e.data_devolucao_prevista, " +
                 "e.data_devolucao_real, e.status AS emprestimo_status, " +
                 "u.id AS usuario_id, u.nome AS usuario_nome, u.tipo_usuario, " +
                 "l.id AS livro_id, l.titulo AS livro_titulo, l.autor AS livro_autor " +
                 "FROM emprestimos e " +
                 "JOIN usuarios u ON e.id_usuario = u.id " +
                 "JOIN livros l ON e.id_livro = l.id " +
                 "WHERE e.data_emprestimo BETWEEN ? AND ?";

    try (Connection conn = ConnectionFactory.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setDate(1, new java.sql.Date(dataInicio.getTime()));
        pstmt.setDate(2, new java.sql.Date(dataFim.getTime()));

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                // Monta o objeto Usuario
                // Verifique se sua classe Usuario tem um construtor que aceita (int, String, TipoUsuario)
                // Se não tiver, use o construtor vazio e os métodos set.
                TipoUsuario tipoUsuario = TipoUsuario.valueOf(rs.getString("tipo_usuario").toUpperCase());
                Usuario usuario = new Usuario(); // Usando construtor vazio
                usuario.setId(rs.getInt("usuario_id"));
                usuario.setNome(rs.getString("usuario_nome"));
                usuario.setTipo(tipoUsuario); 

                // Monta o objeto Livro
                Livro livro = new Livro(); // Usando construtor vazio
                livro.setId(rs.getInt("livro_id"));
                livro.setTitulo(rs.getString("livro_titulo"));
                livro.setAutor(rs.getString("livro_autor")); 

                // Monta o objeto Emprestimo
                Emprestimo emprestimo = new Emprestimo();
                emprestimo.setId(rs.getInt("emprestimo_id"));
                emprestimo.setUsuario(usuario);
                emprestimo.setLivro(livro);
                emprestimo.setDataEmprestimo(rs.getDate("data_emprestimo"));
                emprestimo.setDataDevolucaoPrevista(rs.getDate("data_devolucao_prevista"));
                emprestimo.setDataDevolucaoReal(rs.getDate("data_devolucao_real"));
                emprestimo.setStatus(StatusEmprestimo.valueOf(rs.getString("emprestimo_status").toUpperCase()));

                lista.add(emprestimo);
            }
        }
    } catch (IllegalArgumentException e) {
        throw new SQLException("Erro ao processar dados de enum do banco (Status ou TipoUsuario).", e);
    }
    return lista;
}

    
    // A CLASSE LIVRO DUPLICADA QUE ESTAVA AQUI FOI REMOVIDA.
}
