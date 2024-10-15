
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/service/AtorService.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';

class ControladorAtor{

  final _controladorStream = StreamController<List<Ator>>(); // Aqui é lista de atores

  //Enviar os atores TODOS no add() do Stream. Não apenas 1 indivíduo.


  Stream<List<Ator>> get fluxo => _controladorStream.stream;

  late AtorService atorService;
  List<Ator> _atores = [];

  List<Ator> get atores => _atores;

  late BuildContext context;


  ControladorAtor(){
    atorService = AtorService();
  }

  Future<ResponseEntity<List<Ator>>> getAtores() async{

    ResponseEntity<List<Ator>> responseEntity = await atorService.getAll();

    _atores = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(_atores);

    return responseEntity;

  }

  Future<void> inserirAtor({required String nome, int? id}) async {
    Ator novoAtor = Ator(nome: nome);
    ResponseEntity<Ator> atorRes = await atorService.inserir(novoAtor);

    Ator? ator = atorRes.resultado;

    _atores.add(ator!);

    _controladorStream.add(_atores);

  }

  Future<void> editarAtor({required String novoNome, required int id}) async {
    Ator? alvo;

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
        _controladorStream.add(_atores);
      }
    }
  }

  Future<void> excluirAtor (Ator ator) async{
    atorService.delete(ator);

  }

}