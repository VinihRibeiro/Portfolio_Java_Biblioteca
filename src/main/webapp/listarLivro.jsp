<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 1. Importando a biblioteca JSTL --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pesquisa de Livros - Sistema de Biblioteca</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            margin: 0;
            padding: 40px;
        }
        .container {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #2c3e50;
            text-align: center;
        }
        .search-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        .form-group {
            flex-grow: 1;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn-search {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-search:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f9ff;
        }
        .message {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: #555;
        }
         .nav-links {
            text-align: center;
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .nav-links a {
            margin: 0 15px;
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Pesquisa de Livro</h1>
        
        
        <form name="pesquisar" action="${pageContext.request.contextPath}/listarLivros" method="GET" class="search-form">
            <div class="form-group">
                <label for="parametro">Pesquisar por:</label>
                <select name="parametro" id="parametro" required>
                    <option value="">-- Selecione --</option>
                    <option value="titulo" ${param.parametro == 'titulo' ? 'selected' : ''}>Título</option>
                    <option value="autor" ${param.parametro == 'autor' ? 'selected' : ''}>Autor</option>
                    <option value="isbn" ${param.parametro == 'isbn' ? 'selected' : ''}>ISBN</option>
                    <option value="categoria" ${param.parametro == 'categoria' ? 'selected' : ''}>Categoria</option>
                </select>
            </div>
            <div class="form-group">
                <label for="escolha">Valor da pesquisa:</label>
                <input type="text" name="escolha" id="escolha" value="${param.escolha}" required>
            </div>
            <button type="submit" class="btn-search">Pesquisar</button>
        </form>

        <h2>Resultado da Pesquisa:</h2>

        <%-- 3. Uso de JSTL para exibir os resultados de forma limpa --%>
        <c:choose>
            <c:when test="${not empty livros}">
                <table>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Editora</th>
                        <th>Ano</th>
                        <th>ISBN</th>
                        <th>Qtd.</th>
                        <th>Categoria</th>
                    </tr>
                    <c:forEach var="livro" items="${livros}">
                        <tr>
                            <td>${livro.titulo}</td>
                            <td>${livro.autor}</td>
                            <td>${livro.editora}</td>
                            <td>${livro.anoPublicacao}</td>
                            <td>${livro.isbn}</td>
                            <td>${livro.quantidade}</td>
                            <td>${livro.categoria}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <%-- Mensagem mostrada apenas se uma pesquisa foi feita e nada foi encontrado --%>
                <c:if test="${not empty param.escolha}">
                    <p class="message">Nenhum livro encontrado para o critério informado.</p>
                </c:if>
            </c:otherwise>
        </c:choose>
        
        <div class="nav-links">
            <a href="cadastroLivro.jsp">Cadastrar novo livro</a>
            <a href="dashboard.jsp">Voltar para o Dashboard</a>
        </div>
    </div>
</body>
</html>
