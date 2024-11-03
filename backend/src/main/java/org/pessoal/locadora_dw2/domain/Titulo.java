package org.pessoal.locadora_dw2.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class Titulo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idTitulo;

    private String nome;
    private int ano;
    private String sinopse;
    private String categoria;

    @ManyToMany (fetch = FetchType.EAGER)
    @JoinTable(
        name = "Atores_Titulo",// Nome da tabela de junção
        joinColumns = @JoinColumn(name = "idTitulo",unique = false), // Coluna que referencia Titulo
        inverseJoinColumns = @JoinColumn(name = "idAtor", unique = false) // Coluna que referencia Ator
    )
    private List<Ator> atores;

    @ManyToOne(fetch = FetchType.EAGER)
    private Diretor diretor;

    @ManyToOne(fetch = FetchType.EAGER)
    private Classe classe;
}
