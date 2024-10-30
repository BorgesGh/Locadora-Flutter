
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/model/Titulo.dart';
import 'package:locadora_dw2/service/ClasseService.dart';
import 'package:locadora_dw2/service/TituloService.dart';

import '../model/Ator.dart';
import '../model/Classe.dart';
import '../model/Diretor.dart';
import '../utils/ResponseEntity.dart';
enum Operacoes{
  Enviar,
  Editar
}

class ControladorTitulo{

  final formKey = GlobalKey<FormState>();

  // Lists
  List<Titulo> titulos = [];
  List<Ator> atores = [];
  List<Diretor> diretores = [];
  List<Classe> classes =[];

  // controllers
  final nameTituloController = TextEditingController();
  final yearController = TextEditingController();
  final sinopseController = TextEditingController();
  final _controladorStream = StreamController<List<Titulo>>();
  Stream<List<Titulo>> get fluxo => _controladorStream.stream;

  int? idController = -1;
  String operationController = Operacoes.Enviar.name;

  // Auxs
  List<Ator>? selectedAtors;
  Diretor? selectedDiretor;
  Classe? selectedClasse;
  String? selectedCategoria;

  late TituloService tituloService;

  ControladorTitulo(){
    tituloService = TituloService();
  }

  Future<ResponseEntity<List<Titulo>>> getTitulos() async{

    ResponseEntity<List<Titulo>> responseEntity = await tituloService.getAll();
    titulos = responseEntity.resultado ?? []; // Caso o resultado venha vazio...
    _controladorStream.add(titulos);

    return responseEntity;

  }

  Future<void> inserirTitulo({required Titulo tituloNew}) async {

    ResponseEntity<Titulo> response = await tituloService.inserir(tituloNew);
    Titulo? titulo = response.resultado;

    titulos.add(titulo!);
    _controladorStream.add(titulos);

  }

  Future<void> editarTitulo({required Titulo titulo}) async {


    ResponseEntity<Titulo> response = await tituloService.update(titulo);
    if (response.sucesso) {
      // Atualizar a lista local com o Titulo modificado
      _controladorStream.add(titulos);
    }
  }

  Future<void> excluirTitulo(Titulo titulo) async{
    tituloService.delete(titulo);

  }

  VoidCallback getOnTap(){
    return
  }

}