package org.pessoal.locadora_dw2.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AtorDTO {

    @JsonProperty("id")
    private int id;
    @JsonProperty("nome")
    private String nome;
}
