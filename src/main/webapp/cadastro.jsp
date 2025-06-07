<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criar Nova Conta</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 300px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label, input { display: block; margin-bottom: 10px; }
        input[type="text"], input[type="password"], input[type="email"] { width: calc(100% - 10px); padding: 5px; }
        input[type="submit"] { padding: 10px 15px; background-color: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer; }
        .message { margin-bottom: 15px; padding: 10px; border-radius: 3px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        a { color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Criar Nova Conta</h2>
        <div id="messageArea"></div>
        <form id="formCriarConta">
            <label for="newUsername">Usu�rio:</label>
            <input type="text" id="newUsername" name="newUsername" required>

            <label for="newEmail">Email (opcional):</label>
            <input type="email" id="newEmail" name="newEmail">

            <label for="newPassword">Senha:</label>
            <input type="password" id="newPassword" name="newPassword" required>

            <label for="confirmPassword">Confirmar Senha:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>

            <input type="submit" value="Criar Conta">
        </form>
        <p><a href="login.jsp">J� tem uma conta? Fa�a login</a></p>
    </div>

    <script>
        document.getElementById('formCriarConta').addEventListener('submit', function(event) {
            event.preventDefault(); 

            const username = document.getElementById('newUsername').value.trim();
            const email = document.getElementById('newEmail').value.trim();
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const messageArea = document.getElementById('messageArea');
            messageArea.innerHTML = ''; // Limpa mensagens anteriores

            if (!username || !password) {
                displayMessage('Usu�rio e senha s�o obrigat�rios.', 'error');
                return;
            }

            if (password !== confirmPassword) {
                displayMessage('As senhas n�o coincidem!', 'error');
                return;
            }

            // Recupera usu�rios existentes do Local Storage ou inicializa um array vazio
            let usuarios = JSON.parse(localStorage.getItem('usuarios')) || [];

            // Verifica se o usu�rio j� existe
            const usuarioExistente = usuarios.find(user => user.username === username);
            if (usuarioExistente) {
                displayMessage('Este nome de usu�rio j� est� em uso.', 'error');
                return;
            }

            // Adiciona o novo usu�rio
            
            usuarios.push({ username: username, email: email, password: password });

            // Salva a lista atualizada de usu�rios no Local Storage
            localStorage.setItem('usuarios', JSON.stringify(usuarios));

            alert('Conta criada com sucesso! Voc� pode fazer login agora.');
            document.getElementById('formCriarConta').reset(); // Limpa o formul�rio
            
             window.location.href = 'login.jsp';
        });

        function displayMessage(message, type) {
            const messageArea = document.getElementById('messageArea');
            messageArea.innerHTML = `<div class="message ${type}">${message}</div>`;
        }
    </script>
</body>
</html>