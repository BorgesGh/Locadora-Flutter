
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorAtor.dart';
import 'package:locadora_dw2/controle/ControladorClasse.dart';
import 'package:locadora_dw2/controle/ControladorDiretor.dart';
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
  List<String> categorias = ["Terror", "Comedia", "Animação", "Suspense", "Aventura", "Policial", "Drama","Ficção Científica"];

  // controllers
  final nameTituloController = TextEditingController();
  final yearController = TextEditingController();
  final sinopseController = TextEditingController();
  final _controladorStream = StreamController<List<Titulo>>();

  final atorsController = ControladorAtor();
  final diretorController = ControladorDiretor();
  final classeController = ControladorClasse();

  final streamAtores = StreamController<List<Ator>>();
  final streamDiretor = StreamController<List<Diretor>>();
  final streamClasse = StreamController<List<Classe>>();
  final streamCategoria = StreamController<List<String>>();

  Stream<List<Titulo>> get fluxo => _controladorStream.stream;
  int? idController = -1;
  String operationController = Operacoes.Enviar.name;

  // Auxs
  List<Ator>? selectedAtors;
  Diretor? selectedDiretor;
  Classe? selectedClasse;
  String? selectedCategoria;

  late TituloService tituloService;

  ControladorTitulo() {
    tituloService = TituloService();

    atorsController.getAtores().then((ators) { streamAtores.add(ators); });
    diretorController.getDiretores().then((diretors) { streamDiretor.add(diretors); });
    classeController.getClasses().then((classe) { streamClasse.add(classe); });
    streamCategoria.add(categorias);

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


    Titulo? alvo;

    // alvo = diretores.map((Diretor) => Diretor.id == id) as Diretor?;

    for (Titulo tit in titulos) {
      if (tit.idTitulo == titulo.idTitulo) {
        alvo = tit;
      }
    }

    if (alvo != null) {
      alvo.nome = titulo.nome;
      alvo.atores = titulo.atores;
      alvo.categoria = titulo.categoria;
      alvo.diretor = titulo.diretor;
      alvo.sinopse = titulo.sinopse;
      alvo.ano = titulo.ano;
      alvo.classe = titulo.classe;

      ResponseEntity<Titulo> response = await tituloService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o Diretor modificado
        _controladorStream.add(titulos);
      }
    }
  }

  Future<void> excluirTitulo(Titulo titulo) async{
    tituloService.delete(titulo);

  }

  List<String> getColluns(){
    return ["Titulo", "Ano", "Sinopse", "Diretor", "Classe", "Categoria", "Atores","Opções"];
  }

}