<%-- 
    Document   : relatorioEmprestimos
    Created on : 3 de jun. de 2025, 21:10:00 (Exemplo de data)
    Author     : Vinicius
--%>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%-- Se estiver usando JSTL mais antigo (Java EE): --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatório de Empréstimos</title>
    <%-- Link para Tailwind CSS via CDN para estilização rápida --%>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Classes customizadas para status, complementando Tailwind se necessário */
        .status-ativo { background-color: #fef9c3; color: #713f12; } /* bg-yellow-100 text-yellow-800 */
        .status-devolvido { background-color: #dcfce7; color: #166534; } /* bg-green-100 text-green-800 */
        .status-atrasado { background-color: #fee2e2; color: #991b1b; } /* bg-red-100 text-red-800 */
    </style>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-4 md:p-8 max-w-4xl">
        <h1 class="text-2xl md:text-3xl font-bold text-center text-gray-800 mb-8">Relatório de Empréstimos de Livros</h1>

        <form method="GET" action="${pageContext.request.contextPath}/relatorioEmprestimos" class="bg-white shadow-md rounded-lg p-6 mb-8 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 md:gap-6 items-end">
            <div>
                <label for="dataInicio" class="block text-sm font-medium text-gray-700 mb-1">Data de Início:</label>
                <input type="date" id="dataInicio" name="dataInicio" value="${dataInicioSelecionada}" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            <div>
                <label for="dataFim" class="block text-sm font-medium text-gray-700 mb-1">Data de Fim:</label>
                <input type="date" id="dataFim" name="dataFim" value="${dataFimSelecionada}" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            <button type="submit" name="gerarRelatorio" value="true" class="sm:col-span-2 md:col-span-1 w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 px-4 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 h-10 transition ease-in-out duration-150">
                Gerar Relatório
            </button>
        </form>

        <%-- Exibe mensagens de erro ou informação --%>
        <c:if test="${not empty mensagemErro}">
            <div class="mb-6 p-4 text-sm text-red-800 bg-red-100 rounded-lg border border-red-300" role="alert">
                <span class="font-bold">Erro!</span> ${mensagemErro}
            </div>
        </c:if>
        <c:if test="${not empty mensagemInfo}">
            <div class="mb-6 p-4 text-sm text-blue-800 bg-blue-100 rounded-lg border border-blue-300" role="alert">
                <span class="font-bold">Info:</span> ${mensagemInfo}
            </div>
        </c:if>

        <div id="areaRelatorio" class="mt-8 bg-white shadow-xl rounded-lg overflow-hidden">
            <h2 class="text-xl md:text-2xl font-semibold text-gray-800 px-6 py-4 border-b border-gray-200">Resultados</h2>
            <div class="table-responsive">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Usuário</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Livro</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Data Empréstimo</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Devolução Prevista</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Devolução Real</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${not empty emprestimos}">
                                <c:forEach var="emp" items="${emprestimos}">
                                    <tr class="hover:bg-gray-100 transition-colors duration-150">
                                        <td class="px-6 py-4  text-sm font-medium text-gray-900">${emp.usuario.nome}</td>
                                        <td class="px-6 py-4  text-sm text-gray-700">${emp.livro.titulo}</td>
                                        <td class="px-6 py-4  text-sm text-gray-700">${emp.getDataEmprestimoFormatada()}</td>
                                        <td class="px-6 py-4  text-sm text-gray-700">${emp.getDataDevolucaoPrevistaFormatada()}</td>
                                        <td class="px-6 py-4  text-sm text-gray-700">${emp.getDataDevolucaoRealFormatada()}</td>
                                        <td class="px-6 py-4  text-sm">
                                            <span class="px-3 py-1 text-xs font-semibold rounded-full
                                                <c:choose>
                                                    <c:when test="${emp.status.toString() == 'ATIVO'}">status-ativo</c:when>
                                                    <c:when test="${emp.status.toString() == 'DEVOLVIDO'}">status-devolvido</c:when>
                                                    <c:when test="${emp.status.toString() == 'ATRASADO'}">status-atrasado</c:when>
                                                    <c:otherwise>bg-gray-200 text-gray-800</c:otherwise>
                                                </c:choose>
                                            ">${emp.status}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                 <tr>
                                    <td colspan="6" class="px-6 py-10 text-sm text-gray-500 text-center">
                                        <c:choose>
                                            <c:when test="${not empty param.gerarRelatorio and empty mensagemErro}">
                                                Nenhum empréstimo encontrado para o período selecionado.
                                            </c:when>
                                            <c:when test="${empty param.gerarRelatorio and empty mensagemErro and empty mensagemInfo}">
                                                Nenhum relatório gerado ainda. Selecione o período e clique em "Gerar Relatório".
                                            </c:when>
                                            
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
