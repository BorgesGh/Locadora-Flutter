package org.pessoal.locadora_dw2.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.pessoal.locadora_dw2.domain.Diretor;
import org.pessoal.locadora_dw2.service.DiretorService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "Controlador de Diretor", description = "Controller que manipula todos os end-points de Diretor")
public class DiretorController {
    private DiretorService diretorService;

    public DiretorController(DiretorService diretorService) {
        this.diretorService = diretorService;
    }

    @Operation(description = "Listagem de todos os diretores")
    @GetMapping("/diretor/getAll")
    public ResponseEntity<List<Diretor>> getDiretores(){
        try {
            return ResponseEntity.ok().body(diretorService.getDiretores());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Atualização de um diretor existente")
    @PutMapping("/diretor/update")
    public ResponseEntity<Diretor> updateDiretor(@RequestBody Diretor diretor){
        diretorService.update(diretor);
        return ResponseEntity.ok().body(diretor);
    }

    @Operation(description = "Exclusão de um diretor")
    @DeleteMapping("/diretor/delete")
    public ResponseEntity<String> deleteDiretor(@RequestBody Diretor diretor){
        diretorService.delete(diretor);
        return ResponseEntity.ok().body("Diretor deletado com sucesso!");
    }

    @Operation(description = "Adição de um novo diretor")
    @PostMapping("/diretor/add")
    public ResponseEntity<Diretor> addDiretor(@RequestBody Diretor diretor){
        return ResponseEntity.ok().body(diretorService.addDiretor(diretor));
    }
}
