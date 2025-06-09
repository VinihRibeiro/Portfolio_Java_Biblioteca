<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Contato - Agenda</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f4f8; color: #333; display: flex; justify-content: center; align-items: flex-start; min-height: 100vh; margin: 0; padding: 40px; }
        .container { width: 100%; max-width: 500px; background-color: #fff; padding: 30px 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 25px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; }
        input[type="text"], input[type="email"], select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 12px; background-color: #f39c12; color: white; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease; }
        .btn-submit:hover { background-color: #e67e22; }
        .nav-link { display: block; text-align: center; margin-top: 20px; color: #3498db; text-decoration: none; font-weight: bold; }
        .nav-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Editar Usuário</h1>
        
        <form name="frmContato" action="${pageContext.request.contextPath}/agenda/editar" method="POST">
            
            <input type="hidden" name="id" value="${contato.id}">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${contato.nome}">
            </div>
            
            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" id="telefone" name="telefone" value="${contato.telefone}">
            </div>

            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="text" id="email" name="email" value="${contato.email}">
            </div>

            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="${contato.endereco}">
            </div>

            <%-- CAMPO ADICIONADO AQUI --%>
            <div class="form-group">
                <label for="tipo_usuario">Tipo de Usuário:</label>
                <select id="tipo_usuario" name="tipo_usuario" required>
                    <option value="ESTUDANTE" ${contato.tipoUsuario == 'ESTUDANTE' ? 'selected' : ''}>Estudante</option>
                    <option value="PROFESSOR" ${contato.tipoUsuario == 'PROFESSOR' ? 'selected' : ''}>Professor</option>
                    <option value="FUNCIONARIO" ${contato.tipoUsuario == 'FUNCIONARIO' ? 'selected' : ''}>Funcionário</option>
                </select>
            </div>

            <button type="submit" class="btn-submit">Salvar Alterações</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/agenda" class="nav-link">Cancelar e Voltar para Agenda</a>
    </div>
</body>
</html>
