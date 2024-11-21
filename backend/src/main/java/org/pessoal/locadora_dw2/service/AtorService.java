package org.pessoal.locadora_dw2.service;

import org.pessoal.locadora_dw2.domain.Ator;
import org.pessoal.locadora_dw2.exceptions.ElementoJaReferenciado;
import org.pessoal.locadora_dw2.repository.AtorRepository;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AtorService {

    private AtorRepository atorRepository;

    public AtorService(AtorRepository atorRepository) {
        this.atorRepository = atorRepository;
    }

    public List<Ator> getAtores(){
        return (List<Ator>) atorRepository.findAll();
    }

    public Ator update(Ator ator){

        Ator atNovo = atorRepository.findById(ator.getIdAtor()).get();
        atNovo.setNome(ator.getNome());
        atorRepository.save(atNovo);

        return ator;
    }

    public void delete(Ator ator) throws ElementoJaReferenciado {
        try {
            atorRepository.delete(ator);
        }catch (DataIntegrityViolationException e){
            throw new ElementoJaReferenciado();
        }

    }

    public Ator addAtor(Ator ator){
        return atorRepository.save(ator);
    }

}
