package org.pessoal.locadora_dw2.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.pessoal.locadora_dw2.domain.Classe;
import org.pessoal.locadora_dw2.service.ClasseService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "Controlador de Classe", description = "Controller que manipula todos os end-points de Classe")
public class ClasseController {
    private ClasseService classeService;

    public ClasseController(ClasseService classeService) {
        this.classeService = classeService;
    }

    @Operation(description = "Listagem de todas as classes")
    @GetMapping("/classe/getAll")
    public ResponseEntity<List<Classe>> getClassees(){
        try {
            return ResponseEntity.ok().body(classeService.getClassees());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Atualização de uma classe existente")
    @PutMapping("/classe/update")
    public ResponseEntity<Classe> updateClasse(@RequestBody Classe classe){
        classeService.update(classe);
        return ResponseEntity.ok().body(classe);
    }

    @Operation(description = "Exclusão de uma classe")
    @DeleteMapping("/classe/delete")
    public ResponseEntity<String> deleteClasse(@RequestBody Classe classe){
        classeService.delete(classe);
        return ResponseEntity.ok().body("Classe deletada com sucesso!");
    }

    @Operation(description = "Adição de uma nova classe")
    @PostMapping("/classe/add")
    public ResponseEntity<Classe> addClasse(@RequestBody Classe classe){
        return ResponseEntity.ok().body(classeService.addClasse(classe));
    }
}
