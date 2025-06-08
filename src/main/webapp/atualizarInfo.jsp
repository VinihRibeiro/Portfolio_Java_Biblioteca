<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Importando a biblioteca JSTL para exibir as mensagens --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Atualizar Livro - Sistema de Biblioteca</title>
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
            max-width: 500px;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
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
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #f39c12; 
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #e67e22;
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
        <h1>Atualizar Informações de Livro</h1>
        
        <%-- Bloco para exibir mensagens de sucesso ou erro do servlet --%>
        <c:if test="${not empty mensagemSucesso}">
            <p class="message success">${mensagemSucesso}</p>
        </c:if>
        <c:if test="${not empty mensagemErro}">
            <p class="message error">${mensagemErro}</p>
        </c:if>

        <form name="atualizar" action="${pageContext.request.contextPath}/atualizarLivro" method="POST">
            <div class="form-group">
                <label for="isbnEdit">Insira o ISBN do livro que deseja Editar</label>
                <%-- Tipo corrigido para "text" --%>
                <input type="text" id="isbnEdit" name="isbnEdit" required>
            </div>
            
            <div class="form-group">
                <label for="campoDesejado">Qual campo deseja Editar</label>
                <select id="campoDesejado" name="campoDesejado" required>    
                    <option value="">-- Selecione um campo --</option>
                    <option value="titulo">Título</option>
                    <option value="autor">Autor</option>
                    <option value="editora">Editora</option>
                    <option value="categoria">Categoria</option>
                    <option value="ano_publicacao">Ano de publicação</option>
                    <option value="isbn">ISBN</option>
                    <option value="quantidade_disponivel">Quantidade</option>
                    <option value="descricao">Descrição</option>
                </select>
            </div>

            <div class="form-group">
                <label for="novoValor">Digite a nova informação</label>
                <input type="text" id="novoValor" name="novoValor" required>
            </div>
            
            <button type="submit" class="btn-submit">Atualizar</button>
        </form>

        <a href="dashboard.jsp" class="nav-link">Voltar para o Dashboard</a>
    </div>
</body>
</html>
