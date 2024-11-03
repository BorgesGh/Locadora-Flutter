package org.pessoal.locadora_dw2.repository;

import org.pessoal.locadora_dw2.domain.Item;
import org.springframework.data.repository.CrudRepository;

public interface ItemRepository extends CrudRepository<Item, Integer> {
}
