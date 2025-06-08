<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mycompany.model.Emprestimo" %>
<%@ page import="java.util.List" %>
<%
    List<Emprestimo> lista = (List<Emprestimo>) request.getAttribute("emprestimos");
%>
<html>
<head>
    <title>Empréstimos Ativos/Atrasados</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            margin: 40px;
            color: #333;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f1f9ff;
        }
        form {
            margin: 0;
            display: inline-block;
        }
        .btn-devolver, .btn-renovar {
            padding: 8px 14px;
            border: none;
            color: white;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-transform: uppercase;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        input[type="date"] {
            padding: 4px 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            vertical-align: middle;
        }
        td form input[type="date"] {
            width: 130px;
            margin-left: 8px;
        }
        
        .btn-devolver {
    background-color: #28a745; 
        }

        .btn-devolver:hover {
            background-color: #218838; /* Verde mais escuro */
        }

        /* Cor específica para o botão RENOVAR (Azul = Ação Primária) */
        .btn-renovar {
            background-color: #007bff;
        }

        .btn-renovar:hover {
            background-color: #0056b3; /* Azul mais escuro */
        }
    </style>
</head>
<body>
<h2>Lista de Empréstimos Ativos ou Atrasados</h2>
<table>
    <tr>
        <th>ID</th><th>ID Usuário</th><th>ID Livro</th><th>Data Empréstimo</th><th>Devolução Prevista</th><th>Status</th><th>Ações</th>
    </tr>
    <%
        for (Emprestimo e : lista) {
    %>
    <tr>
        <td><%= e.getId() %></td>
        <td><%= e.getUsuario().getId() %> - <%= e.getUsuario().getNome() %></td>
        <td><%= e.getLivro().getTitulo() %></td>
        <td><%= e.getDataEmprestimo() %></td>
        <td><%= e.getDataDevolucaoPrevista() %></td>
        <td><%= e.getStatus() %></td>
       
        <td>
            <form action="${pageContext.request.contextPath}/emprestimos" method="POST" style="display: flex; align-items: center; gap: 10px;">

            <input type="hidden" name="id" value="<%= e.getId() %>">

            <button type="submit" name="acao" value="devolver" class="btn-devolver">Devolver</button>

            <label for="novaData-<%= e.getId() %>" style="white-space: nowrap;">Nova Data:</label>
            <input type="date" id="novaData-<%= e.getId() %>" name="novaData">
        
            <button type="submit" name="acao" value="renovar" class="btn-renovar">Renovar</button>

    </form>
    </td>
       
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
