package org.pessoal.locadora_dw2.repository;

import org.pessoal.locadora_dw2.domain.Titulo;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TituloRepository extends CrudRepository<Titulo, Integer> {
}
