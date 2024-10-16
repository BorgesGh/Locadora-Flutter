package org.pessoal.locadora_dw2.controller;

import org.pessoal.locadora_dw2.domain.Diretor;
import org.pessoal.locadora_dw2.service.DiretorService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class DiretorController {
    private DiretorService DiretorService;

    public DiretorController(DiretorService DiretorService) {
        this.DiretorService = DiretorService;
    }

    @GetMapping("/diretor/getAll")
    public ResponseEntity<List<Diretor>> getDiretores(){
        try {
            return ResponseEntity.ok().body(DiretorService.getDiretores());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/diretor/update")
    public ResponseEntity<Diretor> updateDiretor(@RequestBody Diretor Diretor){

        DiretorService.update(Diretor);

        return ResponseEntity.ok().body(Diretor);
    }

    @DeleteMapping("/diretor/delete")
    public ResponseEntity deleteDiretor(@RequestBody Diretor Diretor){
        DiretorService.delete(Diretor);
        return ResponseEntity.ok().body(null);
    }

    @PostMapping("/diretor/add")
    public ResponseEntity<Diretor> addDiretor(@RequestBody Diretor Diretor){
        return ResponseEntity.ok().body(DiretorService.addDiretor(Diretor));
    }
}
