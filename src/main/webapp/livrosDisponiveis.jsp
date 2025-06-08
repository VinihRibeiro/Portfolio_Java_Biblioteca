<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 1. Importando a biblioteca JSTL que torna a página mais limpa --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Livros Disponíveis - Sistema de Biblioteca</title>
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
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
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
            background-color: #28a745; 
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e9f5ec;
        }
        .message {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: #555;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        .nav-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        .nav-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Livros Disponíveis para Empréstimo</h1>

        
        <c:if test="${not empty mensagemErro}">
            <p class="message" style="color: red; background-color: #f8d7da;">${mensagemErro}</p>
        </c:if>

        <%-- 2. Uso de JSTL para verificar a lista e iterar sobre ela --%>
        <c:choose>
            <c:when test="${not empty livrosDisponiveis}">
                <table>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Categoria</th>
                        <th>Quantidade</th>
                    </tr>
                    <c:forEach var="livro" items="${livrosDisponiveis}">
                        <tr>
                            <td>${livro.titulo}</td>
                            <td>${livro.autor}</td>
                            <td>${livro.categoria}</td>
                            <td>${livro.quantidade}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <p class="message">Nenhum livro disponível no momento.</p>
            </c:otherwise>
        </c:choose>
        
        <a href="dashboard.jsp" class="nav-link">Voltar para o Dashboard</a>
    </div>
</body>
</html>
