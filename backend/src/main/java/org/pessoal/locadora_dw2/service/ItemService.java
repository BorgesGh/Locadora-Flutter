package org.pessoal.locadora_dw2.service;

import jakarta.persistence.Entity;
import org.pessoal.locadora_dw2.domain.Item;
import org.pessoal.locadora_dw2.repository.ItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemService {

    private ItemRepository itemRepository;
    public ItemService(ItemRepository itemRepository) {
        this.itemRepository = itemRepository;
    }

    public List<Item> getItems(){
        return (List<Item>) itemRepository.findAll();
    }

    public Item update(Item item){
        return itemRepository.save(item);
    }

    public Item addItem(Item item){
        return itemRepository.save(item);
    }

    public void deleteItem(Item item){
        itemRepository.delete(item);
    }
}
