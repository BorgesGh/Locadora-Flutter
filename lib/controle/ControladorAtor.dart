
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
  List<Ator> atores = [];

  late BuildContext context;


  ControladorAtor(){
    atorService = AtorService();
  }

  Future<List<Ator>> getAtores() async{

    ResponseEntity<List<Ator>> responseEntity = await atorService.getAll();

    atores = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(atores);

    return atores;

  }

  Future<void> inserirAtor({required String nome, int? id}) async {
    Ator novoAtor = Ator(nome: nome);
    ResponseEntity<Ator> atorRes = await atorService.inserir(novoAtor);

    Ator? ator = atorRes.resultado;

    atores.add(ator!);

    _controladorStream.add(atores);

  }

  Future<void> editarAtor({required String novoNome, required int id}) async {
    Ator? alvo;

    for (Ator ator in atores) {
      if (ator.idAtor == id) {
        alvo = ator;
      }
    }

    if (alvo != null) {
      alvo.nome = novoNome;

      ResponseEntity<Ator> response = await atorService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o ator modificado
        _controladorStream.add(atores);
      }
    }
  }

  Future<ResponseEntity> excluirAtor (Ator ator) async{
    return atorService.delete(ator);
  }

}