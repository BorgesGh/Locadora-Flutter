package org.pessoal.locadora_dw2.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.pessoal.locadora_dw2.domain.Titulo;
import org.pessoal.locadora_dw2.service.TituloService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Tag(name = "Controlador de Titulo", description = "Controller que manipula todos os end-points de Titulo")
public class TituloController {

    TituloService tituloService;
    public TituloController(TituloService tituloService) {
        this.tituloService = tituloService;
    }

    @Operation(description = "Listagem de Titulos")
    @GetMapping("/titulo/getAll")
    public ResponseEntity<List<Titulo>> getAll() {
        try {
            return ResponseEntity.ok().body(tituloService.getTitulos());
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Operation(description = "Update de um titulo alterado.")
    @PutMapping("/titulo/update")
    public ResponseEntity<Titulo> update(@RequestBody Titulo titulo) {
        try {
            tituloService.update(titulo);
            return ResponseEntity.ok().body(titulo);
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @Operation(description = "Delete de um Titulo")
    @DeleteMapping("/titulo/delete")
    public ResponseEntity<String> delete(@RequestBody Titulo titulo) {
        try {
            tituloService.delete(titulo);
            return ResponseEntity.ok().body("Titulo deletado com sucesso!");
        }catch (Exception e) {

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @Operation(description = "Adição de um novo titulo")
    @PostMapping("/titulo/add")
    public ResponseEntity<Titulo> add(@RequestBody Titulo titulo) {
        try {
            return ResponseEntity.ok().body(tituloService.addTitulo(titulo));
        }catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

}
