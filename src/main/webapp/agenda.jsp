<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Agenda de Usuários - Sistema de Biblioteca</title>
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
        .form-container {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        /* ... outros estilos do formulário ... */
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; }
        input[type="text"], input[type="email"], select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; box-sizing: border-box; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .btn-submit { padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; margin-top: 10px; }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        .message {
            text-align: center;
            font-size: 16px;
            color: #155724;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        /* ESTILO PARA O NOVO BOTÃO DE EDITAR */
        .btn-action {
            display: inline-block;
            padding: 6px 12px;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn-edit {
            background-color: #f39c12; /* Laranja */
        }
        .btn-edit:hover {
            background-color: #e67e22;
        }
        .nav-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        /* ... (seus outros estilos) ... */
    .btn-delete {
        background-color: #dc3545; /* Vermelho */
    }
    .btn-delete:hover {
        background-color: #c82333;
    }
    </style>
</head>
<body>
    <div class="container">
        <h1>Agenda de Usuários</h1>

        <%-- Mensagem de sucesso --%>
        <c:if test="${param.status == 'sucesso'}"><p class="message">Usuário adicionado com sucesso!</p></c:if>
        <c:if test="${param.status == 'editado'}"><p class="message">Usuário atualizado com sucesso!</p></c:if>

        <%-- Formulário para adicionar novo usuário (mantido) --%>
        <div class="form-container">
             <h2>Novo Usuário</h2>
            <form name="frmContato" action="${pageContext.request.contextPath}/agenda/novo" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" required>
                    </div>
                    <div class="form-group">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="telefone">Telefone:</label>
                        <input type="text" id="telefone" name="telefone" required>
                    </div>
                    <div class="form-group">
                        <label for="tipo_usuario">Tipo de Usuário:</label>
                        <select id="tipo_usuario" name="tipo_usuario" required>
                            <option value="">-- Selecione --</option>
                            <option value="ESTUDANTE">Estudante</option>
                            <option value="PROFESSOR">Professor</option>
                            <option value="FUNCIONARIO">Funcionário</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="endereco">Endereço:</label>
                    <input type="text" id="endereco" name="endereco">
                </div>
                <button type="submit" class="btn-submit">Adicionar</button>
            </form>
        </div>

        <h2>Usuários Salvos</h2>
<table>
    <thead>
        <tr>
            <th>Nome</th>
            <th>E-mail</th>
            <th>Telefone</th>
            <th>Tipo</th>
            <th style="text-align: center;">Ações</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="contato" items="${listaDeContatos}">
            <tr>
                <td>${contato.nome}</td>
                <td>${contato.email}</td>
                <td>${contato.telefone}</td>
                <td>${contato.tipoUsuario}</td>
                <td style="display: flex; gap: 10px; justify-content: center;">
                    <%-- Botão de Editar --%>
                    <a href="${pageContext.request.contextPath}/agenda/editar?id=${contato.id}" class="btn-action btn-edit">Editar</a>
                    
                    <%-- NOVO BOTÃO DE EXCLUIR --%>
                    <a href="${pageContext.request.contextPath}/agenda/excluir?id=${contato.id}" 
                       class="btn-action btn-delete" 
                       onclick="return confirm('Tem certeza que deseja excluir o usuário ${contato.nome}?');">
                       Excluir
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        <c:if test="${empty listaDeContatos}">
            <p style="text-align: center; padding: 20px;">Nenhum usuário encontrado.</p>
        </c:if>

        <a href="dashboard.jsp" class="nav-link">Voltar para o Dashboard</a>
    </div>
</body>
</html>
