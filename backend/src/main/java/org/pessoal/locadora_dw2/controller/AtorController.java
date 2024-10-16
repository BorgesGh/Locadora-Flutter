package org.pessoal.locadora_dw2.controller;

import org.pessoal.locadora_dw2.domain.Ator;
import org.pessoal.locadora_dw2.dto.AtorDTO;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.pessoal.locadora_dw2.service.AtorService;

import java.util.List;

@RestController()
public class AtorController {

    private AtorService atorService;

    public AtorController(AtorService atorService) {
        this.atorService = atorService;
    }

    @GetMapping("/ator/getAll")
    public ResponseEntity<List<Ator>> getAtores(){
        try {
            return ResponseEntity.ok().body(atorService.getAtores());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/ator/update")
    public ResponseEntity<Ator> updateAtor(@RequestBody Ator ator){

        atorService.update(ator);

        return ResponseEntity.ok().body(ator);
    }

    @DeleteMapping("/ator/delete")
    public ResponseEntity deleteAtor(@RequestBody Ator ator){
        atorService.delete(ator);
        return ResponseEntity.ok().body(null);
    }

    @PostMapping("/ator/add")
    public ResponseEntity<Ator> addAtor(@RequestBody Ator ator){
        System.out.println(ator.toString());

//        Ator atorN = new Ator((String) ator.get("nome"));

        return ResponseEntity.ok().body(atorService.addAtor(ator));
    }


}
