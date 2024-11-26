import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/model/Classe.dart';

import '../service/ClasseService.dart';
import '../utils/ResponseEntity.dart';

class ControladorClasse {
  final _controladorStream = StreamController<List<Classe>>();
  final streamDate = StreamController<DateTime>();

  Stream<List<Classe>> get fluxo => _controladorStream.stream;

  late ClasseService classeService;
  late List<Classe> classes = [];
  late BuildContext context;

  final nomeClasseController = TextEditingController();
  final valorClasseController = TextEditingController();
  final dataClasseController = TextEditingController();

  int idController = -1;

  ControladorClasse() {
    classeService = ClasseService();
  }

  Future<List<Classe>> getClasses() async {
    ResponseEntity<List<Classe>> responseEntity = await classeService.getAll();

    classes = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    _controladorStream.add(classes);

    return classes;
  }

  Future<void> inserirClasse(
      {required String nome,
      int? id,
      required double valor,
      required DateTime dataDevolucao}) async {
    var novoClasse = Classe(
        idClasse: id, nome: nome, valor: valor, dataDevolucao: dataDevolucao);
    ResponseEntity<Classe> classe = await classeService.inserir(novoClasse);

    Classe? dir = classe.resultado;

    classes.add(dir!);

    _controladorStream.add(classes);
  }

  Future<void> editarClasse(
      {required String novoNome,
      required int id,
      required double valor,
      required DateTime data}) async {
    Classe? alvo;

    // alvo = _Classees.map((Classe) => Classe.id == id) as Classe?;

    for (Classe classe in classes) {
      if (classe.idClasse == id) {
        alvo = classe;
      }
    }

    if (alvo != null) {
      alvo.nome = novoNome;
      alvo.valor = valor;
      alvo.dataDevolucao = data;

      ResponseEntity<Classe> response = await classeService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o Classe modificado
        _controladorStream.add(classes);
      }
    }
  }

  Future<ResponseEntity> excluirClasse(Classe classe) async {
    return classeService.delete(classe);
  }
}
