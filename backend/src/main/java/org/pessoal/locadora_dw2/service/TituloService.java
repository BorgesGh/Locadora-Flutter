package org.pessoal.locadora_dw2.service;

import org.pessoal.locadora_dw2.domain.Titulo;
import org.pessoal.locadora_dw2.repository.TituloRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TituloService {

    private TituloRepository tituloRepository;

    public TituloService(TituloRepository tituloRepository) {
        this.tituloRepository = tituloRepository;
    }

    public List<Titulo> getTitulos(){
        return (List<Titulo>) tituloRepository.findAll();
    }

    public Titulo update(Titulo titulo){
        return tituloRepository.save(titulo);
    }

    public void delete(Titulo titulo){
        tituloRepository.delete(titulo);
    }

    public Titulo addTitulo(Titulo titulo){
        return tituloRepository.save(titulo);
    }
}
