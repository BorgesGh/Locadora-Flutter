package org.pessoal.locadora_dw2.exceptions;

public class ElementoJaReferenciado extends Exception {
    @Override
    public String getMessage() {
        return "Elemento ja referenciado";
    }
}
