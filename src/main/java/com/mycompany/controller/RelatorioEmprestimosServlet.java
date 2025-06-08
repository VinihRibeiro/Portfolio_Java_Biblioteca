package com.mycompany.controller;

import com.mycompany.dao.EmprestimoDAO;
import com.mycompany.model.Emprestimo;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/relatorioEmprestimos") 
public class RelatorioEmprestimosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicioStr = request.getParameter("dataInicio");
        String dataFimStr = request.getParameter("dataFim");
        List<Emprestimo> emprestimosFiltrados = new ArrayList<>();

        
        if (dataInicioStr != null && !dataInicioStr.isEmpty() && dataFimStr != null && !dataFimStr.isEmpty()) {
            try {
                SimpleDateFormat parserSdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dataInicioUtil = parserSdf.parse(dataInicioStr);
                Date dataFimUtilOriginal = parserSdf.parse(dataFimStr);

                
                if (dataInicioUtil.after(dataFimUtilOriginal)) {
                    request.setAttribute("mensagemErro", "A data de início não pode ser posterior à data de fim.");
                } else {
                    
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(dataFimUtilOriginal);
                    cal.add(Calendar.DAY_OF_MONTH, 1);
                    cal.add(Calendar.MILLISECOND, -1);
                    Date dataFimUtilAjustada = cal.getTime();

                    
                    EmprestimoDAO dao = new EmprestimoDAO();
                    emprestimosFiltrados = dao.gerarRelatorioPorData(dataInicioUtil, dataFimUtilAjustada);

                    if (emprestimosFiltrados.isEmpty()) {
                        request.setAttribute("mensagemInfo", "Nenhum empréstimo encontrado para o período selecionado.");
                    }
                }
            } 
            catch (ParseException e) {
                request.setAttribute("mensagemErro", "Formato de data inválido. Use o seletor de datas.");
            } catch (SQLException e) {
                request.setAttribute("mensagemErro", "Erro ao consultar o banco de dados: " + e.getMessage());
                e.printStackTrace(); // Para depuração no console do servidor
            }
        } // 

        // Atributos para manter os valores selecionados nos campos do formulário
        request.setAttribute("emprestimos", emprestimosFiltrados);
        request.setAttribute("dataInicioSelecionada", dataInicioStr);
        request.setAttribute("dataFimSelecionada", dataFimStr);

        // Encaminha para a página JSP exibir o resultado
        request.getRequestDispatcher("/relatorioEmprestimos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Faz com que o POST se comporte como o GET para simplificar
        doGet(request, response);
    }
}
