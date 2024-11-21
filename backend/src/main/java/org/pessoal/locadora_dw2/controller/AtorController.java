package org.pessoal.locadora_dw2.controller;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.pessoal.locadora_dw2.domain.Ator;
import org.pessoal.locadora_dw2.exceptions.ElementoJaReferenciado;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.pessoal.locadora_dw2.service.AtorService;

import java.util.List;

@OpenAPIDefinition(
        info = @Info(
                title = "Locadora",
                version = "1.0.0",
                description = "Trabalho acadêmico",
                contact = @Contact(name = "Desenvolvedor: Ghabriel Borges Campi", email = "ghabrielbc@gmail.com")
        )
)
@RestController
@Tag(name = "Controlador de Atores", description = "Controller que manipula todos os end-points de Ator")
public class AtorController {

    private AtorService atorService;

    public AtorController(AtorService atorService) {
        this.atorService = atorService;
    }

    @Operation(description = "Listagem de todos os atores")
    @GetMapping("/ator/getAll")
    public ResponseEntity<List<Ator>> getAtores(){
        try {
            return ResponseEntity.ok().body(atorService.getAtores());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Operation(description = "Atualização de um ator existente")
    @PutMapping("/ator/update")
    public ResponseEntity<Ator> updateAtor(@RequestBody Ator ator){
        atorService.update(ator);
        return ResponseEntity.ok().body(ator);
    }

    @Operation(description = "Exclusão de um ator")
    @DeleteMapping("/ator/delete")
    public ResponseEntity<String> deleteAtor(@RequestBody Ator ator){
        try {
            atorService.delete(ator);
            return ResponseEntity.ok().body("Ator deletado com sucesso!");

        }catch (ElementoJaReferenciado e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

    @Operation(description = "Adição de um novo ator")
    @PostMapping("/ator/add")
    public ResponseEntity<Ator> addAtor(@RequestBody Ator ator){
        return ResponseEntity.ok().body(atorService.addAtor(ator));
    }
}

