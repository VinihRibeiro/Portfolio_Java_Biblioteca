<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style> 
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 300px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label, input { display: block; margin-bottom: 10px; }
        input[type="text"], input[type="password"] { width: calc(100% - 10px); padding: 5px; }
        input[type="submit"] { width: 100px; height: 40px; padding: 10px 15px; background-color: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; margin-left: 120px; }
        .message { margin-bottom: 15px; padding: 10px; border-radius: 3px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        a { color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login do Sistema</h2>

        <div id="messageAreaLogin">
            <%
                // Exibir mensagem de erro do servlet (ex: acesso negado ao dashboard)
                String erroServlet = request.getParameter("erro");
                if (erroServlet != null) {
                    if ("acesso_negado".equals(erroServlet) || "acesso_negado_filter".equals(erroServlet)) {
                        out.println("<div class='message error'>Acesso negado. Faça login primeiro.</div>");
                    }
                }
                String msgLogout = (String) request.getParameter("msg");
                if (msgLogout != null && msgLogout.equals("logout")) {
                    out.println("<div class='message success'>Logout realizado com sucesso!</div>");
                }
            %>
        </div>

        <form id="formLogin" action="LoginServlet" method="post">
            <label for="username">Usuário:</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required><br>

            <input type="checkbox" id="rememberMe" name="rememberMe" value="true" style="display:inline-block; width:auto;">
            <label for="rememberMe" style="display:inline-block;">Lembre-se de mim</label><br><br>

            <input type="submit" value="Entrar">
        </form>
        <p><a href="cadastro.jsp">Não tem uma conta? Crie uma aqui</a></p>
    </div>

    <script>
        // Preencher username do cookie se existir 
        window.onload = function() {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                let cookie = cookies[i].trim();
                if (cookie.startsWith('username=')) {
                    document.getElementById('username').value = cookie.substring('username='.length, cookie.length);
                    break;
                }
            }
        };

        document.getElementById('formLogin').addEventListener('submit', function(event) {
            event.preventDefault(); // Impede o envio padrão inicialmente

            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const messageArea = document.getElementById('messageAreaLogin');
            messageArea.innerHTML = ''; // Limpa mensagens anteriores (exceto as do servlet)

            let usuarios = JSON.parse(localStorage.getItem('usuarios')) || [];
            const usuarioEncontrado = usuarios.find(user => user.username === username && user.password === password);

            
            if (usuarioEncontrado) {
               
                this.submit(); // Submete o formulário via POST para LoginServlet
            } else {
                // Usuário ou senha inválidos
                let msgDiv = document.createElement('div');
                msgDiv.className = 'message error';
                msgDiv.textContent = 'Usuário ou senha inválidos';
                // Adiciona a mensagem no topo da área de mensagens, preservando as do servlet se houver
                if (messageArea.firstChild) {
                    messageArea.insertBefore(msgDiv, messageArea.firstChild);
                } else {
                    messageArea.appendChild(msgDiv);
                }
            }
        });
    </script>
</body>
</html>