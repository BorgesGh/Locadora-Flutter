package org.pessoal.locadora_dw2.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.pessoal.locadora_dw2.domain.Item;
import org.pessoal.locadora_dw2.service.ItemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "Controlador de Item", description = "Controller que manipula todos os end-points de Item")
public class ItemController {

    private ItemService itemService;

    public ItemController(ItemService itemService) {
        this.itemService = itemService;
    }

    @Operation(description = "Listagem de todos os itens")
    @GetMapping("/item/getAll")
    public ResponseEntity<List<Item>> getAll() {
        try{
            return ResponseEntity.ok().body(itemService.getItems());
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Atualização de um item existente")
    @PutMapping("/item/update")
    public ResponseEntity<Item> update(@RequestBody Item item) {
        try{
            return ResponseEntity.ok().body(itemService.update(item));
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Exclusão de um item")
    @DeleteMapping("/item/delete")
    public ResponseEntity<String> delete(@RequestBody Item item) {
        try {
            itemService.deleteItem(item);
            return ResponseEntity.ok().body("Item deletado com sucesso!");
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Adição de um novo item")
    @PostMapping("/item/add")
    public ResponseEntity<Item> add(@RequestBody Item item) {
        return ResponseEntity.ok().body(itemService.addItem(item));
    }
}