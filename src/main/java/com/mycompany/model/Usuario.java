package com.mycompany.model;

/**
 * Representa um usuário do sistema da biblioteca.
 * @author Vinicius
 */
public class Usuario {
    
    // --- Atributos ---
    private int id;
    private String nome;
    private TipoUsuario tipo; // Padronizado para "tipo"

    // --- Construtores ---

    /**
     * Construtor completo para criar um usuário com todos os dados.
     */
    public Usuario(int id, String nome, TipoUsuario tipo) {
        this.id = id;
        this.nome = nome;
        this.tipo = tipo; // Corrigido para atribuir ao atributo "tipo"
    }

    /**
     * Construtor vazio, útil para criar objetos passo a passo.
     */
    public Usuario() {
        // Construtor vazio é uma boa prática
    }

    // --- Getters e Setters (Métodos de Acesso) ---

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

    // Métodos padronizados para o atributo "tipo"
    public TipoUsuario getTipo() {
        return tipo;
    }

    public void setTipo(TipoUsuario tipo) {
        this.tipo = tipo;
    }
}
