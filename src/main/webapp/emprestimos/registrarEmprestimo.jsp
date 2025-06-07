<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Registrar Empréstimo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 40px;
            color: #333;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        form {
            background: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 400px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 5px;
        }
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="submit"] {
            margin-top: 25px;
            background-color: #3498db;
            border: none;
            color: white;
            padding: 10px 18px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h2>Registrar Novo Empréstimo</h2>
    <form action="../emprestimos" method="post">
        <input type="hidden" name="acao" value="registrar">
        
        <label for="idUsuario">ID Usuário:</label>
        <input type="number" id="idUsuario" name="idUsuario" required>

        <label for="idLivro">ID Livro:</label>
        <input type="number" id="idLivro" name="idLivro" required>

        <label for="dataDevolucaoPrevista">Data Devolução Prevista:</label>
        <input type="date" id="dataDevolucaoPrevista" name="dataDevolucaoPrevista" required>

        <input type="submit" value="Registrar">
    </form>
</body>
</html>
