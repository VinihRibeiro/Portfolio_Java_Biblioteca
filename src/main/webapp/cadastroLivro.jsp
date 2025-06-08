<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Livro - Sistema de Biblioteca</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            margin: 0;
            padding: 40px;
        }
        .container {
            width: 100%;
            max-width: 600px;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; 
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #2980b9;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
            font-weight: bold;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .nav-link {
            display: block;
            text-align: center;
            margin-top: 20px;
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
        <h2>Cadastro de Livro</h2>
        
        <%-- Bloco para exibir mensagens de sucesso ou erro --%>
        <c:if test="${not empty mensagemSucesso}">
            <p class="message success">${mensagemSucesso}</p>
        </c:if>
        <c:if test="${not empty mensagemErro}">
            <p class="message error">${mensagemErro}</p>
        </c:if>

        <form name="FormCadastroLivro" action="${pageContext.request.contextPath}/cadastrarLivro" method="POST">
            <div class="form-group">
                <label for="titulo">Título</label>
                <input id="titulo" type="text" name="titulo" required>
            </div>
            
            <div class="form-group">
                <label for="autor">Autor</label>
                <input id="autor" type="text" name="autor" required>
            </div>
            
            <div class="form-group">
                <label for="editora">Editora</label>
                <input id="editora" type="text" name="editora">
            </div>
            
            <div class="form-group">
                <label for="anoPubli">Ano de Publicação</label>
                <input id="anoPubli" type="number" name="anoPubli" required>
            </div>
            
            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input id="isbn" type="text" name="isbn" required>
            </div>
            
            <div class="form-group">
                <label for="quantidade">Quantidade Disponível</label>
                <input id="quantidade" type="number" name="quantidade" required>
            </div>
            
            <div class="form-group">
                <label for="categoria">Categoria</label>
                <input id="categoria" type="text" name="categoria" required>
            </div>
            
            <div class="form-group">
                <label for="descricao">Descrição</label>
                <textarea id="descricao" name="descricao" rows="4"></textarea>
            </div>
            
            <button type="submit" class="btn-submit">Cadastrar</button>
        </form>

        <a href="dashboard.jsp" class="nav-link">Voltar para o Dashboard</a>
    </div>
</body>
</html>
