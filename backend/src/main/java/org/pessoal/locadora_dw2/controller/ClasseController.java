package org.pessoal.locadora_dw2.controller;

import org.pessoal.locadora_dw2.domain.Classe;
import org.pessoal.locadora_dw2.service.ClasseService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ClasseController {
    private ClasseService classeService;

    public ClasseController(ClasseService classeService) {
        this.classeService = classeService;
    }

    @GetMapping("/classe/getAll")
    public ResponseEntity<List<Classe>> getClassees(){
        try {
            return ResponseEntity.ok().body(classeService.getClassees());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/classe/update")
    public ResponseEntity<Classe> updateClasse(@RequestBody Classe classe){

        classeService.update(classe);

        return ResponseEntity.ok().body(classe);
    }

    @DeleteMapping("/classe/delete")
    public ResponseEntity deleteClasse(@RequestBody Classe classe){
        classeService.delete(classe);
        return ResponseEntity.ok().body(null);
    }

    @PostMapping("/classe/add")
    public ResponseEntity<Classe> addClasse(@RequestBody Classe classe){
        return ResponseEntity.ok().body(classeService.addClasse(classe));
    }
}
