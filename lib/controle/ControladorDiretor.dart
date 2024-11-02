
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/service/DiretorService.dart';
import '../utils/ResponseEntity.dart';

class ControladorDiretor{


  final _controladorStream = StreamController<List<Diretor>>();
  Stream<List<Diretor>> get fluxo => _controladorStream.stream;

  late DiretorService diretorService;
  late List<Diretor> diretores = [];
  late BuildContext context;


  ControladorDiretor(){
    diretorService = DiretorService();
  }

  Future<List<Diretor>> getDiretores() async{

    ResponseEntity<List<Diretor>> responseEntity = await diretorService.getAll();

    diretores = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(diretores);

    return diretores;

  }

  Future<void> inserirDiretor({required String nome, int? id}) async {
    var novoDiretor = Diretor(nome: nome);
    ResponseEntity<Diretor> diretor = await diretorService.inserir(novoDiretor);

    Diretor? dir = diretor.resultado;

    diretores.add(dir!);

    _controladorStream.add(diretores);

  }

  Future<void> editarDiretor({required String novoNome, required int id}) async {
    Diretor? alvo;

    // alvo = diretores.map((Diretor) => Diretor.id == id) as Diretor?;

    for (Diretor diretor in diretores) {
      if (diretor.idDiretor == id) {
        alvo = diretor;
      }
    }

    if (alvo != null) {
      alvo.nome = novoNome;

      ResponseEntity<Diretor> response = await diretorService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o Diretor modificado
        _controladorStream.add(diretores);
      }
    }
  }

  Future<ResponseEntity> excluirDiretor (Diretor diretor) async{

    return diretorService.delete(diretor);

  }
}