package org.pessoal.locadora_dw2.service;

import org.pessoal.locadora_dw2.domain.Diretor;
import org.pessoal.locadora_dw2.repository.DiretorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiretorService {
    private DiretorRepository diretorRepository;

    public DiretorService(DiretorRepository DiretorRepository) {
        this.diretorRepository = DiretorRepository;
    }

    public List<Diretor> getDiretores(){
        return (List<Diretor>) diretorRepository.findAll();
    }

    public Diretor update(Diretor diretor){

        Diretor dtNovo = diretorRepository.findById(diretor.getId()).get();
        dtNovo.setNome(diretor.getNome());
        diretorRepository.save(dtNovo);

        return dtNovo;
    }

    public void delete(Diretor diretor){
        diretorRepository.delete(diretor);
    }

    public Diretor addDiretor(Diretor Diretor){
        return diretorRepository.save(Diretor);
    }
}
