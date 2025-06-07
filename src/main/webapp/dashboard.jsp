<%-- 
    Document   : dashboard
    Created on : 31 de mai. de 2025, 20:39:06
    Author     : Vinicius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
                text-align: center;
                font-family: sans-serif; 
                margin: 20px;
            }
            #sessionInfo{ 
                margin-top: 20px;
                padding: 10px; 
                background-color: #f0f0f0; 
                border: 1px solid #ccc;
                
            }
            .logout-button {
            display: inline-block;
            padding: 8px 15px;
            margin-top: 15px;
            background-color: #dc3545; 
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: 1px solid #dc3545;
        }
        .logout-button:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        </style>
    </head>
    <body>
        <h1>Bem vindo ao Sistema de Biblioteca </h1>
        
        <p><a href="LogoutServlet" class="logout-button">Sair do Sistema</a></p>
    </body>
</html>
