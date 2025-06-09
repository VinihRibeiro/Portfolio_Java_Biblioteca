<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard - Sistema de Biblioteca</title>
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
            max-width: 800px; /* Aumentei um pouco para caber a nova seção */
            margin: 0 auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #2c3e50;
            text-align: center;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
        }
        h1 {
            margin-bottom: 30px;
        }
        h2 {
            margin-top: 40px;
            font-size: 1.5em;
        }
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .action-button {
            display: block;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        /* Cores específicas */
        .btn-green { background-color: #28a745; }
        .btn-blue { background-color: #007bff; }
        .btn-orange { background-color: #fd7e14; }
        .btn-purple { background-color: #6f42c1; }
        .btn-teal { background-color: #20c997; } /* Nova cor para Agenda */
        .btn-red { background-color: #dc3545; }
        
        .logout-container {
            margin-top: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Dashboard da Biblioteca</h1>

        <%-- Seção de Gestão de Usuários (Agenda) --%>
        <h2>Gestão de Usuários</h2>
        <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/agenda" class="action-button btn-teal">Gerenciar Usuários (Agenda)</a>
        </div>

        <%-- Seção de Gestão de Livros --%>
        <h2>Gestão de Livros</h2>
        <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/cadastroLivro.jsp" class="action-button btn-green">Cadastrar Novo Livro</a>
            <a href="${pageContext.request.contextPath}/listarLivros" class="action-button btn-blue">Pesquisar Livros</a>
            <a href="${pageContext.request.contextPath}/atualizarInfo.jsp" class="action-button btn-orange">Atualizar Livro</a>
            <a href="${pageContext.request.contextPath}/livrosDisponiveis" class="action-button btn-green">Ver Livros Disponíveis</a>
        </div>

        <%-- Seção de Gestão de Empréstimos --%>
        <h2>Gestão de Empréstimos</h2>
        <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/emprestimos/registrarEmprestimo.jsp" class="action-button btn-green">Registrar Empréstimo</a>
            <a href="${pageContext.request.contextPath}/relatorioEmprestimos.jsp" class="action-button btn-purple">Relatório de Empréstimos</a>
        </div>

        <%-- Botão de Sair --%>
        <div class="logout-container">
            <a href="LogoutServlet" class="action-button btn-red" style="display: inline-block; width: auto;">Sair do Sistema</a>
        </div>
    </div>
</body>
</html>
