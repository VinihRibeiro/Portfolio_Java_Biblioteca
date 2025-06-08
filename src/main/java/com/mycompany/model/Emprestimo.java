package com.mycompany.model;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Representa um empréstimo de um livro por um usuário.
 */
public class Emprestimo {
    
    // --- Atributos ---
    private int id;
    private Usuario usuario;
    private Livro livro;
    private Date dataEmprestimo;
    private Date dataDevolucaoPrevista;
    private Date dataDevolucaoReal;
    private StatusEmprestimo status;

    // --- Construtores ---
    public Emprestimo() {
        // Construtor vazio é uma boa prática
    }

    // --- Getters e Setters Padrão ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public Livro getLivro() { return livro; }
    public void setLivro(Livro livro) { this.livro = livro; }

    public Date getDataEmprestimo() { return dataEmprestimo; }
    public void setDataEmprestimo(Date dataEmprestimo) { this.dataEmprestimo = dataEmprestimo; }

    public Date getDataDevolucaoPrevista() { return dataDevolucaoPrevista; }
    public void setDataDevolucaoPrevista(Date dataDevolucaoPrevista) { this.dataDevolucaoPrevista = dataDevolucaoPrevista; }

    public Date getDataDevolucaoReal() { return dataDevolucaoReal; }
    public void setDataDevolucaoReal(Date dataDevolucaoReal) { this.dataDevolucaoReal = dataDevolucaoReal; }

    public StatusEmprestimo getStatus() { return status; }
    public void setStatus(StatusEmprestimo status) { this.status = status; }

    // --- NOVOS MÉTODOS PARA FORMATAÇÃO DE DATAS ---

    /**
     * Retorna a data do empréstimo formatada como "dd/MM/yyyy".
     * @return uma String com a data formatada ou uma string vazia se a data for nula.
     */
    public String getDataEmprestimoFormatada() {
        if (this.dataEmprestimo == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(this.dataEmprestimo);
    }

    /**
     * Retorna a data de devolução prevista formatada como "dd/MM/yyyy".
     * @return uma String com a data formatada ou uma string vazia se a data for nula.
     */
    public String getDataDevolucaoPrevistaFormatada() {
        if (this.dataDevolucaoPrevista == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(this.dataDevolucaoPrevista);
    }

    /**
     * Retorna a data de devolução real formatada como "dd/MM/yyyy".
     * @return uma String com a data formatada ou "Pendente" se a data for nula.
     */
    public String getDataDevolucaoRealFormatada() {
        if (this.dataDevolucaoReal == null) {
            return "Pendente"; // Retorna um texto claro se ainda não foi devolvido
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(this.dataDevolucaoReal);
    }
}
