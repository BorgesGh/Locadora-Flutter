
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/service/AtorService.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';

class ControladorAtor{

  final _controladorStream = StreamController<ResponseEntity>();
  Stream<ResponseEntity> get fluxo => _controladorStream.stream;

  late AtorService atorService;
  late List<Ator> _atores;
  late BuildContext context;


  ControladorAtor(){
    atorService = AtorService();
  }

  Future<ResponseEntity<List<Ator>>> getAtores() async{

    ResponseEntity<List<Ator>> responseEntity = await atorService.getAll();

    _atores = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(responseEntity);

    return responseEntity;

  }

  Future<void> inserirAtor({required String nome, int? id}) async {
    Ator novoAtor = Ator(nome: nome);
    ResponseEntity<Ator> ator = await atorService.inserir(novoAtor);

    _controladorStream.add(ator);

  }

  Future<void> editarAtor({required String novoNome, required int id}) async {
    Ator? alvo;

    // alvo = _atores.map((ator) => ator.id == id) as Ator?;

    for (Ator ator in _atores) {
      if (ator.id == id) {
        alvo = ator;
      }
    }

    if (alvo != null) {
      alvo.nome = novoNome;

      ResponseEntity<Ator> response = await atorService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o ator modificado
        _controladorStream.add(ResponseEntity(_atores));
      }
    }
  }

  Future<void> excluirAtor (Ator ator) async{

    atorService.delete(ator);

  }

}