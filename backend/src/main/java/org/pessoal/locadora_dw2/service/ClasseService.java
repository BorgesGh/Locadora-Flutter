package org.pessoal.locadora_dw2.service;

import org.pessoal.locadora_dw2.domain.Classe;
import org.pessoal.locadora_dw2.repository.ClasseRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClasseService {
    private ClasseRepository classeRepository;

    public ClasseService(ClasseRepository classeRepository) {
        this.classeRepository = classeRepository;
    }

    public List<Classe> getClassees(){
        return (List<Classe>) classeRepository.findAll();
    }

    public Classe update(Classe classe){

        Classe clNovo = classeRepository.findById(classe.getId()).get();
        clNovo.setNome(classe.getNome());
        clNovo.setDataDevolucao(classe.getDataDevolucao());
        clNovo.setValor(classe.getValor());
        classeRepository.save(clNovo);

        return clNovo;
    }

    public void delete(Classe Classe){
        classeRepository.delete(Classe);
    }

    public Classe addClasse(Classe Classe){
        return classeRepository.save(Classe);
    }
}
