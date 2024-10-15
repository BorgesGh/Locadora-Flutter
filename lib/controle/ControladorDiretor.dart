
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/service/DiretorService.dart';
import '../utils/ResponseEntity.dart';

class ControladorDiretor{


  final _controladorStream = StreamController<List<Diretor>>();
  Stream<List<Diretor>> get fluxo => _controladorStream.stream;

  late DiretorService diretorService;
  late List<Diretor> _diretores;
  late BuildContext context;


  ControladorDiretor(){
    diretorService = DiretorService();
  }

  Future<ResponseEntity<List<Diretor>>> getDiretores() async{

    ResponseEntity<List<Diretor>> responseEntity = await diretorService.getAll();

    _diretores = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(_diretores);

    return responseEntity;

  }

  Future<void> inserirDiretor({required String nome, int? id}) async {
    var novoDiretor = Diretor(nome: nome);
    ResponseEntity<Diretor> diretor = await diretorService.inserir(novoDiretor);

    Diretor? dir = diretor.resultado;

    _diretores.add(dir!);

    _controladorStream.add(_diretores);

  }

  Future<void> editarDiretor({required String novoNome, required int id}) async {
    Diretor? alvo;

    // alvo = _Diretores.map((Diretor) => Diretor.id == id) as Diretor?;

    for (Diretor diretor in _diretores) {
      if (diretor.id == id) {
        alvo = diretor;
      }
    }

    if (alvo != null) {
      alvo.nome = novoNome;

      ResponseEntity<Diretor> response = await diretorService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o Diretor modificado
        _controladorStream.add(_diretores);
      }
    }
  }

  Future<void> excluirDiretor (Diretor diretor) async{

    diretorService.delete(diretor);

  }
}