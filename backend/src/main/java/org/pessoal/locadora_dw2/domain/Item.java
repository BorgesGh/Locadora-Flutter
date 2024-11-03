package org.pessoal.locadora_dw2.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Data
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idItem;

    private int numSerie;
    private Date dataAquisicao;
    private String tipoItem;

    @ManyToOne(fetch = FetchType.EAGER)
    private Titulo titulo;

}
