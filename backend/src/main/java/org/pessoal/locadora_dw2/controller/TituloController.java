package org.pessoal.locadora_dw2.controller;

import org.pessoal.locadora_dw2.domain.Titulo;
import org.pessoal.locadora_dw2.service.TituloService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class TituloController {

    TituloService tituloService;
    public TituloController(TituloService tituloService) {
        this.tituloService = tituloService;
    }

    @GetMapping("/titulo/getAll")
    public ResponseEntity<List<Titulo>> getAll() {
        try {
            return ResponseEntity.ok().body(tituloService.getTitulos());
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/titulo/update")
    public ResponseEntity<Titulo> update(@RequestBody Titulo titulo) {
        try {
            tituloService.update(titulo);
            return ResponseEntity.ok().body(titulo);
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @DeleteMapping("/titulo/delete")
    public ResponseEntity<String> delete(@RequestBody Titulo titulo) {
        try {
            tituloService.delete(titulo);
            return ResponseEntity.ok().body("Titulo deletado com sucesso!");
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PostMapping("/titulo/add")
    public ResponseEntity<Titulo> add(@RequestBody Titulo titulo) {
        try {
            return ResponseEntity.ok().body(tituloService.addTitulo(titulo));
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

}
