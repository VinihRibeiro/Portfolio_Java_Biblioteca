package com.mycompany.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    public static Connection getConnection() throws SQLException {
        try {
            // 1. Força o carregamento da classe do driver na memória
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Define os parâmetros da conexão
            String url = "jdbc:mysql://localhost:3306/biblioteca";
            String usuario = "root"; // Substitua pelo seu usuário do MySQL
            String senha = "@Ma151280"; // Substitua pela sua senha

            // 3. Retorna a conexão
            return DriverManager.getConnection(url, usuario, senha);

        } catch (ClassNotFoundException e) {
            // Este erro acontece se o .jar do driver não foi encontrado
            throw new SQLException("Driver JDBC do MySQL não encontrado no projeto.", e);
        }
    }
}