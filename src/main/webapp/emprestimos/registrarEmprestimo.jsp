<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Empréstimo - Sistema de Biblioteca</title>
    <meta charset="UTF-8">
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
            max-width: 450px;
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
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn-submit {
            width: 100%;
            margin-top: 15px;
            background-color: #28a745; 
            border: none;
            color: white;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #218838;
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
        <h2>Registrar Novo Empréstimo</h2>
        
        <%-- 2. Formulário com action corrigida --%>
        <form action="${pageContext.request.contextPath}/emprestimos" method="post">
            <input type="hidden" name="acao" value="registrar">
            
            <div class="form-group">
                <label for="idUsuario">ID Usuário:</label>
                <input type="number" id="idUsuario" name="idUsuario" required>
            </div>

            <div class="form-group">
                <label for="idLivro">ID Livro:</label>
                <input type="number" id="idLivro" name="idLivro" required>
            </div>

            <div class="form-group">
                <label for="dataDevolucaoPrevista">Data Devolução Prevista:</label>
                <input type="date" id="dataDevolucaoPrevista" name="dataDevolucaoPrevista" required>
            </div>

            <input type="submit" value="Registrar" class="btn-submit">
        </form>
        
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="nav-link">Voltar para o Dashboard</a>
    </div>
</body>
</html>
