package org.pessoal.locadora_dw2.controller;

import org.pessoal.locadora_dw2.domain.Item;
import org.pessoal.locadora_dw2.service.ItemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ItemController {

    ItemService itemService;
    public ItemController(ItemService itemService) {
        this.itemService = itemService;
    }

    @GetMapping("/item/getAll")
    public ResponseEntity<List<Item>> getAll() {
        try{
            return ResponseEntity.ok().body(itemService.getItems());
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/item/update")
    public ResponseEntity<Item> update(@RequestBody Item item) {
        try{
            return ResponseEntity.ok().body(itemService.update(item));
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @DeleteMapping("/item/delete")
    public ResponseEntity delete(@RequestBody Item item) {
        try {
            itemService.deleteItem(item);
            return ResponseEntity.ok().build();
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping("/item/add")
    public ResponseEntity<Item> add(@RequestBody Item item) {
        return ResponseEntity.ok().body(itemService.addItem(item));
    }
}