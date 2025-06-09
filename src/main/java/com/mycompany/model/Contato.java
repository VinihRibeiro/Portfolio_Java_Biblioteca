package com.mycompany.model;

/**
 * Representa um Contato na agenda.
 * Substitui a antiga classe JavaBeans.
 */
public class Contato {
    
    // --- Atributos ---
    // ID padronizado para int, como nas outras classes do projeto
    private int id;
    private String nome;
    private String email;
    private String telefone;
    private String endereco;
    private String tipoUsuario;
    private String dataCadastro;

    // --- Construtores ---
    public Contato() {
        // Construtor vazio
    }

    public Contato(int id, String nome, String email, String telefone, String endereco, String tipoUsuario, String dataCadastro) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.endereco = endereco;
        this.tipoUsuario = tipoUsuario;
        this.dataCadastro = dataCadastro;
    }

    // --- Getters e Setters ---
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getTelefone() {
        return telefone;
    }
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    public String getEndereco() {
        return endereco;
    }
    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }
    public String getTipoUsuario() {
        return tipoUsuario;
    }
    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }
    public String getDataCadastro() {
        return dataCadastro;
    }
    public void setDataCadastro(String dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
}
